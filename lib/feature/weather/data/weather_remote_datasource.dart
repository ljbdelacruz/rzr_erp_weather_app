import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:rzr_erp_weather_app/core/serializers/serializers.dart';
import 'package:rzr_erp_weather_app/feature/weather/model/weather.dart';
import 'package:rzr_erp_weather_app/tools/failure.dart';
import 'package:rzr_erp_weather_app/tools/success.dart';

abstract class IWeatherRemoteDatasource {
  Future<Either<Failure, Success>> getWeatherByLongLat(double lat, double lon);
}

class WeatherRemoteDataSource extends IWeatherRemoteDatasource {
  final Dio dio;
  final String apiKey;

  WeatherRemoteDataSource({required this.dio, required this.apiKey});

  Future<Either<Failure, Success>> getWeatherByLongLat(double lat, double lon) async {
    try {
      final response = await dio.get('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey');
      if (response.statusCode == 200) {
        final data = response.data;

        // Deserialize JSON to Weather model
        final Weather weather = serializers.deserializeWith(Weather.serializer, data)!;

        // Extract weather data for the next 5 days
        final Map<String, List<WeatherData>> dailyWeather = {};
        for (var weatherData in weather.list) {
          final date = weatherData.dt_txt.split(' ')[0];
          if (!dailyWeather.containsKey(date)) {
            dailyWeather[date] = [];
          }
          dailyWeather[date]!.add(weatherData);
        }
        return Right(FetchWeatherSuccess(dailyWeather));
      } else {
        return Left(RemoteServiceFailure());
      }
    } catch (e) {
      return Left(RemoteServiceFailure());
    }
  }
}