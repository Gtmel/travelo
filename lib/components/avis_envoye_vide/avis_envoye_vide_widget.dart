import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'avis_envoye_vide_model.dart';
export 'avis_envoye_vide_model.dart';

class AvisEnvoyeVideWidget extends StatefulWidget {
  const AvisEnvoyeVideWidget({Key? key}) : super(key: key);

  @override
  _AvisEnvoyeVideWidgetState createState() => _AvisEnvoyeVideWidgetState();
}

class _AvisEnvoyeVideWidgetState extends State<AvisEnvoyeVideWidget> {
  late AvisEnvoyeVideModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AvisEnvoyeVideModel());

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
        'Vous n\'avez encore laissé aucun avis pour le moment.\n\nDites nous comment se sont déroulés vos voyages pour nous améliorer.',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).titleMedium,
      ),
    );
  }
}
