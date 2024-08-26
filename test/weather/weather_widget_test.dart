import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rzr_erp_weather_app/main.dart';

void main() {
  testWidgets('widget test view more details on the current weather', (WidgetTester tester) async {
    // Load environment variables
    await dotenv.load(fileName: "assets/.env");

    // Setup dependencies
    await setupDependencies();

    // Build the MyApp widget
    await tester.pumpWidget(const MyApp());

    // Allow animations to complete
    await tester.pumpAndSettle();

    // Verify that the main weather page is displayed
    expect(find.byKey(const Key("weather_main_page")), findsOneWidget);

    // Find the current weather details button
    final currentWeatherDetailsBtn = find.byKey(const Key("current_weather_details_btn"));

    // Verify that the button is present
    expect(currentWeatherDetailsBtn, findsOneWidget);

    // Simulate a tap on the button
    await tester.tap(currentWeatherDetailsBtn);

    // Rebuild the widget after the state has changed
    await tester.pumpAndSettle();

    // Verify that the details page is displayed
    expect(find.byKey(const Key("weather_details_page")), findsOneWidget);
  });
}