import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'code_o_t_p_model.dart';
export 'code_o_t_p_model.dart';

class CodeOTPWidget extends StatefulWidget {
  const CodeOTPWidget({
    Key? key,
    this.voyage,
    this.mcpRef,
    this.myTransactionRef,
  }) : super(key: key);

  final VoyageRecord? voyage;
  final String? mcpRef;
  final DocumentReference? myTransactionRef;

  @override
  _CodeOTPWidgetState createState() => _CodeOTPWidgetState();
}

class _CodeOTPWidgetState extends State<CodeOTPWidget> {
  late CodeOTPModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CodeOTPModel());

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
            'Code d\'authentification',
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
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 35.0, 15.0, 0.0),
                child: Text(
                  'Nous vous avons envoyé un message contenant un code pour vérifer le numéro de téléphone.',
                  style: FlutterFlowTheme.of(context).titleMedium,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                child: Text(
                  'Entrez le code que vous avez reçu par SMS :',
                  style: FlutterFlowTheme.of(context).titleMedium,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  appContext: context,
                  length: 4,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondary,
                      ),
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  enableActiveFill: false,
                  autoFocus: false,
                  enablePinAutofill: false,
                  errorTextSpace: 16.0,
                  showCursor: true,
                  cursorColor: FlutterFlowTheme.of(context).primary,
                  obscureText: false,
                  hintCharacter: '●',
                  pinTheme: PinTheme(
                    fieldHeight: 60.0,
                    fieldWidth: 60.0,
                    borderWidth: 2.0,
                    borderRadius: BorderRadius.circular(12.0),
                    shape: PinCodeFieldShape.box,
                    activeColor: FlutterFlowTheme.of(context).primary,
                    inactiveColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    selectedColor: FlutterFlowTheme.of(context).secondaryText,
                    activeFillColor: FlutterFlowTheme.of(context).primary,
                    inactiveFillColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    selectedFillColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                  controller: _model.pinCodeController,
                  onChanged: (_) {},
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                      _model.pinCodeControllerValidator.asValidator(context),
                ),
              ),
              if (!_model.payOK!)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.authorize = await CoolpayGroup.authorizeCall.call(
                        ref: widget.mcpRef,
                        code: _model.pinCodeController!.text,
                      );
                      if ((_model.authorize?.succeeded ?? true)) {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              content: Text(
                                  'Le paiement a été initié. Veuillez suivre les instructions de votre opérateur pour continuer.Si vous ne recevez pas de notification, composez le  ${CoolpayGroup.authorizeCall.ussd(
                                        (_model.authorize?.jsonBody ?? ''),
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
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Erreur. Veuillez vérifier le code',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                            ),
                            duration: Duration(milliseconds: 2000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondaryText,
                          ),
                        );
                      }

                      setState(() {});
                    },
                    text: 'Authentifier',
                    options: FFButtonOptions(
                      width: 130.0,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                padding: EdgeInsetsDirectional.fromSTEB(150.0, 100.0, 0.0, 0.0),
                child: StreamBuilder<List<TransactionsRecord>>(
                  stream: queryTransactionsRecord(
                    queryBuilder: (transactionsRecord) => transactionsRecord
                        .where('voyage_ref',
                            isEqualTo: widget.voyage!.reference)
                        .where('user_ref', isEqualTo: currentUserReference)
                        .orderBy('modified_at', descending: true),
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
                    List<TransactionsRecord> textTransactionsRecordList =
                        snapshot.data!;
                    final textTransactionsRecord =
                        textTransactionsRecordList.isNotEmpty
                            ? textTransactionsRecordList.first
                            : null;
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (textTransactionsRecord != null) {
                          _model.check = await CoolpayGroup.checkCall.call(
                            mCPRef: textTransactionsRecord!.mCPRef,
                          );
                          if ((_model.check?.succeeded ?? true)) {
                            if (CoolpayGroup.checkCall.status(
                                  (_model.check?.jsonBody ?? ''),
                                ) ==
                                'SUCCESS') {
                              final transactionsUpdateData =
                                  createTransactionsRecordData(
                                status: 'SUCCESS',
                                modifiedAt: getCurrentTimestamp,
                              );
                              await textTransactionsRecord!.reference
                                  .update(transactionsUpdateData);

                              final reservationCreateData =
                                  createReservationRecordData(
                                userID: currentUserReference,
                                status: 'En attente',
                                dateVoyage: widget.voyage!.dateDepart,
                                createdAt: getCurrentTimestamp,
                              );
                              var reservationRecordReference =
                                  ReservationRecord.createDoc(
                                      widget.voyage!.reference);
                              await reservationRecordReference
                                  .set(reservationCreateData);
                              _model.reservationCopy =
                                  ReservationRecord.getDocumentFromData(
                                      reservationCreateData,
                                      reservationRecordReference);

                              context.pushNamed(
                                'ReservationOK',
                                queryParameters: {
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
                                    title: Text('Paiement non reçu'),
                                    content: Text(CoolpayGroup.checkCall
                                        .message(
                                          (_model.check?.jsonBody ?? ''),
                                        )
                                        .toString()),
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
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Erreur inattendue'),
                                  content: Text(
                                      'Nous n\'avons pas pu vérifier votre paiement. Veuillez réessayer. Si le problème persiste, merci de contacter le service'),
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
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Erreur inattendue'),
                                content: Text(
                                    'Nous n\'avons pas pu retrouver votre paiement. Veuillez réessayer. Si le problème persiste, merci de contacter le service'),
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
