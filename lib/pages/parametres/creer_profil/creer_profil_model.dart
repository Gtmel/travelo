import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class CreerProfilModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  // State field(s) for nom widget.
  TextEditingController? nomController;
  String? Function(BuildContext, String?)? nomControllerValidator;
  String? _nomControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ce champ est requis';
    }

    return null;
  }

  // State field(s) for age widget.
  TextEditingController? ageController;
  String? Function(BuildContext, String?)? ageControllerValidator;
  String? _ageControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ce champ est requis';
    }

    return null;
  }

  // State field(s) for email widget.
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailControllerValidator;
  String? _emailControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ce champ est requis';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Email non valide';
    }
    return null;
  }

  // State field(s) for telephone widget.
  TextEditingController? telephoneController;
  String? Function(BuildContext, String?)? telephoneControllerValidator;
  // State field(s) for myBio widget.
  TextEditingController? myBioController;
  String? Function(BuildContext, String?)? myBioControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for vehiculeNom widget.
  TextEditingController? vehiculeNomController;
  String? Function(BuildContext, String?)? vehiculeNomControllerValidator;
  String? _vehiculeNomControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ce champ est requis';
    }

    return null;
  }

  // State field(s) for vehiculeImmatriculation widget.
  TextEditingController? vehiculeImmatriculationController;
  final vehiculeImmatriculationMask = MaskTextInputFormatter(mask: 'AA###AA');
  String? Function(BuildContext, String?)?
      vehiculeImmatriculationControllerValidator;
  String? _vehiculeImmatriculationControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ce champ es requis';
    }

    return null;
  }

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    nomControllerValidator = _nomControllerValidator;
    ageControllerValidator = _ageControllerValidator;
    emailControllerValidator = _emailControllerValidator;
    vehiculeNomControllerValidator = _vehiculeNomControllerValidator;
    vehiculeImmatriculationControllerValidator =
        _vehiculeImmatriculationControllerValidator;
  }

  void dispose() {
    nomController?.dispose();
    ageController?.dispose();
    emailController?.dispose();
    telephoneController?.dispose();
    myBioController?.dispose();
    vehiculeNomController?.dispose();
    vehiculeImmatriculationController?.dispose();
  }

  /// Additional helper methods are added here.

}
