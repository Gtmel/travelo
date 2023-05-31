import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'reservation_vide_model.dart';
export 'reservation_vide_model.dart';

class ReservationVideWidget extends StatefulWidget {
  const ReservationVideWidget({Key? key}) : super(key: key);

  @override
  _ReservationVideWidgetState createState() => _ReservationVideWidgetState();
}

class _ReservationVideWidgetState extends State<ReservationVideWidget> {
  late ReservationVideModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReservationVideModel());

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
        'Actuellement, aucune demande de réservation n\'a encore été envoyée au conducteur. \n\nRéservez vite et soyez le premier :)',
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).titleMedium,
      ),
    );
  }
}
