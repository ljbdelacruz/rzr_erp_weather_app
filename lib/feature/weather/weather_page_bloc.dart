// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rzr_erp_weather_app/core/service.di.dart';
import 'package:rzr_erp_weather_app/feature/weather/data/weather_repository.dart';
import 'package:rzr_erp_weather_app/feature/weather/model/weather.dart';
import 'package:rzr_erp_weather_app/tools/success.dart';

abstract class WeatherPageEvent extends Equatable {}

abstract class WeatherPageState extends Equatable {}

class FetchWeatherEvent extends WeatherPageEvent {
  @override
  List<Object?> get props => [];
}

class ShowWeatherEvent extends WeatherPageEvent {
  final WeatherData details;
  ShowWeatherEvent(this.details);
  
  @override
  List<Object?> get props => [];
}

class InitialState extends WeatherPageState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends WeatherPageState {
  @override
  List<Object?> get props => [];
}

class ShowWeatherDataState extends WeatherPageState {
  final Map<String, List<WeatherData>> dailyWeather;
  ShowWeatherDataState(this.dailyWeather);

  factory ShowWeatherDataState.fromJson(Map<String, dynamic> json) {
    return ShowWeatherDataState(
      (json['dailyWeather'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).map((item) => WeatherData.fromJson(item as Map<String, dynamic>)).toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dailyWeather': dailyWeather.map(
        (key, value) => MapEntry(
          key,
          value.map((item) => item.toJson()).toList(),
        ),
      ),
    };
  }
  
  @override
  List<Object?> get props => [dailyWeather];
}

class ErrorWeatherState extends WeatherPageState { 
  final String message;
  ErrorWeatherState(this.message);
  
  @override
  List<Object?> get props => [];
}




class WeatherBloc extends HydratedBloc<WeatherPageEvent, WeatherPageState> {
  final IWeatherRepository weatherRepository;
  ShowWeatherDataState? _previousState;

  WeatherPageState? getPreviousState(){
    return _previousState;
  }


  WeatherBloc(this.weatherRepository) : super(InitialState()){
    on<FetchWeatherEvent>((event, emit) async {
      emit(LoadingState());
      var result = await weatherRepository.getWeatherData();
      result.fold(
        (failure) {
          emit(_previousState!);
          // emit(_previousState!);
          // emit(ErrorWeatherState(failure.message));
        },
        (success) => emit(ShowWeatherDataState((success as FetchWeatherSuccess).dailyWeather)),
      );
    });

    on<ShowWeatherEvent>((event, emit) {
      setWeatherData(event.details);
    });
  }

  @override
  WeatherPageState? fromJson(Map<String, dynamic> json) {
    try {
      var result = ShowWeatherDataState.fromJson(json);
      _previousState = result;
      return result;
    } catch (_) {
      return null;
    }
  }

  @override
  void onTransition(Transition<WeatherPageEvent, WeatherPageState> transition) {
    super.onTransition(transition);
    if (transition.nextState is ShowWeatherDataState) {
      _previousState = transition.nextState as ShowWeatherDataState;
    }
  }

  @override
  Map<String, dynamic>? toJson(WeatherPageState state) {
    if (state is ShowWeatherDataState) {
      return state.toJson();
    }
    return null;
  }
}