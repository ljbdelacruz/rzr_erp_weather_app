import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:rzr_erp_weather_app/feature/weather/model/weather.dart';

part 'serializers.g.dart';

@SerializersFor([
  Weather,
  WeatherData,
  Main,
  WeatherCondition,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();