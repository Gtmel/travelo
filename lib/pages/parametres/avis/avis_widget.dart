import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/avis_envoye_vide/avis_envoye_vide_widget.dart';
import '/components/avis_recu_vide/avis_recu_vide_widget.dart';
import '/components/comment/comment_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'avis_model.dart';
export 'avis_model.dart';

class AvisWidget extends StatefulWidget {
  const AvisWidget({Key? key}) : super(key: key);

  @override
  _AvisWidgetState createState() => _AvisWidgetState();
}

class _AvisWidgetState extends State<AvisWidget> {
  late AvisModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AvisModel());

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
            'Avis',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30.0, 50.0, 10.0, 0.0),
                child: Text(
                  'Ici vous pouvez consulter les avis',
                  style: FlutterFlowTheme.of(context).headlineSmall,
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: FlutterFlowTheme.of(context).secondary,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          labelPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 50.0, 0.0, 0.0),
                          labelStyle: FlutterFlowTheme.of(context).bodyMedium,
                          indicatorColor:
                              FlutterFlowTheme.of(context).secondary,
                          tabs: [
                            Tab(
                              text: 'Reçus',
                            ),
                            Tab(
                              text: 'Donnés',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            KeepAliveWidgetWrapper(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 0.0),
                                child: StreamBuilder<List<AvisRecord>>(
                                  stream: queryAvisRecord(
                                    queryBuilder: (avisRecord) => avisRecord
                                        .where('destinataire',
                                            isEqualTo: currentUserReference)
                                        .orderBy('created_at',
                                            descending: true),
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
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 50.0,
                                          ),
                                        ),
                                      );
                                    }
                                    List<AvisRecord> listViewAvisRecordList =
                                        snapshot.data!;
                                    if (listViewAvisRecordList.isEmpty) {
                                      return AvisRecuVideWidget();
                                    }
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listViewAvisRecordList.length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewAvisRecord =
                                            listViewAvisRecordList[
                                                listViewIndex];
                                        return Container(
                                          decoration: BoxDecoration(),
                                          child: CommentWidget(
                                            key: Key(
                                                'Keyflk_${listViewIndex}_of_${listViewAvisRecordList.length}'),
                                            avis: listViewAvisRecord,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            KeepAliveWidgetWrapper(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 0.0),
                                child: StreamBuilder<List<AvisRecord>>(
                                  stream: queryAvisRecord(
                                    queryBuilder: (avisRecord) => avisRecord
                                        .where('auteur',
                                            isEqualTo: currentUserReference)
                                        .orderBy('created_at',
                                            descending: true),
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
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 50.0,
                                          ),
                                        ),
                                      );
                                    }
                                    List<AvisRecord> listViewAvisRecordList =
                                        snapshot.data!;
                                    if (listViewAvisRecordList.isEmpty) {
                                      return AvisEnvoyeVideWidget();
                                    }
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listViewAvisRecordList.length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewAvisRecord =
                                            listViewAvisRecordList[
                                                listViewIndex];
                                        return Container(
                                          decoration: BoxDecoration(),
                                          child: CommentWidget(
                                            key: Key(
                                                'Key0ax_${listViewIndex}_of_${listViewAvisRecordList.length}'),
                                            avis: listViewAvisRecord,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
