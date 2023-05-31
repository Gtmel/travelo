import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'date_depart_model.dart';
export 'date_depart_model.dart';

class DateDepartWidget extends StatefulWidget {
  const DateDepartWidget({
    Key? key,
    this.depart,
    this.destination,
    this.dateDepart,
    bool? retour,
  })  : this.retour = retour ?? true,
        super(key: key);

  final FFPlace? depart;
  final FFPlace? destination;
  final DateTime? dateDepart;
  final bool retour;

  @override
  _DateDepartWidgetState createState() => _DateDepartWidgetState();
}

class _DateDepartWidgetState extends State<DateDepartWidget> {
  late DateDepartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DateDepartModel());

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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1E2429),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Date de départ',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 22.0,
                ),
          ),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Quand partez vous ?',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).displaySmall,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                child: FlutterFlowCalendar(
                  color: FlutterFlowTheme.of(context).primary,
                  weekFormat: false,
                  weekStartsMonday: true,
                  initialDate:
                      widget.retour ? widget.dateDepart : getCurrentTimestamp,
                  onChange: (DateTimeRange? newSelectedDate) {
                    setState(
                        () => _model.calendarSelectedDay = newSelectedDate);
                  },
                  titleStyle: TextStyle(),
                  dayOfWeekStyle: TextStyle(),
                  dateStyle: TextStyle(),
                  selectedDateStyle: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  inactiveDateStyle: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  locale: FFLocalizations.of(context).languageCode,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.8, -1.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (_model.calendarSelectedDay!.end >=
                        getCurrentTimestamp) {
                      context.pushNamed(
                        'HeureDepart',
                        queryParams: {
                          'dateDepart': serializeParam(
                            _model.calendarSelectedDay?.start,
                            ParamType.DateTime,
                          ),
                          'depart': serializeParam(
                            widget.depart,
                            ParamType.FFPlace,
                          ),
                          'destination': serializeParam(
                            widget.destination,
                            ParamType.FFPlace,
                          ),
                          'retour': serializeParam(
                            widget.retour,
                            ParamType.bool,
                          ),
                        }.withoutNulls,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Vous ne pouvez pas choisir une date passée',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                          duration: Duration(milliseconds: 2000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryText,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Suivant',
                    textAlign: TextAlign.end,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
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
    );
  }
}
