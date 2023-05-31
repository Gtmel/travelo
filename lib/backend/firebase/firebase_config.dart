import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCLFbLBpzMzycETE4HIDNYT5QyzOrRFjnQ",
            authDomain: "camgo-1893e.firebaseapp.com",
            projectId: "camgo-1893e",
            storageBucket: "camgo-1893e.appspot.com",
            messagingSenderId: "514802975601",
            appId: "1:514802975601:web:1d7c6a1a760fba9b806cd0",
            measurementId: "G-HNQ6X5NQQV"));
  } else {
    await Firebase.initializeApp();
  }
}
