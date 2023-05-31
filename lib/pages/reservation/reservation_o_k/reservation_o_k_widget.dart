import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'reservation_o_k_model.dart';
export 'reservation_o_k_model.dart';

class ReservationOKWidget extends StatefulWidget {
  const ReservationOKWidget({
    Key? key,
    this.voyage,
  }) : super(key: key);

  final VoyageRecord? voyage;

  @override
  _ReservationOKWidgetState createState() => _ReservationOKWidgetState();
}

class _ReservationOKWidgetState extends State<ReservationOKWidget> {
  late ReservationOKModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReservationOKModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      triggerPushNotification(
        notificationTitle: 'Réservation',
        notificationText:
            'Salut, vous venez de recevoir une demande de réservation pour votre trajet',
        notificationSound: 'default',
        userRefs: [widget.voyage!.chauffeur!],
        initialPageName: 'Reservation',
        parameterData: {
          'voyage': widget.voyage,
          'isDriver': true,
        },
      );
    });

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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 80.0, 10.0, 10.0),
                  child: Text(
                    'Félicitations, votre demande de réservation vient d\'être envoyée au conducteur.',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).secondary,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 80.0, 10.0, 10.0),
                  child: Text(
                    'Il dispose de 12 heures pour l\'accepter, au bout desquelles elle sera automatiquement refusée.',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleMedium,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(150.0, 150.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed('MesTrajets');
                    },
                    child: Text(
                      'C\'est compris',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                    ),
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
