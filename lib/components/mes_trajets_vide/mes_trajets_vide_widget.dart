import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'mes_trajets_vide_model.dart';
export 'mes_trajets_vide_model.dart';

class MesTrajetsVideWidget extends StatefulWidget {
  const MesTrajetsVideWidget({Key? key}) : super(key: key);

  @override
  _MesTrajetsVideWidgetState createState() => _MesTrajetsVideWidgetState();
}

class _MesTrajetsVideWidgetState extends State<MesTrajetsVideWidget> {
  late MesTrajetsVideModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MesTrajetsVideModel());

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
        'Vous n\'avez aucun trajet programmé pour le moment.\n\nAjoutez un nouveau trajet ou faites une réservation.',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).titleMedium,
      ),
    );
  }
}
