import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recherche_vide_model.dart';
export 'recherche_vide_model.dart';

class RechercheVideWidget extends StatefulWidget {
  const RechercheVideWidget({Key? key}) : super(key: key);

  @override
  _RechercheVideWidgetState createState() => _RechercheVideWidgetState();
}

class _RechercheVideWidgetState extends State<RechercheVideWidget> {
  late RechercheVideModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RechercheVideModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
      child: Text(
        'Désolé aucun voyage ne correspond à vos critères pour le moment.\n\nRéessayez plus tard ou essayez une autre date',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).titleMedium,
      ),
    );
  }
}
