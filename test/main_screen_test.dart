import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/mocks/mock_prediction.dart';
import 'package:weather_app/screens/location_weather_screen.dart';
import 'package:weather_app/screens/map_screen.dart';

onerrorIgnoreoverflowErrors(
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  bool ifIsOverflowError = false;
  // Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError) {
    ifIsOverflowError = !exception.diagnostics.any(
        (e) => e.value.toString().startsWith("A RenderFlex overflowed by"));
  }
  // Ignore if is overflow error.
  if (ifIsOverflowError) {
    print('Overflow error.');
  } else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  }
}

void main() {
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
    // ignoring widget overflow problems
    FlutterError.onError = onerrorIgnoreoverflowErrors;
    // Load app widget - main screen - using MockAPI
    await tester.pumpWidget(ChangeNotifierProvider<MockAPIProvider>(
      create: (context) => MockAPIProvider(),
      child: MaterialApp(
        initialRoute: '/main_screen',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/main_screen': (context) => const LocationWeatherScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/map_screen': (context) => const MapScreen(),
        },
      ),
    ));

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

    await tester.pumpAndSettle();
    // after pumpAndSettle
    const actualWeatherPanel = Key('actualWeatherPanel');
    const weatherPanel1 = Key('weatherPanel1');
    const weatherPanel2 = Key('weatherPanel2');
    const weatherPanel3 = Key('weatherPanel3');

    expect(find.byKey(searchCityArea), findsOneWidget);
    expect(find.byKey(openMap), findsOneWidget);
    expect(find.byKey(leftMenuMainScreen), findsOneWidget);

    expect(find.byKey(actualWeatherPanel), findsOneWidget);
    expect(find.byKey(weatherPanel1), findsOneWidget);
    expect(find.byKey(weatherPanel2), findsOneWidget);
    expect(find.byKey(weatherPanel3), findsOneWidget);
    expect(find.text('Warszawa'), findsOne);
  });

  testWidgets(
      'enter and find proper text in searchCityArea without getting response from API',
      (tester) async {
    // Load app widget.
    tester.view.physicalSize = const Size(1536, 695);
    // ignoring widget overflow problems
    FlutterError.onError = onerrorIgnoreoverflowErrors;
    // Load app widget - main screen - using MockAPI
    await tester.pumpWidget(ChangeNotifierProvider<MockAPIProvider>(
      create: (context) => MockAPIProvider(),
      child: MaterialApp(
        initialRoute: '/main_screen',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/main_screen': (context) => const LocationWeatherScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/map_screen': (context) => const MapScreen(),
        },
      ),
    ));

    const testKey = Key('searchCityArea');
    await tester.enterText(find.byKey(testKey), 'Iława');
    expect(find.text("Iława"), findsOne);
  });
}
