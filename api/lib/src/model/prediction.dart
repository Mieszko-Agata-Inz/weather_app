//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'prediction.g.dart';

/// Prediction
///
/// Properties:
/// * [hour0] 
/// * [hour1] 
/// * [hour2] 
/// * [hour3] 
@BuiltValue()
abstract class Prediction implements Built<Prediction, PredictionBuilder> {
  @BuiltValueField(wireName: r'hour0')
  BuiltList<num> get hour0;

  @BuiltValueField(wireName: r'hour1')
  BuiltList<num> get hour1;

  @BuiltValueField(wireName: r'hour2')
  BuiltList<num> get hour2;

  @BuiltValueField(wireName: r'hour3')
  BuiltList<num> get hour3;

  Prediction._();

  factory Prediction([void updates(PredictionBuilder b)]) = _$Prediction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PredictionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Prediction> get serializer => _$PredictionSerializer();
}

class _$PredictionSerializer implements PrimitiveSerializer<Prediction> {
  @override
  final Iterable<Type> types = const [Prediction, _$Prediction];

  @override
  final String wireName = r'Prediction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Prediction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'hour0';
    yield serializers.serialize(
      object.hour0,
      specifiedType: const FullType(BuiltList, [FullType(num)]),
    );
    yield r'hour1';
    yield serializers.serialize(
      object.hour1,
      specifiedType: const FullType(BuiltList, [FullType(num)]),
    );
    yield r'hour2';
    yield serializers.serialize(
      object.hour2,
      specifiedType: const FullType(BuiltList, [FullType(num)]),
    );
    yield r'hour3';
    yield serializers.serialize(
      object.hour3,
      specifiedType: const FullType(BuiltList, [FullType(num)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Prediction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PredictionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'hour0':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(num)]),
          ) as BuiltList<num>;
          result.hour0.replace(valueDes);
          break;
        case r'hour1':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(num)]),
          ) as BuiltList<num>;
          result.hour1.replace(valueDes);
          break;
        case r'hour2':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(num)]),
          ) as BuiltList<num>;
          result.hour2.replace(valueDes);
          break;
        case r'hour3':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(num)]),
          ) as BuiltList<num>;
          result.hour3.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Prediction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PredictionBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

