import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MCPCallbackRecord extends FirestoreRecord {
  MCPCallbackRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "transaction_amount" field.
  int? _transactionAmount;
  int get transactionAmount => _transactionAmount ?? 0;
  bool hasTransactionAmount() => _transactionAmount != null;

  // "transaction_ref" field.
  String? _transactionRef;
  String get transactionRef => _transactionRef ?? '';
  bool hasTransactionRef() => _transactionRef != null;

  // "transaction_status" field.
  String? _transactionStatus;
  String get transactionStatus => _transactionStatus ?? '';
  bool hasTransactionStatus() => _transactionStatus != null;

  void _initializeFields() {
    _transactionAmount = snapshotData['transaction_amount'] as int?;
    _transactionRef = snapshotData['transaction_ref'] as String?;
    _transactionStatus = snapshotData['transaction_status'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('MCP_callback');

  static Stream<MCPCallbackRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MCPCallbackRecord.fromSnapshot(s));

  static Future<MCPCallbackRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MCPCallbackRecord.fromSnapshot(s));

  static MCPCallbackRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MCPCallbackRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MCPCallbackRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MCPCallbackRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MCPCallbackRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createMCPCallbackRecordData({
  int? transactionAmount,
  String? transactionRef,
  String? transactionStatus,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'transaction_amount': transactionAmount,
      'transaction_ref': transactionRef,
      'transaction_status': transactionStatus,
    }.withoutNulls,
  );

  return firestoreData;
}
