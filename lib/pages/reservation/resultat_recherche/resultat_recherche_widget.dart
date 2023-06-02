import '/backend/backend.dart';
import '/components/preview_voyage/preview_voyage_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'resultat_recherche_model.dart';
export 'resultat_recherche_model.dart';

class ResultatRechercheWidget extends StatefulWidget {
  const ResultatRechercheWidget({
    Key? key,
    this.departVille,
    this.destinationVille,
    this.places,
    this.dateDepart,
  }) : super(key: key);

  final String? departVille;
  final String? destinationVille;
  final int? places;
  final DateTime? dateDepart;

  @override
  _ResultatRechercheWidgetState createState() =>
      _ResultatRechercheWidgetState();
}

class _ResultatRechercheWidgetState extends State<ResultatRechercheWidget> {
  late ResultatRechercheModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResultatRechercheModel());

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
            'Choisir un trajet',
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
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: FutureBuilder<List<VoyageRecord>>(
                    future: queryVoyageRecordOnce(
                      queryBuilder: (voyageRecord) => voyageRecord
                          .where('depart.ville', isEqualTo: widget.departVille)
                          .where('destination.ville',
                              isEqualTo: widget.destinationVille)
                          .where('dateDepart',
                              isGreaterThanOrEqualTo: widget.dateDepart)
                          .orderBy('dateDepart'),
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
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'trajetDetails',
                                  queryParameters: {
                                    'voyage': serializeParam(
                                      listViewVoyageRecord.reference,
                                      ParamType.DocumentReference,
                                    ),
                                    'places': serializeParam(
                                      widget.places,
                                      ParamType.int,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: PreviewVoyageWidget(
                                key: Key(
                                    'Keym3m_${listViewIndex}_of_${listViewVoyageRecordList.length}'),
                                depart: listViewVoyageRecord.depart.ville,
                                destination:
                                    listViewVoyageRecord.destination.ville,
                                duree: listViewVoyageRecord.duree,
                                dateDepart: listViewVoyageRecord.dateDepart,
                                places: widget.places,
                                conducteurId: listViewVoyageRecord.chauffeur,
                                prix: listViewVoyageRecord.prix,
                              ),
                            ),
                          );
                        },
                      );
                    },
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
