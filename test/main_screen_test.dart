import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/screens/location_weather_screen.dart';
import 'package:weather_app/screens/map_screen.dart';

void main() {
  testWidgets(
      'ensure all widgets are being displayed on main screen of the usual size',
      (tester) async {
    // mock dio
    String path = 'http://localhost:83/forecast/52.2298/21.0118';
    Dio dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    dioAdapter.onGet(
      path,
      (request) => request.reply(200, {
        'hour0': [1, 2, 3],
        'hour1': [1, 2, 3],
        'hour2': [1, 2, 3],
        'hour3': [1, 2, 3]
      }),
    );

    tester.view.physicalSize = const Size(1536, 695);
    // load app widget - main screen.
    await tester.pumpWidget(ChangeNotifierProvider<APIProvider>(
      create: (context) => APIProvider(dio),
      child: MaterialApp(
        title: 'weather_app',
        initialRoute: '/main_screen',
        routes: {
          // when navigating to the "/main_screen" route,
          //build the main screen widget.
          '/main_screen': (context) => const LocationWeatherScreen(),
          // when navigating to the "/map_screen" route,
          //build the map screen widget.
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

    // after pumpAndSettle
    const actualWeatherPanel = Key('actualWeatherPanel');
    const weatherPanel1 = Key('weatherPanel1');
    const weatherPanel2 = Key('weatherPanel2');
    const weatherPanel3 = Key('weatherPanel3');
    await tester.pumpAndSettle();
    expect(find.byKey(searchCityArea), findsOneWidget);
    expect(find.byKey(openMap), findsOneWidget);
    expect(find.byKey(leftMenuMainScreen), findsOneWidget);

    expect(find.byKey(actualWeatherPanel), findsOneWidget);
    expect(find.byKey(weatherPanel1), findsOneWidget);
    expect(find.byKey(weatherPanel2), findsOneWidget);
    expect(find.byKey(weatherPanel3), findsOneWidget);

    // weather components
    expect(find.text('Warszawa'), findsOne);
    expect(find.text('Temperature'), findsExactly(4));
    expect(find.text('Humidity'), findsExactly(4));
    expect(find.text('Wind'), findsExactly(4));
  });
}
