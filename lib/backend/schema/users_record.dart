import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "vehicle_name" field.
  String? _vehicleName;
  String get vehicleName => _vehicleName ?? '';
  bool hasVehicleName() => _vehicleName != null;

  // "vehicle_url" field.
  String? _vehicleUrl;
  String get vehicleUrl => _vehicleUrl ?? '';
  bool hasVehicleUrl() => _vehicleUrl != null;

  // "note" field.
  double? _note;
  double get note => _note ?? 0.0;
  bool hasNote() => _note != null;

  // "age" field.
  int? _age;
  int get age => _age ?? 0;
  bool hasAge() => _age != null;

  // "vehicule_immatriculation" field.
  String? _vehiculeImmatriculation;
  String get vehiculeImmatriculation => _vehiculeImmatriculation ?? '';
  bool hasVehiculeImmatriculation() => _vehiculeImmatriculation != null;

  // "biographie" field.
  String? _biographie;
  String get biographie => _biographie ?? '';
  bool hasBiographie() => _biographie != null;

  // "nombre_avis" field.
  int? _nombreAvis;
  int get nombreAvis => _nombreAvis ?? 0;
  bool hasNombreAvis() => _nombreAvis != null;

  // "isVerified" field.
  bool? _isVerified;
  bool get isVerified => _isVerified ?? false;
  bool hasIsVerified() => _isVerified != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _vehicleName = snapshotData['vehicle_name'] as String?;
    _vehicleUrl = snapshotData['vehicle_url'] as String?;
    _note = castToType<double>(snapshotData['note']);
    _age = snapshotData['age'] as int?;
    _vehiculeImmatriculation =
        snapshotData['vehicule_immatriculation'] as String?;
    _biographie = snapshotData['biographie'] as String?;
    _nombreAvis = snapshotData['nombre_avis'] as int?;
    _isVerified = snapshotData['isVerified'] as bool?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? vehicleName,
  String? vehicleUrl,
  double? note,
  int? age,
  String? vehiculeImmatriculation,
  String? biographie,
  int? nombreAvis,
  bool? isVerified,
  DateTime? modifiedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'vehicle_name': vehicleName,
      'vehicle_url': vehicleUrl,
      'note': note,
      'age': age,
      'vehicule_immatriculation': vehiculeImmatriculation,
      'biographie': biographie,
      'nombre_avis': nombreAvis,
      'isVerified': isVerified,
      'modified_at': modifiedAt,
    }.withoutNulls,
  );

  return firestoreData;
}
