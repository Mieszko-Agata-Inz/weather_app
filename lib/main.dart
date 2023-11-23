import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_weather_screen.dart';
import 'package:weather_app/api/api.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider<APIProvider>(
      create: (context) => APIProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'weather_app',
        home: MainPage(),
      );
}

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const LocationWeatherScreen();
  }
}
