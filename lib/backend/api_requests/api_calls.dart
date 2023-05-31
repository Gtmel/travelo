import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start coolpay Group Code

class CoolpayGroup {
  static String baseUrl =
      'https://my-coolpay.com/api/77d9f4a6-fccc-44ea-92b0-e9bd4a218a42';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  static PayinCall payinCall = PayinCall();
  static AuthorizeCall authorizeCall = AuthorizeCall();
  static CheckCall checkCall = CheckCall();
  static PayoutCall payoutCall = PayoutCall();
}

class PayinCall {
  Future<ApiCallResponse> call({
    int? montant,
    String? numero = '',
    String? name = '',
    String? myRef = '',
  }) {
    final body = '''
{
  "transaction_amount": ${montant},
  "customer_phone_number": "${numero}",
  "app_transaction_ref": "${myRef}",
  "customer_name": "${name}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'payin',
      apiUrl: '${CoolpayGroup.baseUrl}/payin',
      callType: ApiCallType.POST,
      headers: {
        ...CoolpayGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic action(dynamic response) => getJsonField(
        response,
        r'''$.action''',
      );
  dynamic ussd(dynamic response) => getJsonField(
        response,
        r'''$.ussd''',
      );
  dynamic mCPref(dynamic response) => getJsonField(
        response,
        r'''$.transaction_ref''',
      );
}

class AuthorizeCall {
  Future<ApiCallResponse> call({
    String? ref = '',
    String? code = '',
  }) {
    final body = '''
{
  "transaction_ref": "${ref}",
  "code": "${code}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'authorize',
      apiUrl: '${CoolpayGroup.baseUrl}/payin/authorize',
      callType: ApiCallType.POST,
      headers: {
        ...CoolpayGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic ussd(dynamic response) => getJsonField(
        response,
        r'''$.ussd''',
      );
  dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.action''',
      );
}

class CheckCall {
  Future<ApiCallResponse> call({
    String? mCPRef = '',
  }) {
    final body = '''
{
  "transaction_ref": "${mCPRef}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'check',
      apiUrl: '${CoolpayGroup.baseUrl}/checkStatus',
      callType: ApiCallType.POST,
      headers: {
        ...CoolpayGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.transaction_status''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.transaction_message''',
      );
}

class PayoutCall {
  Future<ApiCallResponse> call({
    int? montant,
    String? nom = '',
    String? numero = '',
    String? raison = '',
  }) {
    final body = '''
{
    "private_key": "bqMz8r0zvJmJFv7bcvpm0qrhStcQcgr6SOyvfidpG89WNwwN0fzPK5A9yydej4ov",
    "transaction_amount": ${montant},
    "transaction_reason": "${raison}",
    "customer_name": "${nom}",
    "customer_phone_number": "${numero}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'payout',
      apiUrl: '${CoolpayGroup.baseUrl}/payout',
      callType: ApiCallType.POST,
      headers: {
        ...CoolpayGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End coolpay Group Code

class ItineraireCall {
  static Future<ApiCallResponse> call({
    String? origin = '',
    String? destination = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'itineraire',
      apiUrl: 'https://maps.googleapis.com/maps/api/directions/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'key': "AIzaSyAwWxMeNLRW_5YIrgrUKsRYGbz6DkHKEZ8",
        'origin': origin,
        'destination': destination,
        'mode': "driving",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic route(dynamic response) => getJsonField(
        response,
        r'''$.routes''',
        true,
      );
  static dynamic duration(dynamic response) => getJsonField(
        response,
        r'''$.routes[:].legs[:].duration.text''',
      );
  static dynamic duree(dynamic response) => getJsonField(
        response,
        r'''$.routes[:].legs[:].duration.value''',
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
