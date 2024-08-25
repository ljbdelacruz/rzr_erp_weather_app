import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rzr_erp_weather_app/core/service.di.dart';
import 'package:rzr_erp_weather_app/feature/weather/data/weather_remote_datasource.dart';

main(){

  Dio? dio;
  IWeatherRemoteDatasource? remoteDS;
  String? apiKey = "37ea9939152496e5de6ca532f93817fd";

  setUp(() async {
    dio = getDio(isDebug: true);
    remoteDS = WeatherRemoteDataSource(dio: dio!, apiKey: apiKey);
  });

  group("test", (){
    test("test getWeatherByLatLong", () async {
      double lat = 14.860071;
      double lon = 121.040932;
      var result = await remoteDS?.getWeatherByLongLat(lat, lon);
      expect(result?.isRight(), true);
    });
  });
}