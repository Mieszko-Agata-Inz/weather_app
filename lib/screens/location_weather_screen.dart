import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/main_screen_components/drawer.dart';
import 'package:weather_app/screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/api/api.dart';
import 'dart:async';
import 'package:built_collection/built_collection.dart';

class LocationWeatherScreen extends StatefulWidget {
  const LocationWeatherScreen({Key? key}) : super(key: key);

  @override
  State<LocationWeatherScreen> createState() => _LocationWeatherScreen();
}

class _LocationWeatherScreen extends State<LocationWeatherScreen> {
  Future<Response<BuiltList<String>>> basicGet() {
    return context.read<APIProvider>().api.getDefaultApi().rootGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Container(
          child: Row(
            children: const [
              Text(
                'WEATHERapp',
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Color.fromARGB(196, 10, 33, 146),
                  letterSpacing: 0.7,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.beach_access,
                size: 50,
                color: Color.fromARGB(196, 10, 33, 146),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(196, 178, 203, 250),
        // Color.fromARGB(78, 0, 0, 0), //Color.fromARGB(255, 36, 34, 93),
        actions: <Widget>[
          SizedBox(
            width: 144,
            child: Row(
              children: [
                Text('Search lens'),
                IconButton(
                  icon: const Icon(Icons.zoom_in_rounded, size: 50),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: 74,
            child: IconButton(
              icon: const Icon(Icons.map_outlined, size: 50),
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapScreen()));
              },
            ),
          ),
          SizedBox(
            width: 14,
          ),
        ],
      ),
      drawer: DrawerBurger(),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Color.fromARGB(196, 255, 255, 255),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              // child: Padding(
              //   padding: const EdgeInsets.only(top: 100.0),
              //   child: SizedBox(
              //     height: double.infinity,
              //     child: SingleChildScrollView(
              //       physics: const AlwaysScrollableScrollPhysics(),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 100.0,
              //         vertical: 10.0,
              //       ),
              child: Column(
                children: [
                  Row(children: <Widget>[
                    actual_weather_panel(),
                    cloud(),
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        weather_panel(),
                        weather_panel(),
                        weather_panel(),
                      ]),
                  model_switch(),
                ],
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  ///////////////
  /// WIDGETS ///
  ///////////////

  Widget weather_panel() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Container(
          width: 370,
          height: 210,
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(159, 142, 193, 214),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Response<BuiltList<String>>>(
                  future: basicGet(),
                  builder: (context,
                      AsyncSnapshot<Response<BuiltList<String>>> response) {
                    if (response.hasData) {
                      return Text(
                        response.data!.data!.first,
                        style: TextStyle(
                          color: Color.fromARGB(255, 2, 4, 10),
                          fontSize: 26.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return const SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 2, 4, 10),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ));
  }

  Widget actual_weather_panel() {
    return Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 195, bottom: 10),
        child: Container(
          width: 520,
          height: 260,
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(159, 142, 193, 214),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Response<BuiltList<String>>>(
                  future: basicGet(),
                  builder: (context,
                      AsyncSnapshot<Response<BuiltList<String>>> response) {
                    if (response.hasData) {
                      return Text(
                        response.data!.data!.first,
                        style: TextStyle(
                          color: Color.fromARGB(255, 2, 4, 10),
                          fontSize: 26.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return const SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 2, 4, 10),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ));
  }

  Widget cloud() {
    return Container(
      width: 600,
      height: 260,
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 255, 255, 255),
        // image: DecorationImage(
        //     image: AssetImage("images/cloudMy.png"), fit: BoxFit.fitHeight),
      ),
      child: Center(
        child: Icon(Icons.cloud_download, size: 300),
      ),
    );
  }

  Widget model_switch() {
    return Material(
      color: Color.fromARGB(146, 55, 73, 161),
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 200,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Switch ML model',
          ),
        ),
      ),
    );
  }
}
