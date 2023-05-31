import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/historique_vide/historique_vide_widget.dart';
import '/components/preview_historique_chauffeur/preview_historique_chauffeur_widget.dart';
import '/components/preview_historique_passager/preview_historique_passager_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HistoriqueModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  bool vide = false;

  ///  State fields for stateful widgets in this page.

  // Model for historiqueVide component.
  late HistoriqueVideModel historiqueVideModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    historiqueVideModel = createModel(context, () => HistoriqueVideModel());
  }

  void dispose() {
    historiqueVideModel.dispose();
  }

  /// Additional helper methods are added here.

}
