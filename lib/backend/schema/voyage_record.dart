import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/algolia_manager.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VoyageRecord extends FirestoreRecord {
  VoyageRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  // "places_dispo" field.
  int? _placesDispo;
  int get placesDispo => _placesDispo ?? 0;
  bool hasPlacesDispo() => _placesDispo != null;

  // "prix" field.
  int? _prix;
  int get prix => _prix ?? 0;
  bool hasPrix() => _prix != null;

  // "dateDepart" field.
  DateTime? _dateDepart;
  DateTime? get dateDepart => _dateDepart;
  bool hasDateDepart() => _dateDepart != null;

  // "chauffeur" field.
  DocumentReference? _chauffeur;
  DocumentReference? get chauffeur => _chauffeur;
  bool hasChauffeur() => _chauffeur != null;

  // "passagers" field.
  List<DocumentReference>? _passagers;
  List<DocumentReference> get passagers => _passagers ?? const [];
  bool hasPassagers() => _passagers != null;

  // "depart" field.
  LieuStruct? _depart;
  LieuStruct get depart => _depart ?? LieuStruct();
  bool hasDepart() => _depart != null;

  // "destination" field.
  LieuStruct? _destination;
  LieuStruct get destination => _destination ?? LieuStruct();
  bool hasDestination() => _destination != null;

  // "duree" field.
  int? _duree;
  int get duree => _duree ?? 0;
  bool hasDuree() => _duree != null;

  // "paid" field.
  bool? _paid;
  bool get paid => _paid ?? false;
  bool hasPaid() => _paid != null;

  void _initializeFields() {
    _description = snapshotData['description'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
    _placesDispo = snapshotData['places_dispo'] as int?;
    _prix = snapshotData['prix'] as int?;
    _dateDepart = snapshotData['dateDepart'] as DateTime?;
    _chauffeur = snapshotData['chauffeur'] as DocumentReference?;
    _passagers = getDataList(snapshotData['passagers']);
    _depart = LieuStruct.maybeFromMap(snapshotData['depart']);
    _destination = LieuStruct.maybeFromMap(snapshotData['destination']);
    _duree = snapshotData['duree'] as int?;
    _paid = snapshotData['paid'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('voyage');

  static Stream<VoyageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VoyageRecord.fromSnapshot(s));

  static Future<VoyageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VoyageRecord.fromSnapshot(s));

  static VoyageRecord fromSnapshot(DocumentSnapshot snapshot) => VoyageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VoyageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VoyageRecord._(reference, mapFromFirestore(data));

  static VoyageRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      VoyageRecord.getDocumentFromData(
        {
          'description': snapshot.data['description'],
          'created_at': safeGet(
            () => DateTime.fromMillisecondsSinceEpoch(
                snapshot.data['created_at']),
          ),
          'modified_at': safeGet(
            () => DateTime.fromMillisecondsSinceEpoch(
                snapshot.data['modified_at']),
          ),
          'places_dispo': snapshot.data['places_dispo']?.round(),
          'prix': snapshot.data['prix']?.round(),
          'dateDepart': safeGet(
            () => DateTime.fromMillisecondsSinceEpoch(
                snapshot.data['dateDepart']),
          ),
          'chauffeur': safeGet(
            () => toRef(snapshot.data['chauffeur']),
          ),
          'passagers': safeGet(
            () => snapshot.data['passagers'].map((s) => toRef(s)).toList(),
          ),
          'depart': createLieuStruct(
            position: safeGet(
              () => LatLng(
                (snapshot.data['depart'] ?? {})['_geoloc']['lat'],
                (snapshot.data['depart'] ?? {})['_geoloc']['lng'],
              ),
            ),
            nom: (snapshot.data['depart'] ?? {})['nom'],
            ville: (snapshot.data['depart'] ?? {})['ville'],
            adresse: (snapshot.data['depart'] ?? {})['adresse'],
            create: true,
            clearUnsetFields: false,
          ).toMap(),
          'destination': createLieuStruct(
            position: safeGet(
              () => LatLng(
                (snapshot.data['destination'] ?? {})['_geoloc']['lat'],
                (snapshot.data['destination'] ?? {})['_geoloc']['lng'],
              ),
            ),
            nom: (snapshot.data['destination'] ?? {})['nom'],
            ville: (snapshot.data['destination'] ?? {})['ville'],
            adresse: (snapshot.data['destination'] ?? {})['adresse'],
            create: true,
            clearUnsetFields: false,
          ).toMap(),
          'duree': snapshot.data['duree']?.round(),
          'paid': snapshot.data['paid'],
        },
        VoyageRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<VoyageRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'voyage',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'VoyageRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createVoyageRecordData({
  String? description,
  DateTime? createdAt,
  DateTime? modifiedAt,
  int? placesDispo,
  int? prix,
  DateTime? dateDepart,
  DocumentReference? chauffeur,
  LieuStruct? depart,
  LieuStruct? destination,
  int? duree,
  bool? paid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'description': description,
      'created_at': createdAt,
      'modified_at': modifiedAt,
      'places_dispo': placesDispo,
      'prix': prix,
      'dateDepart': dateDepart,
      'chauffeur': chauffeur,
      'depart': LieuStruct().toMap(),
      'destination': LieuStruct().toMap(),
      'duree': duree,
      'paid': paid,
    }.withoutNulls,
  );

  // Handle nested data for "depart" field.
  addLieuStructData(firestoreData, depart, 'depart');

  // Handle nested data for "destination" field.
  addLieuStructData(firestoreData, destination, 'destination');

  return firestoreData;
}
