import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recent_model.dart';
export 'recent_model.dart';

class RecentWidget extends StatefulWidget {
  const RecentWidget({
    Key? key,
    this.depart,
    this.destination,
    this.dateDepart,
    this.passager,
  }) : super(key: key);

  final String? depart;
  final String? destination;
  final DateTime? dateDepart;
  final int? passager;

  @override
  _RecentWidgetState createState() => _RecentWidgetState();
}

class _RecentWidgetState extends State<RecentWidget> {
  late RecentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecentModel());

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
      child: Container(
        width: double.infinity,
        height: 70.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
              child: Icon(
                Icons.autorenew,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 35.0,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 50.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.depart!,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                            ),
                      ),
                      Icon(
                        Icons.arrow_right_alt_sharp,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 36.0,
                      ),
                      Text(
                        widget.destination!,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: dateTimeFormat(
                              'MMMEd',
                              widget.dateDepart,
                              locale: FFLocalizations.of(context).languageCode,
                            ),
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: ' ; ',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: widget.passager.toString(),
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: ' passager(s)',
                            style: TextStyle(),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
              child: Icon(
                Icons.navigate_next,
                color: FlutterFlowTheme.of(context).secondary,
                size: 28.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
