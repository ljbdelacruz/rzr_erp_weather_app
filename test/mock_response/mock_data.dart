


import 'package:built_collection/built_collection.dart';
import 'package:rzr_erp_weather_app/feature/weather/model/weather.dart';

WeatherData createMockWeatherData() {
  return WeatherData((b) => b
    ..dt = 1633036800
    ..main.replace(Main((b) => b
      ..temp = 20.0
      ..feels_like = 19.0
      ..temp_min = 18.0
      ..temp_max = 22.0
      ..pressure = 1012
      ..humidity = 80
      ..temp_kf = 1.0))
    ..weather.replace(BuiltList<WeatherCondition>([
      WeatherCondition((b) => b
        ..id = 800
        ..main = 'Clear'
        ..description = 'clear sky'
        ..icon = '01d')
    ]))
    ..clouds.replace(Clouds((b) => b..all = 0))
    ..wind.replace(Wind((b) => b
      ..speed = 3.0
      ..deg = 180
      ..gust = 5.0))
    ..visibility = 10000
    ..pop = 0.0
    ..rain = null
    ..sys.replace(Sys((b) => b..pod = 'd'))
    ..dt_txt = '2021-10-01 12:00:00');
}

Map<String, List<WeatherData>> createMockDailyWeather() {
  return {
    '2021-10-01': [createMockWeatherData()],
    '2021-10-02': [createMockWeatherData()],
  };
}