import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
        'ensure all widgets are being displayed on main screen usual size',
        (tester) async {
      tester.view.physicalSize = const Size(1536, 695);
      // Load app widget - main screen.
      await tester.pumpWidget(const MyApp(initRoute: '/main_screen'));

      const searchCityArea = Key('searchCityArea');
      const openMap = Key('openMap');
      const leftMenuMainScreen = Key('leftMenuMainScreen');
      const actualWeatherPanelCirc = Key('actualWeatherPanelCirc');
      const weatherPanelCirc1 = Key('weatherPanelCirc1');
      const weatherPanelCirc2 = Key('weatherPanelCirc2');
      const weatherPanelCirc3 = Key('weatherPanelCirc3');

      expect(find.byKey(searchCityArea), findsOneWidget);
      expect(find.byKey(openMap), findsOneWidget);
      expect(find.byKey(leftMenuMainScreen), findsOneWidget);

      expect(find.byKey(actualWeatherPanelCirc), findsOneWidget);
      expect(find.byKey(weatherPanelCirc1), findsOneWidget);
      expect(find.byKey(weatherPanelCirc2), findsOneWidget);
      expect(find.byKey(weatherPanelCirc3), findsOneWidget);

      // after pumpAndSettle
      // const actualWeatherPanel = Key('actualWeatherPanel');
      // const weatherPanel1 = Key('weatherPanel1');
      // const weatherPanel2 = Key('weatherPanel2');
      // const weatherPanel3 = Key('weatherPanel3');
      // await tester.pumpAndSettle();
      // expect(find.byKey(searchCityArea), findsOneWidget);
      // expect(find.byKey(openMap), findsOneWidget);
      // expect(find.byKey(leftMenuMainScreen), findsOneWidget);

      // expect(find.byKey(actualWeatherPanel), findsOneWidget);
      // expect(find.byKey(weatherPanel1), findsOneWidget);
      // expect(find.byKey(weatherPanel2), findsOneWidget);
      // expect(find.byKey(weatherPanel3), findsOneWidget);
      // expect(find.text('Warszawa1'), findsOne);
    });

    testWidgets(
        'widgets are being displayed on main screen usual size divided by 3',
        (tester) async {
      tester.view.physicalSize = const Size(500, 200);
      // Load app widget - main screen.
      await tester.pumpWidget(const MyApp(initRoute: '/main_screen'));

      const searchCityArea = Key('searchCityArea');
      const openMap = Key('openMap');
      const leftMenuMainScreen = Key('leftMenuMainScreen');
      const actualWeatherPanelCirc = Key('actualWeatherPanelCirc');
      const weatherPanelCirc1 = Key('weatherPanelCirc1');
      const weatherPanelCirc2 = Key('weatherPanelCirc2');
      const weatherPanelCirc3 = Key('weatherPanelCirc3');

      expect(find.byKey(searchCityArea), findsOneWidget);
      expect(find.byKey(openMap), findsOneWidget);
      expect(find.byKey(leftMenuMainScreen), findsOneWidget);

      expect(find.byKey(actualWeatherPanelCirc), findsOneWidget);
      expect(find.byKey(weatherPanelCirc1), findsOneWidget);
      expect(find.byKey(weatherPanelCirc2), findsOneWidget);
      expect(find.byKey(weatherPanelCirc3), findsOneWidget);
    });

    testWidgets(
        'enter proper text in searchCityArea without getting response from API',
        (tester) async {
      // Load app widget.
      tester.view.physicalSize = const Size(1536, 695);
      // Load app widget - main screen.
      await tester.pumpWidget(const MyApp(initRoute: '/main_screen'));
      const testKey = Key('searchCityArea');
      await tester.enterText(find.byKey(testKey), 'Iława');
      expect(find.text("Iława"), findsOne);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      expect(find.text("Iława"), findsNothing);
    });

    testWidgets('enter not proper text in searchCityArea', (tester) async {
      // Load app widget.
      tester.view.physicalSize = const Size(1536, 695);
      // Load app widget - main screen.
      await tester.pumpWidget(const MyApp(initRoute: '/main_screen'));
      const testKey = Key('searchCityArea');
      await tester.enterText(find.byKey(testKey), 'Il');
      expect(find.text("Il"), findsOne);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      await tester.pump();
      expect(find.text("No data for this city"), findsNothing);
    });
  });
}
