


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzr_erp_weather_app/core/service.di.dart';
// import 'package:rzr_erp_weather_app/feature/weather/model/weather.dart';
import 'package:rzr_erp_weather_app/feature/weather/weather_page_bloc.dart';

class CurrentWeatherDetailsWidget extends StatelessWidget {
  const CurrentWeatherDetailsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherPageState>(
          bloc: getWeatherPageBloc(),
          builder: (context, state) {
            if(state is ShowWeatherDataState){
              var currentWeatherData = state.dailyWeather.entries.first.value.first;
              var currentTemp = currentWeatherData.main.temp - 273.15;
              return InkWell(onTap:(){
                getWeatherPageBloc().add(ShowWeatherEvent(currentWeatherData));
                context.go("/details");
              }, child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("My Weather"),
                  Text("Current Weather: ${currentWeatherData.weather.first.main}"),
                  Text("Temperature: ${currentTemp.toStringAsFixed(2)}"),
                ],
              ));
            } else {
              return const Text("No Weather Details available");
            }
    });
  }
}


class FutureWeatherPredictionsWidget extends StatelessWidget {
  const FutureWeatherPredictionsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherPageState>(
          bloc: getWeatherPageBloc(),
          builder: (context, state) {
            if(state is ShowWeatherDataState){
              List<Widget> items = [];

              for (var element in state.dailyWeather.entries) {
                var currentWeatherData = element.value.first;
                var currentTemp = currentWeatherData.main.temp - 273.15;
                items.add(InkWell(onTap:(){
                    getWeatherPageBloc().add(ShowWeatherEvent(currentWeatherData));
                    context.go("/details");
              }, child: Column(
                  children: [
                    Text("Date: ${element.key}"),
                    Text("Current Weather: ${currentWeatherData.weather.first.main}"),
                    Text("Temperature: ${currentTemp.toStringAsFixed(2)}"),
                    Text("Humidity: ${currentWeatherData.main.humidity}"),
                    Text("Wind Speed: ${currentWeatherData.wind.speed.toStringAsFixed(2)}"),
                  ],
                )));
                items.add(const Divider(height: 1, color: Colors.black));
              }
              return Column(children:items);

            } else {
              return const Text("No Weather Data Available");
            }
      });
  }
}

class WeatherDetailsWidget extends StatelessWidget {
  const WeatherDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var details = getSelectedWeatherData();
              return Column(
                children: [
                  Text("Current Weather: ${details.weather.first.main}"),
                  Text("Temperature: ${(details.main.temp - 273.15).toStringAsFixed(2)}"),
                  Text("Humidity: ${details.main.humidity}"),
                  Text("Wind Speed: ${details.wind.speed}"),
                ],
              );
  }

  
}