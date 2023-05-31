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
import 'historique_model.dart';
export 'historique_model.dart';

class HistoriqueWidget extends StatefulWidget {
  const HistoriqueWidget({Key? key}) : super(key: key);

  @override
  _HistoriqueWidgetState createState() => _HistoriqueWidgetState();
}

class _HistoriqueWidgetState extends State<HistoriqueWidget> {
  late HistoriqueModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoriqueModel());

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
            'Historique',
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
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30.0, 50.0, 0.0, 0.0),
                  child: Text(
                    'Vos trajets passés :',
                    style: FlutterFlowTheme.of(context).headlineMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: StreamBuilder<List<VoyageRecord>>(
                    stream: queryVoyageRecord(
                      queryBuilder: (voyageRecord) => voyageRecord
                          .where('chauffeur', isEqualTo: currentUserReference)
                          .where('dateDepart', isLessThan: getCurrentTimestamp),
                      limit: 10,
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
                            child: PreviewHistoriqueChauffeurWidget(
                              key: Key(
                                  'Keyxyp_${listViewIndex}_of_${listViewVoyageRecordList.length}'),
                              depart: listViewVoyageRecord.depart.ville,
                              destination:
                                  listViewVoyageRecord.destination.ville,
                              passengersID: listViewVoyageRecord.passagers,
                              dateDepart: listViewVoyageRecord.dateDepart,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                StreamBuilder<List<VoyageRecord>>(
                  stream: queryVoyageRecord(
                    queryBuilder: (voyageRecord) => voyageRecord
                        .where('passagers', arrayContains: currentUserReference)
                        .where('dateDepart', isLessThan: getCurrentTimestamp),
                    limit: 10,
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
                        return PreviewHistoriquePassagerWidget(
                          key: Key(
                              'Key7oe_${listViewIndex}_of_${listViewVoyageRecordList.length}'),
                          depart: listViewVoyageRecord.depart.ville,
                          destination: listViewVoyageRecord.destination.ville,
                          dateDepart: listViewVoyageRecord.dateDepart,
                          conducteurID: listViewVoyageRecord.chauffeur,
                        );
                      },
                    );
                  },
                ),
                wrapWithModel(
                  model: _model.historiqueVideModel,
                  updateCallback: () => setState(() {}),
                  child: HistoriqueVideWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
