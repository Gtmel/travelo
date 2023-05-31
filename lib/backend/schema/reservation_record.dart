import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReservationRecord extends FirestoreRecord {
  ReservationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_ID" field.
  DocumentReference? _userID;
  DocumentReference? get userID => _userID;
  bool hasUserID() => _userID != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "date_voyage" field.
  DateTime? _dateVoyage;
  DateTime? get dateVoyage => _dateVoyage;
  bool hasDateVoyage() => _dateVoyage != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "payment" field.
  int? _payment;
  int get payment => _payment ?? 0;
  bool hasPayment() => _payment != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _userID = snapshotData['user_ID'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _dateVoyage = snapshotData['date_voyage'] as DateTime?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _payment = snapshotData['payment'] as int?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('reservation')
          : FirebaseFirestore.instance.collectionGroup('reservation');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('reservation').doc();

  static Stream<ReservationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReservationRecord.fromSnapshot(s));

  static Future<ReservationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReservationRecord.fromSnapshot(s));

  static ReservationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReservationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReservationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReservationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReservationRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createReservationRecordData({
  DocumentReference? userID,
  String? status,
  DateTime? dateVoyage,
  DateTime? createdAt,
  int? payment,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_ID': userID,
      'status': status,
      'date_voyage': dateVoyage,
      'created_at': createdAt,
      'payment': payment,
    }.withoutNulls,
  );

  return firestoreData;
}
