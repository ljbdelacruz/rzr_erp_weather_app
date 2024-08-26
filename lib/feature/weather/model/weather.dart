import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:rzr_erp_weather_app/core/serializers/serializers.dart';

part 'weather.g.dart';

abstract class Weather implements Built<Weather, WeatherBuilder> {
  String get cod;
  int get message;
  int get cnt;
  BuiltList<WeatherData> get list;
  City get city;

  Weather._();
  factory Weather([void Function(WeatherBuilder) updates]) = _$Weather;

  static Serializer<Weather> get serializer => _$weatherSerializer;
}

abstract class WeatherData implements Built<WeatherData, WeatherDataBuilder> {
  int get dt;
  Main get main;
  BuiltList<WeatherCondition> get weather;
  Clouds get clouds;
  Wind get wind;
  int get visibility;
  double get pop;
  Rain? get rain; // Make this field nullable
  Sys get sys;
  String get dt_txt;

  WeatherData._();
  factory WeatherData([void Function(WeatherDataBuilder) updates]) = _$WeatherData;

  static Serializer<WeatherData> get serializer => _$weatherDataSerializer;

  static WeatherData fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(WeatherData.serializer, json)!;
  }
  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WeatherData.serializer, this) as Map<String, dynamic>;
  }
}

abstract class Main implements Built<Main, MainBuilder> {
  double get temp;
  double get feels_like;
  double get temp_min;
  double get temp_max;
  int get pressure;
  int get humidity;
  double get temp_kf;

  Main._();
  factory Main([void Function(MainBuilder) updates]) = _$Main;

  static Serializer<Main> get serializer => _$mainSerializer;
}

abstract class WeatherCondition implements Built<WeatherCondition, WeatherConditionBuilder> {
  int get id;
  String get main;
  String get description;
  String get icon;

  WeatherCondition._();
  factory WeatherCondition([void Function(WeatherConditionBuilder) updates]) = _$WeatherCondition;

  static Serializer<WeatherCondition> get serializer => _$weatherConditionSerializer;
}

abstract class Clouds implements Built<Clouds, CloudsBuilder> {
  int get all;

  Clouds._();
  factory Clouds([void Function(CloudsBuilder) updates]) = _$Clouds;

  static Serializer<Clouds> get serializer => _$cloudsSerializer;
}

abstract class Wind implements Built<Wind, WindBuilder> {
  double get speed;
  int get deg;
  double get gust;

  Wind._();
  factory Wind([void Function(WindBuilder) updates]) = _$Wind;

  static Serializer<Wind> get serializer => _$windSerializer;
}

abstract class Rain implements Built<Rain, RainBuilder> {
  @BuiltValueField(wireName: '3h')
  double? get threeHour; // Make this field nullable

  Rain._();
  factory Rain([void Function(RainBuilder) updates]) = _$Rain;

  static Serializer<Rain> get serializer => _$rainSerializer;
}

abstract class Sys implements Built<Sys, SysBuilder> {
  String get pod;

  Sys._();
  factory Sys([void Function(SysBuilder) updates]) = _$Sys;

  static Serializer<Sys> get serializer => _$sysSerializer;
}

abstract class City implements Built<City, CityBuilder> {
  int get id;
  String get name;
  Coord get coord;
  String get country;
  int get population;
  int get timezone;
  int get sunrise;
  int get sunset;

  City._();
  factory City([void Function(CityBuilder) updates]) = _$City;

  static Serializer<City> get serializer => _$citySerializer;
}

abstract class Coord implements Built<Coord, CoordBuilder> {
  double get lon;
  double get lat;

  Coord._();
  factory Coord([void Function(CoordBuilder) updates]) = _$Coord;

  static Serializer<Coord> get serializer => _$coordSerializer;
}