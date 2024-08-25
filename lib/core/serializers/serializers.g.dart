// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(City.serializer)
      ..add(Clouds.serializer)
      ..add(Coord.serializer)
      ..add(Main.serializer)
      ..add(Rain.serializer)
      ..add(Sys.serializer)
      ..add(Weather.serializer)
      ..add(WeatherCondition.serializer)
      ..add(WeatherData.serializer)
      ..add(Wind.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(WeatherCondition)]),
          () => new ListBuilder<WeatherCondition>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(WeatherData)]),
          () => new ListBuilder<WeatherData>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
