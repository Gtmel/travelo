import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AvisRecord extends FirestoreRecord {
  AvisRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "note" field.
  int? _note;
  int get note => _note ?? 0;
  bool hasNote() => _note != null;

  // "commentaire" field.
  String? _commentaire;
  String get commentaire => _commentaire ?? '';
  bool hasCommentaire() => _commentaire != null;

  // "auteur" field.
  DocumentReference? _auteur;
  DocumentReference? get auteur => _auteur;
  bool hasAuteur() => _auteur != null;

  // "destinataire" field.
  DocumentReference? _destinataire;
  DocumentReference? get destinataire => _destinataire;
  bool hasDestinataire() => _destinataire != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _note = snapshotData['note'] as int?;
    _commentaire = snapshotData['commentaire'] as String?;
    _auteur = snapshotData['auteur'] as DocumentReference?;
    _destinataire = snapshotData['destinataire'] as DocumentReference?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('avis');

  static Stream<AvisRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AvisRecord.fromSnapshot(s));

  static Future<AvisRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AvisRecord.fromSnapshot(s));

  static AvisRecord fromSnapshot(DocumentSnapshot snapshot) => AvisRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AvisRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AvisRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AvisRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createAvisRecordData({
  int? note,
  String? commentaire,
  DocumentReference? auteur,
  DocumentReference? destinataire,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'note': note,
      'commentaire': commentaire,
      'auteur': auteur,
      'destinataire': destinataire,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}
