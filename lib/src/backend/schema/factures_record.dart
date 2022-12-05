import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'factures_record.g.dart';

abstract class FacturesRecord
    implements Built<FacturesRecord, FacturesRecordBuilder> {
  static Serializer<FacturesRecord> get serializer =>
      _$facturesRecordSerializer;

  String? get name;

  double? get amount;

  String? get status;

  double? get tax;

  String? get uid;

  @BuiltValueField(wireName: 'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: 'vendor_name')
  String? get vendorName;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(FacturesRecordBuilder builder) => builder
    ..name = ''
    ..amount = 0.0
    ..status = ''
    ..tax = 0.0
    ..uid = ''
    ..vendorName = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('factures');

  static Stream<FacturesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<FacturesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  FacturesRecord._();
  factory FacturesRecord([void Function(FacturesRecordBuilder) updates]) =
      _$FacturesRecord;

  static FacturesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createFacturesRecordData({
  String? name,
  double? amount,
  String? status,
  double? tax,
  String? uid,
  DateTime? createdAt,
  String? vendorName,
}) {
  final firestoreData = serializers.toFirestore(
    FacturesRecord.serializer,
    FacturesRecord(
      (f) => f
        ..name = name
        ..amount = amount
        ..status = status
        ..tax = tax
        ..uid = uid
        ..createdAt = createdAt
        ..vendorName = vendorName,
    ),
  );

  return firestoreData;
}
