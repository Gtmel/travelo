import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/mes_trajets_vide/mes_trajets_vide_widget.dart';
import '/components/preview_reservation/preview_reservation_widget.dart';
import '/components/preview_voyage/preview_voyage_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MesTrajetsModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  bool vide = false;

  ///  State fields for stateful widgets in this page.

  // Model for mesTrajetsVide component.
  late MesTrajetsVideModel mesTrajetsVideModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    mesTrajetsVideModel = createModel(context, () => MesTrajetsVideModel());
  }

  void dispose() {
    mesTrajetsVideModel.dispose();
  }

  /// Additional helper methods are added here.

}
