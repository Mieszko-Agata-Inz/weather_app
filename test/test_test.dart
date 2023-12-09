import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// import 'package:introduction/main.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/screens/location_weather_screen.dart';
import 'package:weather_app/api/api.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      // Load app widget.
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => APIProvider(),
        child: MyApp(),
      ));

      // Verify the counter starts at 0.
      expect(find.text('WEATHERapp'), findsOneWidget);
    });
  });
}
