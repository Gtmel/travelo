import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Image.asset(
            'assets/images/travelo.jpg',
            fit: BoxFit.contain,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'VerificationSMS': (data) async => ParameterData(
        allParams: {
          'phoneNumber': getParameter<String>(data, 'phoneNumber'),
        },
      ),
  'CreerProfil': ParameterData.none(),
  'PasseOublie': ParameterData.none(),
  'Rechercher': ParameterData.none(),
  'AjouterTrajet': ParameterData.none(),
  'MesTrajets': ParameterData.none(),
  'Destination': (data) async => ParameterData(
        allParams: {},
      ),
  'Messages': ParameterData.none(),
  'Parametres': ParameterData.none(),
  'HeureDepart': (data) async => ParameterData(
        allParams: {
          'dateDepart': getParameter<DateTime>(data, 'dateDepart'),
          'retour': getParameter<bool>(data, 'retour'),
        },
      ),
  'DateDepart': (data) async => ParameterData(
        allParams: {
          'dateDepart': getParameter<DateTime>(data, 'dateDepart'),
          'retour': getParameter<bool>(data, 'retour'),
        },
      ),
  'PlacesDispo': (data) async => ParameterData(
        allParams: {
          'dateDepart': getParameter<DateTime>(data, 'dateDepart'),
          'heureDepart': getParameter<DateTime>(data, 'heureDepart'),
          'retour': getParameter<bool>(data, 'retour'),
        },
      ),
  'Tarifs': (data) async => ParameterData(
        allParams: {
          'dateDepart': getParameter<DateTime>(data, 'dateDepart'),
          'heureDepart': getParameter<DateTime>(data, 'heureDepart'),
          'placesDispo': getParameter<int>(data, 'placesDispo'),
          'retour': getParameter<bool>(data, 'retour'),
        },
      ),
  'TrajetRetour': (data) async => ParameterData(
        allParams: {
          'dateDepart': getParameter<DateTime>(data, 'dateDepart'),
          'duree': getParameter<int>(data, 'duree'),
        },
      ),
  'Recapitulatif': (data) async => ParameterData(
        allParams: {
          'dateDepart': getParameter<DateTime>(data, 'dateDepart'),
          'heureDepart': getParameter<DateTime>(data, 'heureDepart'),
          'placesDispo': getParameter<int>(data, 'placesDispo'),
          'prix': getParameter<int>(data, 'prix'),
          'retour': getParameter<bool>(data, 'retour'),
        },
      ),
  'resultatRecherche': (data) async => ParameterData(
        allParams: {
          'departVille': getParameter<String>(data, 'departVille'),
          'destinationVille': getParameter<String>(data, 'destinationVille'),
          'places': getParameter<int>(data, 'places'),
          'dateDepart': getParameter<DateTime>(data, 'dateDepart'),
        },
      ),
  'trajetDetails': (data) async => ParameterData(
        allParams: {
          'voyage': getParameter<DocumentReference>(data, 'voyage'),
          'places': getParameter<int>(data, 'places'),
          'reservationID':
              getParameter<DocumentReference>(data, 'reservationID'),
          'isDriver': getParameter<bool>(data, 'isDriver'),
        },
      ),
  'conversation': (data) async => ParameterData(
        allParams: {
          'chatRef': getParameter<DocumentReference>(data, 'chatRef'),
          'chatUser': await getDocumentParameter<UsersRecord>(
              data, 'chatUser', UsersRecord.fromSnapshot),
        },
      ),
  'Reservation': (data) async => ParameterData(
        allParams: {
          'voyage': await getDocumentParameter<VoyageRecord>(
              data, 'voyage', VoyageRecord.fromSnapshot),
          'reservationID':
              getParameter<DocumentReference>(data, 'reservationID'),
          'isDriver': getParameter<bool>(data, 'isDriver'),
          'prix': getParameter<int>(data, 'prix'),
        },
      ),
  'Annulation': (data) async => ParameterData(
        allParams: {
          'voyageID': getParameter<DocumentReference>(data, 'voyageID'),
        },
      ),
  'ReservationOK': (data) async => ParameterData(
        allParams: {
          'voyage': await getDocumentParameter<VoyageRecord>(
              data, 'voyage', VoyageRecord.fromSnapshot),
        },
      ),
  'Avis': ParameterData.none(),
  'Historique': ParameterData.none(),
  'ajouterAvis': (data) async => ParameterData(
        allParams: {
          'destinataire': getParameter<DocumentReference>(data, 'destinataire'),
        },
      ),
  'Verification_profil': ParameterData.none(),
  'profil_verifie': ParameterData.none(),
  'paiement': (data) async => ParameterData(
        allParams: {
          'prix': getParameter<int>(data, 'prix'),
          'voyage': await getDocumentParameter<VoyageRecord>(
              data, 'voyage', VoyageRecord.fromSnapshot),
        },
      ),
  'codeOTP': (data) async => ParameterData(
        allParams: {
          'voyage': await getDocumentParameter<VoyageRecord>(
              data, 'voyage', VoyageRecord.fromSnapshot),
          'mcpRef': getParameter<String>(data, 'mcpRef'),
          'myTransactionRef':
              getParameter<DocumentReference>(data, 'myTransactionRef'),
        },
      ),
  'Transactions': ParameterData.none(),
  'Support': ParameterData.none(),
  'Authentification': ParameterData.none(),
  'ModifierProfil': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
