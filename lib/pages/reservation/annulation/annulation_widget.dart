import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'annulation_model.dart';
export 'annulation_model.dart';

class AnnulationWidget extends StatefulWidget {
  const AnnulationWidget({
    Key? key,
    this.voyageID,
  }) : super(key: key);

  final DocumentReference? voyageID;

  @override
  _AnnulationWidgetState createState() => _AnnulationWidgetState();
}

class _AnnulationWidgetState extends State<AnnulationWidget> {
  late AnnulationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnnulationModel());

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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: Text(
                    'Annulations et remboursements',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 22.0,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 50.0, 10.0, 10.0),
                  child: Text(
                    'Si vous annulez votre demande de réservation avant que le conducteur ne l\'accepte, aucun frais ne vous sera facturé.',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 10.0),
                  child: Text(
                    'Si vous annulez plus de 24 heures avant le trajet, vous serez intégralement remboursé du prix de votre place, frais de service exceptés.',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 10.0),
                  child: Text(
                    'Si vous annulez dans les 24 heures précédant le trajet, vous serez remboursé de 50% du prix de votre place, frais de service non compris.',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 10.0),
                  child: Text(
                    'Si vous ne vous présentez pas pour le trajet, vous ne recevrez aucun remboursement.',
                    style: FlutterFlowTheme.of(context).bodyMedium,
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
