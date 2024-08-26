import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rzr_erp_weather_app/feature/weather/weather_page.dart';

final appRouter = GoRouter(
  routes: [ 
    GoRoute(
      path:"/",
      builder: (BuildContext context, GoRouterState state) => const WeatherPage(),
      routes: [
        GoRoute(
          path:"details",
          builder: (BuildContext context, GoRouterState state) => const WeatherMoreDetailsPage()
        )
      ]
    )
  ]
);