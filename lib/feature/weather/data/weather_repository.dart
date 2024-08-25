



import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rzr_erp_weather_app/feature/weather/data/weather_remote_datasource.dart';
import 'package:rzr_erp_weather_app/tools/failure.dart';
import 'package:rzr_erp_weather_app/tools/success.dart';

abstract class IWeatherRepository {
  Future<Either<Failure, Success>> getWeatherData();
  
}


class WeatherRepository extends IWeatherRepository {
  final IWeatherRemoteDatasource remoteDS;
  final GeolocatorPlatform geoLocator;

  WeatherRepository(this.remoteDS, this.geoLocator);
  @override
  Future<Either<Failure, Success>> getWeatherData() async {
    final position = await geoLocator.getCurrentPosition();
    var result = await remoteDS.getWeatherByLongLat(position.latitude, position.longitude);
    return result;
  }

}