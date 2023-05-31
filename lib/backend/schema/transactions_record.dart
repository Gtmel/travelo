import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionsRecord extends FirestoreRecord {
  TransactionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  bool hasAmount() => _amount != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "numero" field.
  String? _numero;
  String get numero => _numero ?? '';
  bool hasNumero() => _numero != null;

  // "voyage_ref" field.
  DocumentReference? _voyageRef;
  DocumentReference? get voyageRef => _voyageRef;
  bool hasVoyageRef() => _voyageRef != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "MCP_ref" field.
  String? _mCPRef;
  String get mCPRef => _mCPRef ?? '';
  bool hasMCPRef() => _mCPRef != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  void _initializeFields() {
    _amount = snapshotData['amount'] as int?;
    _type = snapshotData['type'] as String?;
    _numero = snapshotData['numero'] as String?;
    _voyageRef = snapshotData['voyage_ref'] as DocumentReference?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _mCPRef = snapshotData['MCP_ref'] as String?;
    _status = snapshotData['status'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TransactionsRecord.fromSnapshot(s));

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TransactionsRecord.fromSnapshot(s));

  static TransactionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TransactionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TransactionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TransactionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TransactionsRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createTransactionsRecordData({
  int? amount,
  String? type,
  String? numero,
  DocumentReference? voyageRef,
  DocumentReference? userRef,
  String? mCPRef,
  String? status,
  DateTime? createdAt,
  DateTime? modifiedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'amount': amount,
      'type': type,
      'numero': numero,
      'voyage_ref': voyageRef,
      'user_ref': userRef,
      'MCP_ref': mCPRef,
      'status': status,
      'created_at': createdAt,
      'modified_at': modifiedAt,
    }.withoutNulls,
  );

  return firestoreData;
}
