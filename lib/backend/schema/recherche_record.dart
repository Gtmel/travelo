import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RechercheRecord extends FirestoreRecord {
  RechercheRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "dateDepart" field.
  DateTime? _dateDepart;
  DateTime? get dateDepart => _dateDepart;
  bool hasDateDepart() => _dateDepart != null;

  // "passagers" field.
  int? _passagers;
  int get passagers => _passagers ?? 0;
  bool hasPassagers() => _passagers != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "depart" field.
  String? _depart;
  String get depart => _depart ?? '';
  bool hasDepart() => _depart != null;

  // "destination" field.
  String? _destination;
  String get destination => _destination ?? '';
  bool hasDestination() => _destination != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _dateDepart = snapshotData['dateDepart'] as DateTime?;
    _passagers = snapshotData['passagers'] as int?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _depart = snapshotData['depart'] as String?;
    _destination = snapshotData['destination'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('recherche')
          : FirebaseFirestore.instance.collectionGroup('recherche');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('recherche').doc();

  static Stream<RechercheRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RechercheRecord.fromSnapshot(s));

  static Future<RechercheRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RechercheRecord.fromSnapshot(s));

  static RechercheRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RechercheRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RechercheRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RechercheRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RechercheRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createRechercheRecordData({
  DateTime? dateDepart,
  int? passagers,
  DateTime? createdAt,
  String? depart,
  String? destination,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'dateDepart': dateDepart,
      'passagers': passagers,
      'created_at': createdAt,
      'depart': depart,
      'destination': destination,
    }.withoutNulls,
  );

  return firestoreData;
}
