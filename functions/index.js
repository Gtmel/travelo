const functions = require("firebase-functions");
const admin = require("firebase-admin");
const axios = require('axios');

admin.initializeApp();

const firestore = admin.firestore();

exports.webhook = functions.https.onRequest(async (request, response) => {
    const body =  request.body ;

    // Create a new document with the callback info
    const newCallback = firestore.collection('MCP_callback').doc();
    await newCallback.set(body);
    console.log('New MCP_callback added');

});

exports.transactionStatus = functions.firestore.document('/MCP_callback/{doc}').onCreate(async (snapshot,context) => {
    
    const row = snapshot.data();

    if(row.transaction_type == "PAYOUT"){
        return Promise.resolve();
    }
    // Create a reference to the transactions collection
    const queryRef = firestore.collection('transactions');
      
    // Create a query against the transaction collection
    const snapshots = await queryRef.where('MCP_ref', '==', row.transaction_ref).get();
        
    if (snapshots.empty) {
        console.log('No matching documents.');
        return Promise.resolve();
    } 
        
    //Get the transaction and its fields
    const transaction = snapshots.docs[0];
    const voyageRef = transaction.get("voyage_ref");
    const uRef = transaction.get("user_ref");
      
    //Conserve the current time
    const date= new Date(Date.now());
      
    //Update the transaction status
    await transaction.ref.update({
        status: row.transaction_status ,
        modified_at: date
    });
    console.log('transaction status modified') ;
    
        
    //Get the date of the voyage
    const voyagedoc = await voyageRef.get();
    const depart = voyagedoc.get('dateDepart') ;
        
    //Create reservation if transaction succeeded
    if (row.transaction_status == "SUCCESS"){
        console.log("creating reservation");
        await voyageRef.collection("reservation").add({ 
            created_at: date ,
            user_ID: uRef,
            status: "En attente",
            date_voyage: depart ,
            payment: row.transaction_amount
        });
        console.log('reservation created')   
    }
})

exports.checkReservations = functions.pubsub
  .schedule('0 */8 * * *')
  .onRun(async context => {
      
    // Compute the time limit for non answered reservations
    const dateLimite = new Date(Date.now()) ;
    dateLimite.setHours(dateLimite.getHours() - 8) ;
    console.log(dateLimite);

    // Query for the reservations not answered above the time limit
    const querySnapshot = await firestore.collectionGroup('reservation')
                                        .where('status', '==' , 'En attente')
                                        .where('created_at', '<=', dateLimite)
                                        .get();
    
    // If no results log empty                                    
    if (querySnapshot.empty) {
        console.log('No matching reservation documents found.');
    }

    querySnapshot.forEach(async (doc) => {

        // Update the reservation status
         await doc.ref.update({
            status: "Sans réponse" ,
            modified_at: new Date(Date.now())
        });

        //Get the name of the user
        const voyageRef = doc.ref.parent.parent ;
        const driverRef = (await voyageRef.get()).data().chauffeur ;
        const driverName = (await driverRef.get()).data().display_name ;
    
        // Notify the user of the new status
        const uRef = doc.get("user_ID"); 

        await firestore.collection('ff_push_notifications').add({
            initial_page_name: 'Rechercher',
            notification_text: `${driverName} n\'a pas répondu à votre demande à temps, pas grave réservez vite un autre trajet`,
            notification_title: 'Désolé',
            timestamp: new Date(Date.now()),
            user_refs: uRef
        });
        console.log('Notification envoyée') ;

        // Get the data of the user to refund to
        const data = (await uRef.get()).data() ;
        
        // Add a transaction document for the refund
        const transRef = await firestore.collection('transactions').add({
            amount: doc.get("payment"),
            type: 'Remboursement',
            numero: data.phone_number,
            voyageRef: voyageRef,
            userRef: uRef,
            createdAt: new Date(Date.now()),
            status: 'Sent',
        });
        
        // Refund for the reservation
        const info = {
            'reason':'Remboursement',
            'amount': doc.get("payment"),
            'transaction_ref' : transRef ,
            'customer_name' : data.display_name,
            'phone_number' : data.phone_number
        };
        payout(info) ;

        console.log('payout done');
        return Promise.resolve() ;
    });
})

exports.scheduledPayments = functions.pubsub
  .schedule('0 */12 * * *')
  .onRun(async context => {

    // Compute the time limit for finished trips
    const dateLimInf = new Date(Date.now()) ;
    const dateLimSup = new Date(Date.now()) ;
    dateLimInf.setHours(dateLimInf.getHours() - 24) ;
    dateLimSup.setHours(dateLimSup.getHours() - 12) ;

    // Query for the non paid finished trips
    const querySnapshot = await firestore.collection('voyage')
                                         .where('dateDepart', '>=' , dateLimInf)
                                         .where('dateDepart', '<', dateLimSup)
                                         .where('paid', '==' , false)
                                         .get();
 
    // If query has no results                                    
    if (querySnapshot.empty) {
       console.log('No matching voyage document found.');
       return Promise.resolve();
    }

    querySnapshot.forEach(async (doc) => {
        
        // Collect info for the payment
        const voyageData = doc.data() ;
        
        // Check if there are any passengers 
        if (typeof(voyageData.passengers) == 'object') {
            const userRef = voyageData.chauffeur ;        
            const driverData = (await userRef.get()).data() ;
            const numPassengers = voyageData.passengers.length ;
            const tarif = voyageData.prix - 500 ;

            // Add a transaction document to save the payment
            const transRef = await firestore.collection('transactions').add({
                amount: numPassengers * tarif,
                type: 'Remboursement',
                numero: driverData.phone_number,
                voyageRef: doc.ref,
                userRef: userRef,
                createdAt: new Date(Date.now()),
                status: 'SENT',
            });
        
            // Send payment to the driver
            const info = {
                'reason':'Paiement',
                'amount': numPassengers * tarif,
                'transaction_ref' : transRef ,
                'customer_name' : driverData.display_name,
                'phone_number' : driverData.phone_number
            };

            payout(info) ;
            
        }

        // Update the voyage paid state
        await doc.ref.update({
            paid: true ,
            modified_at: new Date(Date.now())
        });
        console.log('Updated paid to true');
        return Promise.resolve();;
    })
})


async function payout (info) {
    
    await axios({
        method: 'post',
        url: 'https://my-coolpay.com/api/77d9f4a6-fccc-44ea-92b0-e9bd4a218a42/payout',
        data: {
            private_key : 'bqMz8r0zvJmJFv7bcvpm0qrhStcQcgr6SOyvfidpG89WNwwN0fzPK5A9yydej4ov',
            transaction_amount :  info.amount,
            transaction_reason :  info.reason, 
            app_transaction_ref :  info.transaction_ref,
            customer_name : info.customer_name,
            customer_phone_number : info.phone_number
        }
      });
}
