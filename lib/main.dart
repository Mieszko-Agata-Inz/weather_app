import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:weather_app/screens/location_weather_screen.dart';
import 'package:weather_app/api/api.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/map_screen.dart';

void main() async {
  runApp(
    const MyApp(initRoute: '/main_screen'),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.initRoute,
  });
  final String initRoute;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<APIProvider>(
        create: (context) => APIProvider(),
        child: MaterialApp(
          title: 'weather_app',
          initialRoute: initRoute,
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/main_screen': (context) => const LocationWeatherScreen(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/map_screen': (context) => const MapScreen(),
          },
        ),
      );
}
