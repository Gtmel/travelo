import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'transaction_vide_model.dart';
export 'transaction_vide_model.dart';

class TransactionVideWidget extends StatefulWidget {
  const TransactionVideWidget({Key? key}) : super(key: key);

  @override
  _TransactionVideWidgetState createState() => _TransactionVideWidgetState();
}

class _TransactionVideWidgetState extends State<TransactionVideWidget> {
  late TransactionVideModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransactionVideModel());

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
        'Aucune transaction réalisée pour le moment.\n\nTout paiement pour un voyage sera réalisé maximum 24h après sa fin. ',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).titleMedium,
      ),
    );
  }
}
