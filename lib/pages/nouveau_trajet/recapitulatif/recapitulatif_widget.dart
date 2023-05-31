import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recapitulatif_model.dart';
export 'recapitulatif_model.dart';

class RecapitulatifWidget extends StatefulWidget {
  const RecapitulatifWidget({
    Key? key,
    this.depart,
    this.destination,
    this.dateDepart,
    this.heureDepart,
    this.placesDispo,
    this.prix,
    this.retour,
  }) : super(key: key);

  final FFPlace? depart;
  final FFPlace? destination;
  final DateTime? dateDepart;
  final DateTime? heureDepart;
  final int? placesDispo;
  final int? prix;
  final bool? retour;

  @override
  _RecapitulatifWidgetState createState() => _RecapitulatifWidgetState();
}

class _RecapitulatifWidgetState extends State<RecapitulatifWidget> {
  late RecapitulatifModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecapitulatifModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultbaj = await ItineraireCall.call(
        origin: widget.depart!.address,
        destination: widget.destination!.address,
      );
    });

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
        backgroundColor: Color(0xFF1E2429),
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
            'Recapitulatif',
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Vous  partez de :',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).titleMedium,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 50.0, 0.0),
                          child: Container(
                            height: 75.0,
                            constraints: BoxConstraints(
                              maxWidth: 200.0,
                              maxHeight: 50.0,
                            ),
                            decoration: BoxDecoration(),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.depart!.address,
                                'Pas rempli',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  indent: 15.0,
                  endIndent: 20.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Vers :',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 50.0, 0.0),
                        child: Container(
                          height: 75.0,
                          constraints: BoxConstraints(
                            maxWidth: 200.0,
                            maxHeight: 50.0,
                          ),
                          decoration: BoxDecoration(),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              widget.destination!.address,
                              'Pas rempli',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).secondary,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.0,
                  indent: 15.0,
                  endIndent: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Le :',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        height: 50.0,
                        constraints: BoxConstraints(
                          maxHeight: 50.0,
                        ),
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            dateTimeFormat(
                              'MMMMEEEEd',
                              widget.dateDepart,
                              locale: FFLocalizations.of(context).languageCode,
                            ),
                            'Pas rempli',
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).secondary,
                              ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.0,
                  indent: 15.0,
                  endIndent: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'A :',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(170.0, 0.0, 0.0, 0.0),
                      child: Container(
                        height: 50.0,
                        constraints: BoxConstraints(
                          maxHeight: 50.0,
                        ),
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          dateTimeFormat(
                            'Hm',
                            widget.heureDepart,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).secondary,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.0,
                  indent: 15.0,
                  endIndent: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Et disposez de :',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            child: Container(
                              width: 60.0,
                              height: 50.0,
                              constraints: BoxConstraints(
                                maxWidth: 200.0,
                                maxHeight: 50.0,
                              ),
                              decoration: BoxDecoration(),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  widget.placesDispo.toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'place(s)',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.0,
                  indent: 15.0,
                  endIndent: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Au prix individuel de :',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50.0,
                          constraints: BoxConstraints(
                            maxHeight: 50.0,
                          ),
                          decoration: BoxDecoration(),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              widget.prix.toString(),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'FCFA',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.0,
                  indent: 15.0,
                  endIndent: 20.0,
                ),
                Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                    child: TextFormField(
                      controller: _model.textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText:
                            '   Un message pour vos passagers ?\n  (Un bagage par personne, flexible sur \n           l\'horaire ou le lieu)',
                        hintStyle: FlutterFlowTheme.of(context).bodySmall,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF1F4F8),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium,
                      maxLines: null,
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  indent: 15.0,
                  endIndent: 20.0,
                ),
                Align(
                  alignment: AlignmentDirectional(0.8, -1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if ((_model.apiResultbaj?.succeeded ?? true)) {
                          final voyageCreateData = createVoyageRecordData(
                            createdAt: getCurrentTimestamp,
                            placesDispo: widget.placesDispo,
                            destination: createLieuStruct(
                              position: widget.destination!.latLng,
                              nom: widget.destination!.name,
                              ville: widget.destination!.city,
                              adresse: widget.destination!.address,
                              clearUnsetFields: false,
                              create: true,
                            ),
                            prix: widget.prix!,
                            dateDepart: functions.date(
                                widget.dateDepart!, widget.heureDepart!),
                            chauffeur: currentUserReference,
                            modifiedAt: getCurrentTimestamp,
                            depart: createLieuStruct(
                              position: widget.depart!.latLng,
                              nom: widget.depart!.name,
                              ville: widget.depart!.city,
                              adresse: widget.depart!.address,
                              clearUnsetFields: false,
                              create: true,
                            ),
                            description: _model.textController.text,
                            duree: ItineraireCall.duree(
                              (_model.apiResultbaj?.jsonBody ?? ''),
                            ),
                            paid: false,
                          );
                          await VoyageRecord.collection
                              .doc()
                              .set(voyageCreateData);
                          if (widget.retour!) {
                            context.pushNamed('MesTrajets');
                          } else {
                            context.pushNamed(
                              'TrajetRetour',
                              queryParams: {
                                'depart': serializeParam(
                                  widget.depart,
                                  ParamType.FFPlace,
                                ),
                                'destination': serializeParam(
                                  widget.destination,
                                  ParamType.FFPlace,
                                ),
                                'dateDepart': serializeParam(
                                  widget.dateDepart,
                                  ParamType.DateTime,
                                ),
                                'duree': serializeParam(
                                  ItineraireCall.duree(
                                    (_model.apiResultbaj?.jsonBody ?? ''),
                                  ),
                                  ParamType.int,
                                ),
                              }.withoutNulls,
                            );
                          }
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Erreur'),
                                content: Text(
                                    'Une erreur est survenue. Veuillez réessayer. Si le problème persiste veuillez contacter le service. Merci de votre compréhension.'),
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
                          context.safePop();
                        }
                      },
                      child: Text(
                        'Publier le trajet',
                        textAlign: TextAlign.end,
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
