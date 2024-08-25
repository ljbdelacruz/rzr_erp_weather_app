



import 'package:flutter/material.dart';
import 'package:rzr_erp_weather_app/core/service.di.dart';
import 'package:rzr_erp_weather_app/feature/weather/weather_listener.dart';
import 'package:rzr_erp_weather_app/feature/weather/weather_page_bloc.dart';
import 'package:rzr_erp_weather_app/feature/weather/widget/weather_details_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    getWeatherPageBloc().add(FetchWeatherEvent());
    return SafeArea(
      child: Scaffold(
      body: SingleChildScrollView(child:Column(children:[
        weatherBlocListener(context),
        const Text("Weather data"),
        const CurrentWeatherDetailsWidget(),
        const Divider(color: Colors.black, height: 2),
        const FutureWeatherPredictionsWidget(),
      ]))
    ));
  } 
}


class WeatherMoreDetailsPage extends StatelessWidget {
  const WeatherMoreDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      key: const Key("weather_more_details_page"),
      appBar: AppBar(
          title: const Text('Weather Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              
              Navigator.pop(context);
            },
          ),
      ),
      body: const Column(children:[
        WeatherDetailsWidget()
      ])
    ));
  }

  
}