// ignore_for_file: non_constant_identifier_names, use_super_parameters, use_build_context_synchronously

import 'dart:convert';
import 'package:built_value/json_object.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:weather_app/main_screen_components/drawer.dart';
import 'package:weather_app/screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/api/api.dart';
import 'dart:async';
import 'package:weather/weather.dart';
import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';

// weather factory for city into coordinates change
WeatherFactory wf = WeatherFactory("c3b644f0c85d9b7d64e4857adb7abd38");

class LocationWeatherScreen extends StatefulWidget {
  const LocationWeatherScreen({Key? key}) : super(key: key);

  @override
  State<LocationWeatherScreen> createState() => _LocationWeatherScreen();
}

// class for weather params
class WeatherData {
  const WeatherData(
      {required this.temperature,
      required this.humidity,
      required this.wind,
      required this.hour});

  final String temperature;
  final String humidity;
  final String wind;
  final int hour;
}

class _LocationWeatherScreen extends State<LocationWeatherScreen> {
  // controller for city change
  TextEditingController textarea = TextEditingController();
  // name of actual displayed city
  String city_name = "Warszawa";
  String old_city_name = "Warszawa";
  // coordinates of actual city
  double lat = 52;
  double lon = 21;
  // list for weather predicitons to save
  List<WeatherData> data_list = List.empty(growable: true);
  // actual weather to save
  late WeatherData actual_temp;
  // actual time to display
  DateTime now = DateTime.now();

  // try does connection works properly
  Future<Response<JsonObject>> basicGet() {
    return context.read<APIProvider>().api.getDefaultApi().rootGet();
  }

  // get predicitons for given city
  Future<Response<Item>> getWeather() async {
    Weather w = await wf.currentWeatherByCityName(city_name);
    if (w.country! == "PL") {
      lat = w.latitude!;
      lon = w.longitude!;
      old_city_name = city_name;
    } else {
      city_name = old_city_name;
    }
    return context
        .read<APIProvider>()
        .api
        .getDefaultApi()
        .forecastForecastLatLonGet(lat: lat, lon: lon);
  }

  // weather predicitons into data_list and actual_temp
  void dataToLlist(Item? data) {
    // final user = jsonEncode(data);
    //data_list = (data as ListJsonObject) as List<JsonObject>;
    // if (data != null) {
    //   data_list = data;
    // }
    num i = data!.title[0];
    data_list.clear();
    data_list.add(WeatherData(
        temperature: i.toString(), humidity: '77', wind: '8', hour: 1));
    data_list.add(const WeatherData(
        temperature: '-3', humidity: '79', wind: '10', hour: 2));
    data_list.add(const WeatherData(
        temperature: '-2', humidity: '78', wind: '10', hour: 3));

    actual_temp = const WeatherData(
        temperature: '-3', humidity: '79', wind: '10', hour: 2);
  }

  // used colors in app
  Color itemscol = const Color.fromARGB(196, 237, 239, 248);
  Color backgroundcol = const Color.fromARGB(190, 0, 0, 0);
  Color letterscol = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Container(
          child: Row(
            children: [
              Text(
                'WEATHERapp',
                style: TextStyle(
                  color: itemscol,
                  letterSpacing: 0.7,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.beach_access,
                size: 50,
                color: itemscol,
              ),
            ],
          ),
        ),
        backgroundColor: backgroundcol,
        foregroundColor: itemscol,
        // Color.fromARGB(78, 0, 0, 0), //Color.fromARGB(255, 36, 34, 93),
        actions: <Widget>[
          SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: SearchBar(
                controller: textarea,
                onSubmitted: (_) {
                  setState(() {
                    city_name = textarea.text;
                  });
                },
                leading: Icon(
                  Icons.search,
                  color: backgroundcol,
                ),
                trailing: <Widget>[
                  Icon(
                    Icons.wb_sunny_outlined,
                    color: backgroundcol,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 74,
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MapScreen()));
              },
              child: Image.asset('images/map.png',
                  color: itemscol, scale: 3, filterQuality: FilterQuality.high),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
        ],
      ),
      drawer: const DrawerBurger(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/sky.JPG"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 195),
                clipBehavior: Clip.antiAlias,
                child: FutureBuilder<Response<Item>>(
                    future: getWeather(),
                    builder: (context, AsyncSnapshot<Response<Item>> response) {
                      if (response.hasData) {
                        dataToLlist(response.data!.data);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 130.0, bottom: 0),
                              child: Row(children: <Widget>[
                                actual_weather_panel(
                                    actual_temp.temperature,
                                    actual_temp.wind,
                                    actual_temp.humidity,
                                    DateFormat('kk:mm').format(now)),
                                cloud(),
                              ]),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  // Text((context.data!.data! as MapJsonObject)['temp']),
                                  for (WeatherData d in data_list)
                                    weather_panel(
                                        d.temperature,
                                        d.wind,
                                        d.humidity,
                                        DateFormat('kk:mm').format(
                                            now.add(Duration(hours: d.hour)))),
                                ]),
                            // model_switch(), // no model switch fo user available
                          ],
                        );
                      } else {
                        // if there is no data!
                        return Container(
                          width: 1000,
                          height: 600,
                          child: const CircularProgressIndicator(
                            color: Color.fromARGB(255, 2, 4, 10),
                          ),
                        );
                        // return Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(
                        //           top: 110.0, left: 195, bottom: 0),
                        //       child: Row(children: <Widget>[
                        //         actual_weather_panel_circ(),
                        //         // cloud(), // clouds will be changing
                        //       ]),
                        //     ),
                        //     Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: <Widget>[
                        //           for (int index = 0; index < 3; index++)
                        //             weather_panel_circ(),
                        //         ]),
                        //   ],
                        // );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///////////////
  /// WIDGETS ///
  ///////////////

  ///
  /// single weather panel for future data
  ///

  Widget weather_panel(String t, String v, String h, String godz) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.only(
              left: 20.0, top: 40, bottom: 50, right: 140),
          decoration: const BoxDecoration(
            color: Color.fromARGB(122, 0, 0, 0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        godz,
                        style: TextStyle(
                          color: letterscol,
                          letterSpacing: 1.0,
                          fontSize: 40.0,
                          fontFamily: 'MyFont1',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " Temperature: $t°C",
                        style: TextStyle(
                          color: letterscol,
                          letterSpacing: 1.0,
                          fontSize: 20.0,
                          fontFamily: 'MyFont1',
                        ),
                      ),
                      Text(
                        " Wind: $v km/h",
                        style: TextStyle(
                          color: letterscol,
                          letterSpacing: 1.0,
                          fontSize: 20.0,
                          fontFamily: 'MyFont1',
                        ),
                      ),
                      Text(
                        " Humidity: $h%",
                        style: TextStyle(
                          color: letterscol,
                          letterSpacing: 1.0,
                          fontSize: 20.0,
                          fontFamily: 'MyFont1',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  ///
  /// single future weather panel if not data
  ///

  Widget weather_panel_circ() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.only(
              left: 20.0, top: 40, bottom: 50, right: 140),
          decoration: const BoxDecoration(
            color: Color.fromARGB(122, 0, 0, 0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 2, 4, 10),
                ),
              ),
            ],
          ),
        ));
  }

  ///
  /// single weather panel for actual data
  ///

  Widget actual_weather_panel(String t, String v, String h, String godz) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
        width: 500,
        padding: const EdgeInsets.only(left: 20.0, top: 40, bottom: 50),
        decoration: const BoxDecoration(
          color: Color.fromARGB(146, 0, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "$city_name   ${DateFormat('kk:mm').format(now)}",
                      style: TextStyle(
                        color: letterscol,
                        letterSpacing: 1.0,
                        fontSize: 40.0,
                        fontFamily: 'MyFont1',
                      ),
                    ),
                  ],
                ),
                Text(
                  " ($lon, $lat)",
                  style: TextStyle(
                    color: letterscol,
                    letterSpacing: 1.0,
                    fontSize: 20.0,
                    fontFamily: 'MyFont1',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Temperature: $t°C",
                      style: TextStyle(
                        color: letterscol,
                        letterSpacing: 1.0,
                        fontSize: 20.0,
                        fontFamily: 'MyFont1',
                      ),
                    ),
                    Text(
                      " Wind: $v km/h",
                      style: TextStyle(
                        color: letterscol,
                        letterSpacing: 1.0,
                        fontSize: 20.0,
                        fontFamily: 'MyFont1',
                      ),
                    ),
                    Text(
                      " Humidity: $h%",
                      style: TextStyle(
                        color: letterscol,
                        letterSpacing: 1.0,
                        fontSize: 20.0,
                        fontFamily: 'MyFont1',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// single actual weather panel if no data
  ///

  Widget actual_weather_panel_circ() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
        padding:
            const EdgeInsets.only(left: 20.0, top: 40, bottom: 50, right: 180),
        decoration: const BoxDecoration(
          color: Color.fromARGB(160, 0, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 2, 4, 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// icon for weather
  ///

  Widget cloud() {
    return Container(
      padding:
          const EdgeInsets.only(left: 140.0, top: 5, bottom: 5, right: 180),
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 255, 255, 255),
        // image: DecorationImage(
        //     image: AssetImage("images/cloudMy.png"), fit: BoxFit.fitHeight),
      ),
      child: Center(
        child: Image.asset('images/snowing.png',
            scale: 2, filterQuality: FilterQuality.high),
      ),
    );
  }

  ///
  /// if model switch possibility - so far useless
  ///

  Widget model_switch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
      child: Material(
        color: backgroundcol,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 250,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              'switch ML model',
              style: TextStyle(
                color: itemscol,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
