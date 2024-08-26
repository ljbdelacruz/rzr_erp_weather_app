import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzr_erp_weather_app/core/service.di.dart';
import 'package:rzr_erp_weather_app/feature/weather/weather_page_bloc.dart';

Widget weatherBlocListener(BuildContext context){
    return BlocListener(
      bloc: getWeatherPageBloc(),
      child: Container(),
      listener: (context, state) {
        if (state is ErrorWeatherState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error fetching the weather data"),
          ));
        }
      });
}