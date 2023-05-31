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
import 'mes_trajets_model.dart';
export 'mes_trajets_model.dart';

class MesTrajetsWidget extends StatefulWidget {
  const MesTrajetsWidget({Key? key}) : super(key: key);

  @override
  _MesTrajetsWidgetState createState() => _MesTrajetsWidgetState();
}

class _MesTrajetsWidgetState extends State<MesTrajetsWidget> {
  late MesTrajetsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MesTrajetsModel());

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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if ((valueOrDefault(currentUserDocument?.vehicleName, '') != null &&
                    valueOrDefault(currentUserDocument?.vehicleName, '') !=
                        '') &&
                (valueOrDefault(
                            currentUserDocument?.vehiculeImmatriculation, '') !=
                        null &&
                    valueOrDefault(
                            currentUserDocument?.vehiculeImmatriculation, '') !=
                        '')) {
              context.pushNamed('AjouterTrajet');
            } else {
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: Text('Vehicule non renseigné'),
                    content: Text(
                        'Vous devez ajouter une marque et une immatriculation de véhicule  avant d\'ajouter un trajet.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.add_rounded,
            color: FlutterFlowTheme.of(context).primaryBackground,
            size: 35.0,
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Prêt à partir ?',
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15.0, 15.0, 15.0, 15.0),
                      child: Text(
                        'Vos prochains voyages apparaissent ici',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                  child: StreamBuilder<List<VoyageRecord>>(
                    stream: queryVoyageRecord(
                      queryBuilder: (voyageRecord) => voyageRecord
                          .where('chauffeur', isEqualTo: currentUserReference)
                          .where('dateDepart',
                              isGreaterThanOrEqualTo: getCurrentTimestamp),
                      limit: 5,
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
                      List<VoyageRecord> listViewVoyageRecordList =
                          snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewVoyageRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewVoyageRecord =
                              listViewVoyageRecordList[listViewIndex];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 5.0, 3.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'trajetDetails',
                                  queryParams: {
                                    'voyage': serializeParam(
                                      listViewVoyageRecord.reference,
                                      ParamType.DocumentReference,
                                    ),
                                    'isDriver': serializeParam(
                                      true,
                                      ParamType.bool,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: PreviewVoyageWidget(
                                key: Key(
                                    'Key984_${listViewIndex}_of_${listViewVoyageRecordList.length}'),
                                depart: listViewVoyageRecord.depart.ville,
                                destination:
                                    listViewVoyageRecord.destination.ville,
                                places: 1,
                                duree: listViewVoyageRecord.duree,
                                conducteurId: listViewVoyageRecord.chauffeur,
                                prix: listViewVoyageRecord.prix,
                                dateDepart: listViewVoyageRecord.dateDepart,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                StreamBuilder<List<ReservationRecord>>(
                  stream: queryReservationRecord(
                    queryBuilder: (reservationRecord) => reservationRecord
                        .where('user_ID', isEqualTo: currentUserReference)
                        .where('date_voyage',
                            isGreaterThanOrEqualTo: getCurrentTimestamp),
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
                    List<ReservationRecord> listViewReservationRecordList =
                        snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewReservationRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewReservationRecord =
                            listViewReservationRecordList[listViewIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 3.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'trajetDetails',
                                queryParams: {
                                  'voyage': serializeParam(
                                    listViewReservationRecord.parentReference,
                                    ParamType.DocumentReference,
                                  ),
                                  'reservationID': serializeParam(
                                    listViewReservationRecord.reference,
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: PreviewReservationWidget(
                              key: Key(
                                  'Key9v9_${listViewIndex}_of_${listViewReservationRecordList.length}'),
                              voyageID:
                                  listViewReservationRecord.parentReference,
                              statut: listViewReservationRecord.status,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                if (_model.vide)
                  wrapWithModel(
                    model: _model.mesTrajetsVideModel,
                    updateCallback: () => setState(() {}),
                    child: MesTrajetsVideWidget(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
