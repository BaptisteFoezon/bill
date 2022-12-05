// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cars_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CarsRecord> _$carsRecordSerializer = new _$CarsRecordSerializer();

class _$CarsRecordSerializer implements StructuredSerializer<CarsRecord> {
  @override
  final Iterable<Type> types = const [CarsRecord, _$CarsRecord];
  @override
  final String wireName = 'CarsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, CarsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.modele;
    if (value != null) {
      result
        ..add('modele')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.car_id;
    if (value != null) {
      result
        ..add('car_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.user_id;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.factures;
    if (value != null) {
      result
        ..add('factures')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  CarsRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CarsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'modele':
          result.modele = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'car_id':
          result.car_id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user_id':
          result.user_id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'factures':
          result.factures.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$CarsRecord extends CarsRecord {
  @override
  final String? name;
  @override
  final String? modele;
  @override
  final String? car_id;
  @override
  final String? user_id;
  @override
  final BuiltList<DocumentReference<Object?>>? factures;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$CarsRecord([void Function(CarsRecordBuilder)? updates]) =>
      (new CarsRecordBuilder()..update(updates))._build();

  _$CarsRecord._(
      {this.name,
      this.modele,
      this.car_id,
      this.user_id,
      this.factures,
      this.ffRef})
      : super._();

  @override
  CarsRecord rebuild(void Function(CarsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CarsRecordBuilder toBuilder() => new CarsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CarsRecord &&
        name == other.name &&
        modele == other.modele &&
        car_id == other.car_id &&
        user_id == other.user_id &&
        factures == other.factures &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, name.hashCode), modele.hashCode), factures.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CarsRecord')
          ..add('name', name)
          ..add('modele', modele)
          ..add('car_id', car_id)
          ..add('user_id', user_id)
          ..add('factures', factures)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class CarsRecordBuilder implements Builder<CarsRecord, CarsRecordBuilder> {
  _$CarsRecord? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _modele;
  String? get modele => _$this._modele;
  set modele(String? modele) => _$this._modele = modele;

  String? _car_id;
  String? get car_id => _$this._car_id;
  set car_id(String? carId) => _$this._car_id = carId;

  String? _user_id;
  String? get user_id => _$this._user_id;
  set user_id(String? userId) => _$this._user_id = userId;

  ListBuilder<DocumentReference<Object?>>? _factures;
  ListBuilder<DocumentReference<Object?>> get factures =>
      _$this._factures ??= new ListBuilder<DocumentReference<Object?>>();
  set factures(ListBuilder<DocumentReference<Object?>>? factures) =>
      _$this._factures = factures;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  CarsRecordBuilder() {
    CarsRecord._initializeBuilder(this);
  }

  CarsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _modele = $v.modele;
      _car_id = $v.car_id;
      _user_id = $v.user_id;
      _factures = $v.factures?.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CarsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CarsRecord;
  }

  @override
  void update(void Function(CarsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CarsRecord build() => _build();

  _$CarsRecord _build() {
    _$CarsRecord _$result;
    try {
      _$result = _$v ??
          new _$CarsRecord._(
              name: name,
              modele: modele,
              car_id: car_id,
              user_id: user_id,
              factures: _factures?.build(),
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'factures';
        _factures?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CarsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
