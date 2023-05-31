import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthentificationModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;
  // State field(s) for login_email widget.
  TextEditingController? loginEmailController;
  String? Function(BuildContext, String?)? loginEmailControllerValidator;
  // State field(s) for login_passe widget.
  TextEditingController? loginPasseController;
  late bool loginPasseVisibility;
  String? Function(BuildContext, String?)? loginPasseControllerValidator;
  // State field(s) for inscription_email widget.
  TextEditingController? inscriptionEmailController;
  String? Function(BuildContext, String?)? inscriptionEmailControllerValidator;
  // State field(s) for inscription_passe widget.
  TextEditingController? inscriptionPasseController;
  late bool inscriptionPasseVisibility;
  String? Function(BuildContext, String?)? inscriptionPasseControllerValidator;
  // State field(s) for inscriptionPasse_confirm widget.
  TextEditingController? inscriptionPasseConfirmController;
  late bool inscriptionPasseConfirmVisibility;
  String? Function(BuildContext, String?)?
      inscriptionPasseConfirmControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    loginPasseVisibility = false;
    inscriptionPasseVisibility = false;
    inscriptionPasseConfirmVisibility = false;
  }

  void dispose() {
    loginEmailController?.dispose();
    loginPasseController?.dispose();
    inscriptionEmailController?.dispose();
    inscriptionPasseController?.dispose();
    inscriptionPasseConfirmController?.dispose();
  }

  /// Additional helper methods are added here.

}
