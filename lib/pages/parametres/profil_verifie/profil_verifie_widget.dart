import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profil_verifie_model.dart';
export 'profil_verifie_model.dart';

class ProfilVerifieWidget extends StatefulWidget {
  const ProfilVerifieWidget({Key? key}) : super(key: key);

  @override
  _ProfilVerifieWidgetState createState() => _ProfilVerifieWidgetState();
}

class _ProfilVerifieWidgetState extends State<ProfilVerifieWidget> {
  late ProfilVerifieModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilVerifieModel());

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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: StreamBuilder<List<VerificationProfilRecord>>(
            stream: queryVerificationProfilRecord(
              queryBuilder: (verificationProfilRecord) =>
                  verificationProfilRecord.where('utilisateur',
                      isEqualTo: currentUserReference),
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
              List<VerificationProfilRecord> ouiVerificationProfilRecordList =
                  snapshot.data!;
              final ouiVerificationProfilRecord =
                  ouiVerificationProfilRecordList.isNotEmpty
                      ? ouiVerificationProfilRecordList.first
                      : null;
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(25.0, 35.0, 0.0, 15.0),
                    child: Text(
                      'Votre profil est vérifié.\nMerci de votre confiance.',
                      style: FlutterFlowTheme.of(context).titleMedium,
                    ),
                  ),
                  Divider(
                    height: 50.0,
                    thickness: 1.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    color: FlutterFlowTheme.of(context).accent3,
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Date de naissance :',
                          style: FlutterFlowTheme.of(context).titleMedium,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            dateTimeFormat(
                              'd/M/y',
                              ouiVerificationProfilRecord!.birthdate!,
                              locale: FFLocalizations.of(context).languageCode,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).secondary,
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Lieu :',
                          style: FlutterFlowTheme.of(context).titleMedium,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            ouiVerificationProfilRecord!.birthplace,
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).secondary,
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 0.0, 0.0),
                      child: Text(
                        'Numéro du document d\'identité :',
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(25.0, 5.0, 0.0, 0.0),
                    child: Text(
                      ouiVerificationProfilRecord!.numeroId.toString(),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondary,
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 0.0),
                          child: Text(
                            'Date d\'expiration :',
                            style: FlutterFlowTheme.of(context).titleMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 5.0, 10.0, 0.0),
                          child: Text(
                            dateTimeFormat(
                              'd/M/y',
                              ouiVerificationProfilRecord!.expirationdate!,
                              locale: FFLocalizations.of(context).languageCode,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).secondary,
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
