import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_weather_screen.dart';
import 'package:weather_app/api/api.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/map_screen.dart';

void main() async {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<APIProvider>(
        create: (context) => APIProvider(),
        child: MaterialApp(
          title: 'weather_app',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => const LocationWeatherScreen(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/second': (context) => const MapScreen(),
          },
        ),
      );
}

// class MainPage extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const LocationWeatherScreen();
//   }
// }
