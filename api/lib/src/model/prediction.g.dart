// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Prediction extends Prediction {
  @override
  final BuiltList<num> hour0;
  @override
  final BuiltList<num> hour1;
  @override
  final BuiltList<num> hour2;
  @override
  final BuiltList<num> hour3;

  factory _$Prediction([void Function(PredictionBuilder)? updates]) =>
      (new PredictionBuilder()..update(updates))._build();

  _$Prediction._(
      {required this.hour0,
      required this.hour1,
      required this.hour2,
      required this.hour3})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(hour0, r'Prediction', 'hour0');
    BuiltValueNullFieldError.checkNotNull(hour1, r'Prediction', 'hour1');
    BuiltValueNullFieldError.checkNotNull(hour2, r'Prediction', 'hour2');
    BuiltValueNullFieldError.checkNotNull(hour3, r'Prediction', 'hour3');
  }

  @override
  Prediction rebuild(void Function(PredictionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PredictionBuilder toBuilder() => new PredictionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Prediction &&
        hour0 == other.hour0 &&
        hour1 == other.hour1 &&
        hour2 == other.hour2 &&
        hour3 == other.hour3;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, hour0.hashCode);
    _$hash = $jc(_$hash, hour1.hashCode);
    _$hash = $jc(_$hash, hour2.hashCode);
    _$hash = $jc(_$hash, hour3.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Prediction')
          ..add('hour0', hour0)
          ..add('hour1', hour1)
          ..add('hour2', hour2)
          ..add('hour3', hour3))
        .toString();
  }
}

class PredictionBuilder implements Builder<Prediction, PredictionBuilder> {
  _$Prediction? _$v;

  ListBuilder<num>? _hour0;
  ListBuilder<num> get hour0 => _$this._hour0 ??= new ListBuilder<num>();
  set hour0(ListBuilder<num>? hour0) => _$this._hour0 = hour0;

  ListBuilder<num>? _hour1;
  ListBuilder<num> get hour1 => _$this._hour1 ??= new ListBuilder<num>();
  set hour1(ListBuilder<num>? hour1) => _$this._hour1 = hour1;

  ListBuilder<num>? _hour2;
  ListBuilder<num> get hour2 => _$this._hour2 ??= new ListBuilder<num>();
  set hour2(ListBuilder<num>? hour2) => _$this._hour2 = hour2;

  ListBuilder<num>? _hour3;
  ListBuilder<num> get hour3 => _$this._hour3 ??= new ListBuilder<num>();
  set hour3(ListBuilder<num>? hour3) => _$this._hour3 = hour3;

  PredictionBuilder() {
    Prediction._defaults(this);
  }

  PredictionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hour0 = $v.hour0.toBuilder();
      _hour1 = $v.hour1.toBuilder();
      _hour2 = $v.hour2.toBuilder();
      _hour3 = $v.hour3.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Prediction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Prediction;
  }

  @override
  void update(void Function(PredictionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Prediction build() => _build();

  _$Prediction _build() {
    _$Prediction _$result;
    try {
      _$result = _$v ??
          new _$Prediction._(
              hour0: hour0.build(),
              hour1: hour1.build(),
              hour2: hour2.build(),
              hour3: hour3.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'hour0';
        hour0.build();
        _$failedField = 'hour1';
        hour1.build();
        _$failedField = 'hour2';
        hour2.build();
        _$failedField = 'hour3';
        hour3.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Prediction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
