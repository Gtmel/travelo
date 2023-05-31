import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime? heureArrivee(
  DateTime heureDepart,
  int duree,
) {
  Duration t = Duration(seconds: duree);

  return (heureDepart.add(t));
}

String? dureeHM(int duree) {
  Duration duration = Duration(seconds: duree);
  final HH = (duration.inHours).toString().padLeft(2, '0');
  final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
  return '$HH:$mm';
}

DateTime? date(
  DateTime datedepart,
  DateTime heuredepart,
) {
  DateTime date = DateTime(datedepart.year, datedepart.month, datedepart.day,
      heuredepart.hour, heuredepart.minute);
  return date;
}

bool? emptyLists(
  int items1,
  int items2,
) {
  int i = items1 + items2;
  bool empty = i == 0;
  return (empty);
}
