import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ajouter_avis_model.dart';
export 'ajouter_avis_model.dart';

class AjouterAvisWidget extends StatefulWidget {
  const AjouterAvisWidget({
    Key? key,
    this.destinataire,
  }) : super(key: key);

  final DocumentReference? destinataire;

  @override
  _AjouterAvisWidgetState createState() => _AjouterAvisWidgetState();
}

class _AjouterAvisWidgetState extends State<AjouterAvisWidget> {
  late AjouterAvisModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AjouterAvisModel());

    _model.textController ??= TextEditingController();
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
            'Laisser un avis',
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
        body: StreamBuilder<UsersRecord>(
          stream: UsersRecord.getDocument(widget.destinataire!),
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
            final containerUsersRecord = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          10.0, 50.0, 10.0, 10.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'A combien estimez vous votre expérience de voyage avec ',
                              style: TextStyle(),
                            ),
                            TextSpan(
                              text: containerUsersRecord.displayName,
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).secondary,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context).headlineSmall,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                        child: RatingBar.builder(
                          onRatingUpdate: (newValue) =>
                              setState(() => _model.ratingBarValue = newValue),
                          itemBuilder: (context, index) => Icon(
                            Icons.star_rounded,
                            color: FlutterFlowTheme.of(context).secondary,
                          ),
                          direction: Axis.horizontal,
                          initialRating: _model.ratingBarValue ??= 3.0,
                          unratedColor: Color(0xFF9E9E9E),
                          itemCount: 5,
                          itemSize: 40.0,
                          glowColor: FlutterFlowTheme.of(context).secondary,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 30.0, 0.0, 0.0),
                      child: Text(
                        'Dites nous en un peu plus...',
                        style: FlutterFlowTheme.of(context).headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 10.0),
                      child: TextFormField(
                        controller: _model.textController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              'Conduite, ponctualité, confort, cordialité... \nAidez d\'autres covoiteurs à faire le bon choix',
                          hintStyle: FlutterFlowTheme.of(context).bodySmall,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF1F4F8),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 10.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        maxLines: 5,
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }

                            final avisCreateData = createAvisRecordData(
                              note: _model.ratingBarValue?.round(),
                              commentaire: _model.textController.text,
                              auteur: currentUserReference,
                              destinataire: widget.destinataire,
                              createdAt: getCurrentTimestamp,
                            );
                            await AvisRecord.collection
                                .doc()
                                .set(avisCreateData);

                            final usersUpdateData = {
                              ...createUsersRecordData(
                                note: (containerUsersRecord.note +
                                        _model.ratingBarValue!.round()) /
                                    (containerUsersRecord.nombreAvis + 1),
                              ),
                              'nombre_avis': FieldValue.increment(1),
                            };
                            await widget.destinataire!.update(usersUpdateData);
                            context.pop();
                          },
                          text: 'Valider',
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
