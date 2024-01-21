import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_weather_screen.dart';
import 'package:weather_app/api/api.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/map_screen.dart';

void main() async {
  runApp(
    MyApp(
      initRoute: '/main_screen',
      dio: Dio(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initRoute, required this.dio});
  final String initRoute;
  final Dio dio;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<APIProvider>(
        create: (context) => APIProvider(dio),
        child: MaterialApp(
          title: 'weather_app',
          initialRoute: initRoute,
          routes: {
            // when navigating to the "/main_screen" route,
            //build the main screen widget.
            '/main_screen': (context) => const LocationWeatherScreen(),
            // when navigating to the "/map_screen" route,
            //build the map screen widget.
            '/map_screen': (context) => const MapScreen(),
          },
        ),
      );
}
