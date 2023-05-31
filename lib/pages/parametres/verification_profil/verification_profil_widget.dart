import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'verification_profil_model.dart';
export 'verification_profil_model.dart';

class VerificationProfilWidget extends StatefulWidget {
  const VerificationProfilWidget({Key? key}) : super(key: key);

  @override
  _VerificationProfilWidgetState createState() =>
      _VerificationProfilWidgetState();
}

class _VerificationProfilWidgetState extends State<VerificationProfilWidget> {
  late VerificationProfilModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerificationProfilModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Vérification de profil',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: StreamBuilder<List<VerificationProfilRecord>>(
          stream: queryVerificationProfilRecord(
            queryBuilder: (verificationProfilRecord) => verificationProfilRecord
                .where('utilisateur', isEqualTo: currentUserReference),
            singleRecord: true,
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: SpinKitDoubleBounce(
                    color: FlutterFlowTheme.of(context).primary,
                    size: 50.0,
                  ),
                ),
              );
            }
            List<VerificationProfilRecord> columnVerificationProfilRecordList =
                snapshot.data!;
            final columnVerificationProfilRecord =
                columnVerificationProfilRecordList.isNotEmpty
                    ? columnVerificationProfilRecordList.first
                    : null;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Form(
                          key: _model.formKey1,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 25.0),
                                child: Text(
                                  'Faites vérifier votre profil pour plus de sécurité. Nous aurons besoin de quelques informations supplémentaires.',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final _datePicked1Date =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: getCurrentTimestamp,
                                      firstDate: DateTime(1900),
                                      lastDate: getCurrentTimestamp,
                                    );

                                    if (_datePicked1Date != null) {
                                      setState(() {
                                        _model.datePicked1 = DateTime(
                                          _datePicked1Date.year,
                                          _datePicked1Date.month,
                                          _datePicked1Date.day,
                                        );
                                      });
                                    }
                                    setState(() {
                                      _model.naissanceChoisie = true;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Date de naissance :',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          _model.naissanceChoisie
                                              ? dateTimeFormat(
                                                  'd/M/y',
                                                  _model.datePicked1,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                )
                                              : 'Choisir une date',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                fontSize: 16.0,
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 5.0, 15.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Lieu :',
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 0.0, 15.0, 0.0),
                                          child: TextFormField(
                                            controller:
                                                _model.textController1 ??=
                                                    TextEditingController(
                                              text: columnVerificationProfilRecord !=
                                                      null
                                                  ? columnVerificationProfilRecord!
                                                      .birthplace
                                                  : '',
                                            ),
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent3,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 10.0, 0.0, 0.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  fontStyle: FontStyle.italic,
                                                  lineHeight: 1.0,
                                                ),
                                            textAlign: TextAlign.start,
                                            validator: _model
                                                .textController1Validator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    'Numéro du document d\'identité :',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 15.0, 0.0),
                                    child: TextFormField(
                                      controller: _model.textController2 ??=
                                          TextEditingController(
                                        text: columnVerificationProfilRecord !=
                                                null
                                            ? columnVerificationProfilRecord!
                                                .numeroId
                                                .toString()
                                            : '',
                                      ),
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Entrez le numéro',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontStyle: FontStyle.italic,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .accent3,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                10.0, 10.0, 0.0, 0.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            fontStyle: FontStyle.italic,
                                          ),
                                      keyboardType: TextInputType.number,
                                      validator: _model.textController2Validator
                                          .asValidator(context),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 5.0, 15.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final _datePicked2Date =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: getCurrentTimestamp,
                                      firstDate: getCurrentTimestamp,
                                      lastDate: DateTime(2050),
                                    );

                                    if (_datePicked2Date != null) {
                                      setState(() {
                                        _model.datePicked2 = DateTime(
                                          _datePicked2Date.year,
                                          _datePicked2Date.month,
                                          _datePicked2Date.day,
                                        );
                                      });
                                    }
                                    setState(() {
                                      _model.expirationChoisie = true;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Text(
                                          'Date d\'expiration :',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 5.0, 10.0, 0.0),
                                        child: Text(
                                          _model.expirationChoisie
                                              ? dateTimeFormat(
                                                  'd/M/y',
                                                  _model.datePicked2,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                )
                                              : 'Choisir une date',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                fontSize: 16.0,
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 40.0,
                                thickness: 2.0,
                                indent: 20.0,
                                endIndent: 20.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: Text(
                                  'Ajoutez des photos de votre document d\'identité.',
                                  style:
                                      FlutterFlowTheme.of(context).titleMedium,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 10.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      allowPhoto: true,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading1 = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];
                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        _model.isDataUploading1 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile1 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl1 =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        setState(() {});
                                        return;
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Recto',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 10.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height: 160.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.asset(
                                        'assets/images/identification.png',
                                      ).image,
                                    ),
                                  ),
                                  child: Visibility(
                                    visible: _model.uploadedFileUrl1 != null &&
                                        _model.uploadedFileUrl1 != '',
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: FlutterFlowExpandedImageView(
                                              image: Image.network(
                                                _model.uploadedFileUrl1,
                                                fit: BoxFit.contain,
                                              ),
                                              allowRotation: false,
                                              tag: _model.uploadedFileUrl1,
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: _model.uploadedFileUrl1,
                                        transitionOnUserGestures: true,
                                        child: Image.network(
                                          _model.uploadedFileUrl1,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 10.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      allowPhoto: true,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading2 = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];
                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        _model.isDataUploading2 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile2 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl2 =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        setState(() {});
                                        return;
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Verso',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 10.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height: 160.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.asset(
                                        'assets/images/identification.png',
                                      ).image,
                                    ),
                                  ),
                                  child: Visibility(
                                    visible: _model.uploadedFileUrl2 != null &&
                                        _model.uploadedFileUrl2 != '',
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: FlutterFlowExpandedImageView(
                                              image: Image.network(
                                                _model.uploadedFileUrl2,
                                                fit: BoxFit.contain,
                                              ),
                                              allowRotation: false,
                                              tag: _model.uploadedFileUrl2,
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: _model.uploadedFileUrl2,
                                        transitionOnUserGestures: true,
                                        child: Image.network(
                                          _model.uploadedFileUrl2,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    2.0, 2.0, 2.0, 2.0),
                                child: Text(
                                  'Veuillez vous assurer que les images sont lisibles',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 12.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          indent: 30.0,
                          endIndent: 30.0,
                        ),
                        Form(
                          key: _model.formKey2,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 10.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      allowPhoto: true,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading3 = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];
                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        _model.isDataUploading3 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile3 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl3 =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        setState(() {});
                                        return;
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Ajouter une photo du vehicule (si conducteur)',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ),
                              if (_model.uploadedFileUrl3 != null &&
                                  _model.uploadedFileUrl3 != '')
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 10.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    height: 160.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: Image.asset(
                                          'assets/images/license-plate.png',
                                        ).image,
                                      ),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: FlutterFlowExpandedImageView(
                                              image: Image.network(
                                                _model.uploadedFileUrl3,
                                                fit: BoxFit.contain,
                                              ),
                                              allowRotation: false,
                                              tag: _model.uploadedFileUrl3,
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: _model.uploadedFileUrl3,
                                        transitionOnUserGestures: true,
                                        child: Image.network(
                                          _model.uploadedFileUrl3,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (_model.uploadedFileUrl3 != null &&
                                  _model.uploadedFileUrl3 != '')
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 2.0, 10.0, 10.0),
                                  child: Text(
                                    'Veuillez vous assurer que l\'immatriculation est bien lisible.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 12.0,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Theme(
                                data: ThemeData(
                                  checkboxTheme: CheckboxThemeData(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  unselectedWidgetColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                ),
                                child: Checkbox(
                                  value: _model.checkboxValue ??= false,
                                  onChanged: (newValue) async {
                                    setState(
                                        () => _model.checkboxValue = newValue!);
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  checkColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: Text(
                                    'Je confirme que les documents ci-dessus m\'appartiennent et reprennent conformement les données contenues dans mon profil.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 12.0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (columnVerificationProfilRecord != null)
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 15.0),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Statut de votre demande : ',
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: columnVerificationProfilRecord!
                                            .status,
                                        style: TextStyle(
                                          color: columnVerificationProfilRecord!
                                                      .status ==
                                                  'Refusé'
                                              ? FlutterFlowTheme.of(context)
                                                  .tertiary
                                              : FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 18.0,
                                        ),
                                  ),
                                ),
                              ),
                              if ((columnVerificationProfilRecord != null) &&
                                  (columnVerificationProfilRecord!
                                              .commentaire !=
                                          null &&
                                      columnVerificationProfilRecord!
                                              .commentaire !=
                                          ''))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 20.0),
                                  child: TextFormField(
                                    controller: _model.textController3 ??=
                                        TextEditingController(
                                      text: columnVerificationProfilRecord!
                                          .commentaire,
                                    ),
                                    readOnly: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Message du support',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodySmall,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .accent3,
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    maxLines: null,
                                    validator: _model.textController3Validator
                                        .asValidator(context),
                                  ),
                                ),
                              if (columnVerificationProfilRecord!.status ==
                                  'Refusé')
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (currentUserPhoto !=
                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png') {
                                        if (_model.formKey1.currentState ==
                                                null ||
                                            !_model.formKey1.currentState!
                                                .validate()) {
                                          return;
                                        }
                                        if (_model.datePicked1 == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Veuillez entrer votre date de naissance',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          );
                                          return;
                                        }
                                        if (_model.datePicked2 == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Veuillez entre la date d\'expiration de votre titre d\'identité',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          );
                                          return;
                                        }
                                        if (_model.uploadedFileUrl1 == null ||
                                            _model.uploadedFileUrl1.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Veuillez ajouter une photo du recto de votre carte d\'identité',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          );
                                          return;
                                        }
                                        if (_model.uploadedFileUrl2 == null ||
                                            _model.uploadedFileUrl2.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Veuillez ajouter une photo du verso de votre carte d\'identité',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          );
                                          return;
                                        }
                                        if (_model.checkboxValue!) {
                                          if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.vehiculeImmatriculation,
                                                      '') !=
                                                  null &&
                                              valueOrDefault(
                                                      currentUserDocument
                                                          ?.vehiculeImmatriculation,
                                                      '') !=
                                                  '') {
                                            if (_model.formKey2.currentState ==
                                                    null ||
                                                !_model.formKey2.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                            if (_model.uploadedFileUrl3 ==
                                                    null ||
                                                _model
                                                    .uploadedFileUrl3.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Veuillez ajouter une photo de votre véhicule et son immatriculation.',
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                ),
                                              );
                                              return;
                                            }
                                          }

                                          final verificationProfilUpdateData =
                                              createVerificationProfilRecordData(
                                            immatriculation:
                                                _model.uploadedFileUrl3,
                                            status: 'En attente',
                                            identiteRecto:
                                                _model.uploadedFileUrl1,
                                            identiteVerso:
                                                _model.uploadedFileUrl2,
                                            modifiedAt: getCurrentTimestamp,
                                            birthdate: _model.datePicked1,
                                            expirationdate: _model.datePicked2,
                                            numeroId: int.tryParse(
                                                _model.textController2.text),
                                            birthplace:
                                                _model.textController1.text,
                                          );
                                          await columnVerificationProfilRecord!
                                              .reference
                                              .update(
                                                  verificationProfilUpdateData);
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Vérification de profil'),
                                                content: Text(
                                                    'Votre demande a bien été transférée. Elle sera traitée sous un délai de 5 jours ouvrables.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Merci'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          context.safePop();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Veuillez cocher la case pour accord.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Vous devez avoir une photo de profil pour faire une demande de vérification.',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 2000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                          ),
                                        );
                                      }
                                    },
                                    text: 'Soumettre',
                                    options: FFButtonOptions(
                                      width: 130.0,
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                      elevation: 2.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        if (!(columnVerificationProfilRecord != null))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (currentUserPhoto !=
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png') {
                                  if (_model.formKey1.currentState == null ||
                                      !_model.formKey1.currentState!
                                          .validate()) {
                                    return;
                                  }
                                  if (_model.datePicked1 == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Veuillez entrer votre date de naissance',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 2000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    );
                                    return;
                                  }
                                  if (_model.datePicked2 == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Veuillez entre la date d\'expiration de votre titre d\'identité',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                        ),
                                        duration: Duration(milliseconds: 2000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    );
                                    return;
                                  }
                                  if (_model.uploadedFileUrl1 == null ||
                                      _model.uploadedFileUrl1.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Veuillez ajouter une photo du recto de votre carte d\'identité',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 2000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    );
                                    return;
                                  }
                                  if (_model.uploadedFileUrl2 == null ||
                                      _model.uploadedFileUrl2.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Veuillez ajouter une photo du verso de votre carte d\'identité',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 2000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    );
                                    return;
                                  }
                                  if (_model.checkboxValue!) {
                                    if (valueOrDefault(
                                                currentUserDocument
                                                    ?.vehiculeImmatriculation,
                                                '') !=
                                            null &&
                                        valueOrDefault(
                                                currentUserDocument
                                                    ?.vehiculeImmatriculation,
                                                '') !=
                                            '') {
                                      if (_model.formKey2.currentState ==
                                              null ||
                                          !_model.formKey2.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      if (_model.uploadedFileUrl3 == null ||
                                          _model.uploadedFileUrl3.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Veuillez ajouter une photo de votre véhicule et son immatriculation.',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 2000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                          ),
                                        );
                                        return;
                                      }
                                    }

                                    final verificationProfilCreateData =
                                        createVerificationProfilRecordData(
                                      utilisateur: currentUserReference,
                                      immatriculation: _model.uploadedFileUrl3,
                                      identiteRecto: _model.uploadedFileUrl1,
                                      identiteVerso: _model.uploadedFileUrl2,
                                      status: 'En attente',
                                      createdAt: getCurrentTimestamp,
                                      birthdate: _model.datePicked1,
                                      birthplace: _model.textController1.text,
                                      expirationdate: _model.datePicked2,
                                      numeroId: int.tryParse(
                                          _model.textController2.text),
                                    );
                                    await VerificationProfilRecord.collection
                                        .doc()
                                        .set(verificationProfilCreateData);
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Vérification de profil'),
                                          content: Text(
                                              'Votre demande a bien été transférée. Elle sera traitée sous un délai de 5 jours ouvrables.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Merci'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    context.safePop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Veuillez cocher la case pour accord.',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 2000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Vous devez avoir une photo de profil pour faire une demande de vérification.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                    ),
                                  );
                                }
                              },
                              text: 'Soumettre',
                              options: FFButtonOptions(
                                width: 130.0,
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                elevation: 2.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
