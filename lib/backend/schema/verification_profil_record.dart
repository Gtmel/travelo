import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VerificationProfilRecord extends FirestoreRecord {
  VerificationProfilRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "utilisateur" field.
  DocumentReference? _utilisateur;
  DocumentReference? get utilisateur => _utilisateur;
  bool hasUtilisateur() => _utilisateur != null;

  // "immatriculation" field.
  String? _immatriculation;
  String get immatriculation => _immatriculation ?? '';
  bool hasImmatriculation() => _immatriculation != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "identite_recto" field.
  String? _identiteRecto;
  String get identiteRecto => _identiteRecto ?? '';
  bool hasIdentiteRecto() => _identiteRecto != null;

  // "identite_verso" field.
  String? _identiteVerso;
  String get identiteVerso => _identiteVerso ?? '';
  bool hasIdentiteVerso() => _identiteVerso != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  // "commentaire" field.
  String? _commentaire;
  String get commentaire => _commentaire ?? '';
  bool hasCommentaire() => _commentaire != null;

  // "birthdate" field.
  DateTime? _birthdate;
  DateTime? get birthdate => _birthdate;
  bool hasBirthdate() => _birthdate != null;

  // "expirationdate" field.
  DateTime? _expirationdate;
  DateTime? get expirationdate => _expirationdate;
  bool hasExpirationdate() => _expirationdate != null;

  // "numero_id" field.
  int? _numeroId;
  int get numeroId => _numeroId ?? 0;
  bool hasNumeroId() => _numeroId != null;

  // "birthplace" field.
  String? _birthplace;
  String get birthplace => _birthplace ?? '';
  bool hasBirthplace() => _birthplace != null;

  void _initializeFields() {
    _utilisateur = snapshotData['utilisateur'] as DocumentReference?;
    _immatriculation = snapshotData['immatriculation'] as String?;
    _status = snapshotData['status'] as String?;
    _identiteRecto = snapshotData['identite_recto'] as String?;
    _identiteVerso = snapshotData['identite_verso'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
    _commentaire = snapshotData['commentaire'] as String?;
    _birthdate = snapshotData['birthdate'] as DateTime?;
    _expirationdate = snapshotData['expirationdate'] as DateTime?;
    _numeroId = snapshotData['numero_id'] as int?;
    _birthplace = snapshotData['birthplace'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('verification_profil');

  static Stream<VerificationProfilRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VerificationProfilRecord.fromSnapshot(s));

  static Future<VerificationProfilRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => VerificationProfilRecord.fromSnapshot(s));

  static VerificationProfilRecord fromSnapshot(DocumentSnapshot snapshot) =>
      VerificationProfilRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VerificationProfilRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VerificationProfilRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VerificationProfilRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createVerificationProfilRecordData({
  DocumentReference? utilisateur,
  String? immatriculation,
  String? status,
  String? identiteRecto,
  String? identiteVerso,
  DateTime? createdAt,
  DateTime? modifiedAt,
  String? commentaire,
  DateTime? birthdate,
  DateTime? expirationdate,
  int? numeroId,
  String? birthplace,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'utilisateur': utilisateur,
      'immatriculation': immatriculation,
      'status': status,
      'identite_recto': identiteRecto,
      'identite_verso': identiteVerso,
      'created_at': createdAt,
      'modified_at': modifiedAt,
      'commentaire': commentaire,
      'birthdate': birthdate,
      'expirationdate': expirationdate,
      'numero_id': numeroId,
      'birthplace': birthplace,
    }.withoutNulls,
  );

  return firestoreData;
}
