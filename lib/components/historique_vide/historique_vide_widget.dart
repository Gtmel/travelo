import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'historique_vide_model.dart';
export 'historique_vide_model.dart';

class HistoriqueVideWidget extends StatefulWidget {
  const HistoriqueVideWidget({Key? key}) : super(key: key);

  @override
  _HistoriqueVideWidgetState createState() => _HistoriqueVideWidgetState();
}

class _HistoriqueVideWidgetState extends State<HistoriqueVideWidget> {
  late HistoriqueVideModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoriqueVideModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 50.0, 10.0, 10.0),
      child: Text(
        'Vous n\'avez encore réalisé  aucun voyage avec nous.\n\nRéservez un voyage et faites l\'expérience !',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).titleMedium,
      ),
    );
  }
}
