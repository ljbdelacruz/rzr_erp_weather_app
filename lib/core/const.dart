import 'package:flutter_dotenv/flutter_dotenv.dart';

String weatherApiKey = dotenv.get('OPEN_WEATHER_KEY', fallback: 'no weather key set');

