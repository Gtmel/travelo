import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'avis_recu_vide_model.dart';
export 'avis_recu_vide_model.dart';

class AvisRecuVideWidget extends StatefulWidget {
  const AvisRecuVideWidget({Key? key}) : super(key: key);

  @override
  _AvisRecuVideWidgetState createState() => _AvisRecuVideWidgetState();
}

class _AvisRecuVideWidgetState extends State<AvisRecuVideWidget> {
  late AvisRecuVideModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AvisRecuVideModel());

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
        'Vous n\'avez encore reçu aucun avis pour le moment.\n\nLors de vos voyages soyez respecteux de vos covoitureurs et recevez des avis positifs.',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).titleMedium,
      ),
    );
  }
}
