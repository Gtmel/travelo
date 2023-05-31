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
import 'paiement_model.dart';
export 'paiement_model.dart';

class PaiementWidget extends StatefulWidget {
  const PaiementWidget({
    Key? key,
    this.prix,
    this.voyage,
  }) : super(key: key);

  final int? prix;
  final VoyageRecord? voyage;

  @override
  _PaiementWidgetState createState() => _PaiementWidgetState();
}

class _PaiementWidgetState extends State<PaiementWidget> {
  late PaiementModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaiementModel());

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
            'Paiement',
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
        body: StreamBuilder<List<TransactionsRecord>>(
          stream: queryTransactionsRecord(
            queryBuilder: (transactionsRecord) => transactionsRecord
                .where('voyage_ref', isEqualTo: widget.voyage!.reference)
                .where('user_ref', isEqualTo: currentUserReference)
                .orderBy('created_at', descending: true),
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
            List<TransactionsRecord> containerTransactionsRecordList =
                snapshot.data!;
            final containerTransactionsRecord =
                containerTransactionsRecordList.isNotEmpty
                    ? containerTransactionsRecordList.first
                    : null;
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 35.0, 15.0, 0.0),
                    child: Text(
                      'L\'application n\'accepte que les paiements mobiles (Orange et Mtn Mobile Money)',
                      style: FlutterFlowTheme.of(context).titleMedium,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                    child: Text(
                      'Veuillez entrer un numéro de téléphone sur lequel initier le paiement :',
                      style: FlutterFlowTheme.of(context).titleMedium,
                    ),
                  ),
                  Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15.0, 15.0, 15.0, 15.0),
                      child: TextFormField(
                        controller: _model.textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Insérer un numéro valide...',
                          hintStyle: FlutterFlowTheme.of(context).bodySmall,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        keyboardType: TextInputType.number,
                        validator:
                            _model.textControllerValidator.asValidator(context),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      setState(() {
                        _model.textController?.text = currentPhoneNumber;
                      });
                    },
                    child: Text(
                      'Utiliser mon numéro de téléphone',
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  if (!_model.payOK)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          if (containerTransactionsRecord != null) {
                            if (containerTransactionsRecord!.status ==
                                'PENDING') {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Attention'),
                                            content: Text(
                                                'Vous avez déjà un paiement en attente d\'être effectué. Voulez vous en créer un autre ?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Non, annuler'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Oui, continuer'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                            }
                          }
                          _model.payin = await CoolpayGroup.payinCall.call(
                            montant: widget.prix,
                            numero: _model.textController.text,
                            name: currentUserDisplayName,
                          );
                          if ((_model.payin?.succeeded ?? true)) {
                            final transactionsCreateData =
                                createTransactionsRecordData(
                              amount: widget.prix,
                              type: 'Réservation',
                              numero: _model.textController.text,
                              voyageRef: widget.voyage!.reference,
                              userRef: currentUserReference,
                              createdAt: getCurrentTimestamp,
                              mCPRef: CoolpayGroup.payinCall
                                  .mCPref(
                                    (_model.payin?.jsonBody ?? ''),
                                  )
                                  .toString(),
                              status: 'PENDING',
                              modifiedAt: getCurrentTimestamp,
                            );
                            var transactionsRecordReference =
                                TransactionsRecord.collection.doc();
                            await transactionsRecordReference
                                .set(transactionsCreateData);
                            _model.transaction =
                                TransactionsRecord.getDocumentFromData(
                                    transactionsCreateData,
                                    transactionsRecordReference);
                            if (CoolpayGroup.payinCall
                                    .action(
                                      (_model.payin?.jsonBody ?? ''),
                                    )
                                    .toString() ==
                                '\"REQUIRE_OTP\"') {
                              context.pushNamed(
                                'codeOTP',
                                queryParams: {
                                  'voyage': serializeParam(
                                    widget.voyage,
                                    ParamType.Document,
                                  ),
                                  'mcpRef': serializeParam(
                                    CoolpayGroup.payinCall
                                        .mCPref(
                                          (_model.payin?.jsonBody ?? ''),
                                        )
                                        .toString(),
                                    ParamType.String,
                                  ),
                                  'myTransactionRef': serializeParam(
                                    _model.transaction!.reference,
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'voyage': widget.voyage,
                                },
                              );
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    content: Text(
                                        'Le paiement a été initié. Veuillez suivre les instructions de votre opérateur pour continuer.Si vous ne recevez pas de notification, composez le  ${CoolpayGroup.payinCall.ussd(
                                              (_model.payin?.jsonBody ?? ''),
                                            ).toString()}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              setState(() {
                                _model.payOK = true;
                              });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Une erreur est survenue. Veuillez vérifier le numéro de téléphone. Si le problème persiste, contactez le service.',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                            );
                          }

                          setState(() {});
                        },
                        text: 'Payer',
                        options: FFButtonOptions(
                          width: 130.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(150.0, 100.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (containerTransactionsRecord!.status == 'SUCCESS') {
                          context.pushNamed(
                            'ReservationOK',
                            queryParams: {
                              'voyage': serializeParam(
                                widget.voyage,
                                ParamType.Document,
                              ),
                            }.withoutNulls,
                            extra: <String, dynamic>{
                              'voyage': widget.voyage,
                            },
                          );
                        } else {
                          _model.check = await CoolpayGroup.checkCall.call(
                            mCPRef: containerTransactionsRecord!.mCPRef,
                          );
                          if ((_model.check?.succeeded ?? true)) {
                            final transactionsUpdateData = {
                              ...createTransactionsRecordData(
                                status: 'SUCCESS',
                              ),
                              'modified_at': FieldValue.serverTimestamp(),
                            };
                            await containerTransactionsRecord!.reference
                                .update(transactionsUpdateData);

                            final reservationCreateData = {
                              ...createReservationRecordData(
                                userID: containerTransactionsRecord!.userRef,
                                status: 'En attente',
                                dateVoyage: widget.voyage!.dateDepart,
                                payment: containerTransactionsRecord!.amount,
                              ),
                              'created_at': FieldValue.serverTimestamp(),
                            };
                            await ReservationRecord.createDoc(
                                    containerTransactionsRecord!.voyageRef!)
                                .set(reservationCreateData);

                            context.pushNamed(
                              'ReservationOK',
                              queryParams: {
                                'voyage': serializeParam(
                                  widget.voyage,
                                  ParamType.Document,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'voyage': widget.voyage,
                              },
                            );
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Désolé'),
                                  content: Text(
                                      'Nous n\'avons pas pu retrouver votre paiement. Veuillez vérifier qu\'il ait été effectué avant de réessayer. Si le problème persiste, merci de contacter le service.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }

                        setState(() {});
                      },
                      child: Text(
                        'J\'ai déjà payé',
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).secondary,
                                ),
                      ),
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
