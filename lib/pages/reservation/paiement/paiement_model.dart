import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaiementModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  String? ref;

  bool payOK = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ce champ est requis';
    }

    if (val.length < 9) {
      return 'Requires at least 9 characters.';
    }
    if (val.length > 13) {
      return 'Maximum 13 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (payin)] action in Button widget.
  ApiCallResponse? payin;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TransactionsRecord? transaction;
  // Stores action output result for [Backend Call - API (check)] action in Text widget.
  ApiCallResponse? check;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  void dispose() {
    textController?.dispose();
  }

  /// Additional helper methods are added here.

}
