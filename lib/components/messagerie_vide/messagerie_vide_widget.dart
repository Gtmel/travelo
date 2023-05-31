import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'messagerie_vide_model.dart';
export 'messagerie_vide_model.dart';

class MessagerieVideWidget extends StatefulWidget {
  const MessagerieVideWidget({Key? key}) : super(key: key);

  @override
  _MessagerieVideWidgetState createState() => _MessagerieVideWidgetState();
}

class _MessagerieVideWidgetState extends State<MessagerieVideWidget> {
  late MessagerieVideModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessagerieVideModel());

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
        'Vous n\'avez encore reçu aucun message pour le moment.\n\nVous pouvez écrire à un conducteur pour avoir plus de détails sur un trajet.',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).titleMedium,
      ),
    );
  }
}
