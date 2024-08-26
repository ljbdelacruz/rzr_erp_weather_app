



import 'package:equatable/equatable.dart';
import 'package:rzr_erp_weather_app/feature/weather/model/weather.dart';

class Success extends Equatable {
  @override
  List<Object?> get props => [];
}


class FetchWeatherSuccess extends Success {
  final Map<String, List<WeatherData>> dailyWeather;
  FetchWeatherSuccess(this.dailyWeather);
}