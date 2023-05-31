import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/trajet_detail/trajet_detail_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TrajetDetailsModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  int? placesDispo;

  ///  State fields for stateful widgets in this page.

  // Model for trajetDetail component.
  late TrajetDetailModel trajetDetailModel;
  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    trajetDetailModel = createModel(context, () => TrajetDetailModel());
  }

  void dispose() {
    trajetDetailModel.dispose();
    textController?.dispose();
  }

  /// Additional helper methods are added here.

}
