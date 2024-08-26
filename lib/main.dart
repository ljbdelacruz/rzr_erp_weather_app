import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rzr_erp_weather_app/core/app_router.dart';
import 'package:rzr_erp_weather_app/core/service.di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkPermission();
  await setupDependencies();
  Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

setupDependencies() async {
  await dotenv.load(fileName: "assets/.env");
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = storage;  
  setupServices();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
              title: 'Weather App',
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
    );
  }
}
