import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:path_provider/path_provider.dart';
import 'package:rzr_erp_weather_app/feature/weather/data/weather_repository.dart';
import 'package:rzr_erp_weather_app/feature/weather/weather_page_bloc.dart';
import 'package:rzr_erp_weather_app/tools/failure.dart';
import 'package:rzr_erp_weather_app/tools/success.dart';
import '../mock_response/mock_data.dart';
import 'weather_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WeatherRepository>()])


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();  
  WeatherBloc? weatherBloc;
  MockWeatherRepository? mockWeatherRepository;
  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return '.';
        }
        return null;
      },
    );

      final storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory(),
      );
      HydratedBloc.storage = storage;

      mockWeatherRepository = MockWeatherRepository();
      weatherBloc = WeatherBloc(mockWeatherRepository!);

  });

  group('WeatherBloc', () {
    test('initial state is InitialState', () {

      if(weatherBloc?.getPreviousState() == null) {
        expect(weatherBloc!.state as InitialState, InitialState());        
      } else {
        expect(weatherBloc!.state as ShowWeatherDataState, ShowWeatherDataState(createMockDailyWeather()));
      }
    });

    test("emits [LoadingState, ShowWeatherDataState] when FetchWeatherEvent is added and repository returns success", (){
      when(mockWeatherRepository?.getWeatherData()).thenAnswer(
          (_) async => Right(FetchWeatherSuccess(createMockDailyWeather())),
      );
      weatherBloc?.add(FetchWeatherEvent());
      expectLater(weatherBloc!.state, ShowWeatherDataState(createMockDailyWeather()));
    });

    test("emits [LoadingState, ErrorWeatherState] when FetchWeatherEvent is added and repository returns failure", (){
        when(mockWeatherRepository?.getWeatherData()).thenAnswer(
          (_) async => Left(RemoteServiceFailure()),
        );
        weatherBloc?.add(FetchWeatherEvent());
        expect(weatherBloc?.getPreviousState(), weatherBloc?.state);
    });

    test('fromJson and toJson work correctly', () {
      final state = ShowWeatherDataState(createMockDailyWeather());
      final json = state.toJson();
      final newState = weatherBloc!.fromJson(json);

      expect(newState, state);
    });
  });
}