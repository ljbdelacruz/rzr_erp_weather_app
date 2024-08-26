


import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rzr_erp_weather_app/core/const.dart';
import 'package:rzr_erp_weather_app/feature/weather/data/weather_remote_datasource.dart';
import 'package:rzr_erp_weather_app/feature/weather/data/weather_repository.dart';
import 'package:rzr_erp_weather_app/feature/weather/model/weather.dart';
import 'package:rzr_erp_weather_app/feature/weather/weather_page_bloc.dart';

GetIt? serviceLocator = GetIt.instance;

Dio getDio({bool isDebug = false, int maxWidth = 128, bool requestBody = true, bool requestHeader = true, bool request = true, bool error = true, bool responseBody = true}) {
    Dio dio = Dio();
    dio.options.contentType = Headers.jsonContentType;
    if (isDebug) {
      dio.interceptors.add(
        PrettyDioLogger(
            requestBody: requestBody,
            requestHeader: requestHeader,
            request: request,
            maxWidth: maxWidth,
            error: error,
            responseBody: responseBody),
      );
      return dio;
    }
    return Dio();
}


Dio getDIO(){
  return serviceLocator!<Dio>();
}
IWeatherRemoteDatasource getWeatherRemoteDS(){
  return serviceLocator!<WeatherRemoteDataSource>();
}

IWeatherRepository getWeatherRepo(){
  return serviceLocator!<WeatherRepository>();
}

GeolocatorPlatform getGeoLocatorPlatform(){
  return serviceLocator!<GeolocatorPlatform>();
}


/// call this in main
setupServices(){
  serviceLocator?.registerLazySingleton(()=>GeolocatorPlatform.instance);
  serviceLocator?.registerLazySingleton(()=>getDio(isDebug: true));
  serviceLocator?.registerLazySingleton(()=>WeatherRemoteDataSource(dio: getDIO(), apiKey: weatherApiKey));
  serviceLocator?.registerLazySingleton(()=>WeatherRepository(getWeatherRemoteDS(), getGeoLocatorPlatform()));
  setupBloc();
}

WeatherBloc getWeatherPageBloc(){
  return serviceLocator!<WeatherBloc>();
}

setupBloc(){
  serviceLocator?.registerLazySingleton(()=>WeatherBloc(getWeatherRepo()));
}


checkPermission() async {
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    await Geolocator.requestPermission();
  }
}
WeatherData getSelectedWeatherData(){
  return serviceLocator!<WeatherData>();
}
setWeatherData(WeatherData data){
  serviceLocator?.registerLazySingleton(()=>data);
}