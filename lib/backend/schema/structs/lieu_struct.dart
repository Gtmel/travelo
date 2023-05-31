// ignore_for_file: unnecessary_getters_setters
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LieuStruct extends FFFirebaseStruct {
  LieuStruct({
    LatLng? position,
    String? nom,
    String? ville,
    String? adresse,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _position = position,
        _nom = nom,
        _ville = ville,
        _adresse = adresse,
        super(firestoreUtilData);

  // "position" field.
  LatLng? _position;
  LatLng? get position => _position;
  set position(LatLng? val) => _position = val;
  bool hasPosition() => _position != null;

  // "nom" field.
  String? _nom;
  String get nom => _nom ?? '';
  set nom(String? val) => _nom = val;
  bool hasNom() => _nom != null;

  // "ville" field.
  String? _ville;
  String get ville => _ville ?? '';
  set ville(String? val) => _ville = val;
  bool hasVille() => _ville != null;

  // "adresse" field.
  String? _adresse;
  String get adresse => _adresse ?? '';
  set adresse(String? val) => _adresse = val;
  bool hasAdresse() => _adresse != null;

  static LieuStruct fromMap(Map<String, dynamic> data) => LieuStruct(
        position: data['position'] as LatLng?,
        nom: data['nom'] as String?,
        ville: data['ville'] as String?,
        adresse: data['adresse'] as String?,
      );

  static LieuStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? LieuStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'position': _position,
        'nom': _nom,
        'ville': _ville,
        'adresse': _adresse,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'position': serializeParam(
          _position,
          ParamType.LatLng,
        ),
        'nom': serializeParam(
          _nom,
          ParamType.String,
        ),
        'ville': serializeParam(
          _ville,
          ParamType.String,
        ),
        'adresse': serializeParam(
          _adresse,
          ParamType.String,
        ),
      }.withoutNulls;

  static LieuStruct fromSerializableMap(Map<String, dynamic> data) =>
      LieuStruct(
        position: deserializeParam(
          data['position'],
          ParamType.LatLng,
          false,
        ),
        nom: deserializeParam(
          data['nom'],
          ParamType.String,
          false,
        ),
        ville: deserializeParam(
          data['ville'],
          ParamType.String,
          false,
        ),
        adresse: deserializeParam(
          data['adresse'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LieuStruct(${toMap()})';
}

LieuStruct createLieuStruct({
  LatLng? position,
  String? nom,
  String? ville,
  String? adresse,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LieuStruct(
      position: position,
      nom: nom,
      ville: ville,
      adresse: adresse,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LieuStruct? updateLieuStruct(
  LieuStruct? lieu, {
  bool clearUnsetFields = true,
}) =>
    lieu
      ?..firestoreUtilData =
          FirestoreUtilData(clearUnsetFields: clearUnsetFields);

void addLieuStructData(
  Map<String, dynamic> firestoreData,
  LieuStruct? lieu,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (lieu == null) {
    return;
  }
  if (lieu.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && lieu.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final lieuData = getLieuFirestoreData(lieu, forFieldValue);
  final nestedData = lieuData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = lieu.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLieuFirestoreData(
  LieuStruct? lieu, [
  bool forFieldValue = false,
]) {
  if (lieu == null) {
    return {};
  }
  final firestoreData = mapToFirestore(lieu.toMap());

  // Add any Firestore field values
  lieu.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLieuListFirestoreData(
  List<LieuStruct>? lieus,
) =>
    lieus?.map((e) => getLieuFirestoreData(e, true)).toList() ?? [];
