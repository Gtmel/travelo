import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/trajet_detail/trajet_detail_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'trajet_details_model.dart';
export 'trajet_details_model.dart';

class TrajetDetailsWidget extends StatefulWidget {
  const TrajetDetailsWidget({
    Key? key,
    this.voyage,
    int? places,
    this.reservationID,
    this.isDriver,
  })  : this.places = places ?? 1,
        super(key: key);

  final DocumentReference? voyage;
  final int places;
  final DocumentReference? reservationID;
  final bool? isDriver;

  @override
  _TrajetDetailsWidgetState createState() => _TrajetDetailsWidgetState();
}

class _TrajetDetailsWidgetState extends State<TrajetDetailsWidget> {
  late TrajetDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrajetDetailsModel());

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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
            'Details trajet',
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
          child: FutureBuilder<VoyageRecord>(
            future: VoyageRecord.getDocumentOnce(widget.voyage!),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: SpinKitDoubleBounce(
                      color: FlutterFlowTheme.of(context).primary,
                      size: 50.0,
                    ),
                  ),
                );
              }
              final columnVoyageRecord = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    wrapWithModel(
                      model: _model.trajetDetailModel,
                      updateCallback: () => setState(() {}),
                      child: TrajetDetailWidget(
                        depart: columnVoyageRecord.depart.adresse,
                        destination: columnVoyageRecord.destination.adresse,
                        duree: columnVoyageRecord.duree,
                        dateDepart: columnVoyageRecord.dateDepart,
                      ),
                    ),
                    Divider(
                      thickness: 5.0,
                      indent: 20.0,
                      endIndent: 30.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 0.0, 0.0),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Prix total pour ',
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          widget.places.toString(),
                                          '1',
                                        ),
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: widget.places.toString() == '1'
                                            ? 'passager :'
                                            : 'passagers :',
                                        style: TextStyle(),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 5.0, 0.0),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: (columnVoyageRecord.prix *
                                                valueOrDefault<int>(
                                                  widget.places,
                                                  1,
                                                ))
                                            .toString(),
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: '  FCFA',
                                        style: TextStyle(),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 5.0,
                      indent: 20.0,
                      endIndent: 30.0,
                    ),
                    FutureBuilder<UsersRecord>(
                      future: UsersRecord.getDocumentOnce(
                          columnVoyageRecord.chauffeur!),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: SpinKitDoubleBounce(
                                color: FlutterFlowTheme.of(context).primary,
                                size: 50.0,
                              ),
                            ),
                          );
                        }
                        final columnUsersRecord = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 5.0, 5.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          columnUsersRecord.displayName,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: columnUsersRecord.age
                                                    .toString(),
                                                style: TextStyle(),
                                              ),
                                              TextSpan(
                                                text: '  ans',
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                columnUsersRecord.nombreAvis ==
                                                        0
                                                    ? 'nouveau'
                                                    : '${formatNumber(
                                                        columnUsersRecord.note,
                                                        formatType:
                                                            FormatType.decimal,
                                                        decimalType: DecimalType
                                                            .commaDecimal,
                                                      )}, ${columnUsersRecord.nombreAvis.toString()} avis',
                                                'nouveau',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ],
                                        ),
                                        if (columnUsersRecord.isVerified)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Ce profil a été vérifié par le support de l\'application.',
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 10.0, 0.0),
                                                  child: Icon(
                                                    Icons.check_circle_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    size: 24.0,
                                                  ),
                                                ),
                                                Text(
                                                  'profil vérifié',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 30.0, 0.0),
                                    child: Container(
                                      width: 80.0,
                                      height: 80.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          columnUsersRecord.photoUrl,
                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2.0,
                              indent: 20.0,
                              endIndent: 30.0,
                            ),
                            if (columnVoyageRecord.description != null &&
                                columnVoyageRecord.description != '')
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      25.0, 10.0, 10.0, 10.0),
                                  child: TextFormField(
                                    controller: _model.textController ??=
                                        TextEditingController(
                                      text: columnVoyageRecord.description,
                                    ),
                                    autofocus: true,
                                    readOnly: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Message du conducteur',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    validator: _model.textControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            if (columnVoyageRecord.description != null &&
                                columnVoyageRecord.description != '')
                              Divider(
                                thickness: 2.0,
                                indent: 20.0,
                                endIndent: 30.0,
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 5.0, 5.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        35.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          columnUsersRecord.vehicleName,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                        Text(
                                          columnUsersRecord
                                              .vehiculeImmatriculation,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 35.0, 0.0),
                                    child: Container(
                                      width: 65.0,
                                      height: 65.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          columnUsersRecord.vehicleUrl,
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqfMbLUIlpKKLKp0qAK2BUmtZJ6bnKrpLG9Q&usqp=CAU',
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2.0,
                              indent: 20.0,
                              endIndent: 30.0,
                            ),
                            Builder(
                              builder: (context) {
                                final userRef =
                                    columnVoyageRecord.passagers.toList();
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: userRef.length,
                                  itemBuilder: (context, userRefIndex) {
                                    final userRefItem = userRef[userRefIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 5.0, 10.0, 5.0),
                                      child: StreamBuilder<UsersRecord>(
                                        stream: UsersRecord.getDocument(
                                            userRefItem),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child: SpinKitDoubleBounce(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 50.0,
                                                ),
                                              ),
                                            );
                                          }
                                          final rowUsersRecord = snapshot.data!;
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        35.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      rowUsersRecord
                                                          .displayName,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: rowUsersRecord
                                                                .age
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '  ans',
                                                            style: TextStyle(),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 30.0, 0.0),
                                                child: Container(
                                                  width: 60.0,
                                                  height: 60.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    valueOrDefault<String>(
                                                      rowUsersRecord.photoUrl,
                                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            if (columnVoyageRecord.passagers.length > 0)
                              Divider(
                                thickness: 2.0,
                                indent: 20.0,
                                endIndent: 30.0,
                              ),
                            if (columnVoyageRecord.passagers
                                .contains(currentUserReference))
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30.0, 10.0, 0.0, 10.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'conversation',
                                        queryParams: {
                                          'chatUser': serializeParam(
                                            columnUsersRecord,
                                            ParamType.Document,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          'chatUser': columnUsersRecord,
                                        },
                                      );
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Contacter ',
                                            style: TextStyle(),
                                          ),
                                          TextSpan(
                                            text: columnUsersRecord.displayName,
                                            style: TextStyle(),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF348076),
                                            ),
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            if (columnVoyageRecord.passagers
                                .contains(currentUserReference))
                              Divider(
                                thickness: 2.0,
                                indent: 20.0,
                                endIndent: 30.0,
                              ),
                            if ((columnVoyageRecord.placesDispo -
                                    columnVoyageRecord.passagers.length) >=
                                0)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 50.0, 0.0, 20.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                      'Reservation',
                                      queryParams: {
                                        'voyage': serializeParam(
                                          columnVoyageRecord,
                                          ParamType.Document,
                                        ),
                                        'reservationID': serializeParam(
                                          widget.reservationID,
                                          ParamType.DocumentReference,
                                        ),
                                        'isDriver': serializeParam(
                                          widget.isDriver,
                                          ParamType.bool,
                                        ),
                                        'prix': serializeParam(
                                          columnVoyageRecord.prix *
                                              valueOrDefault<int>(
                                                widget.places,
                                                1,
                                              ),
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'voyage': columnVoyageRecord,
                                      },
                                    );
                                  },
                                  text: 'Continuer',
                                  options: FFButtonOptions(
                                    width: 130.0,
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                    elevation: 2.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
