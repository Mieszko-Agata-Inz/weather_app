// ignore_for_file: non_constant_identifier_names, use_super_parameters, use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:weather/weather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/main_components/common_code.dart';
import 'package:weather_app/main_components/components.dart';
import 'package:weather_app/main_components/page_colors.dart';
import 'package:weather_app/api/api.dart';

///
/// weather factory for city name into coordinates conversion,
/// is given the key to the OpenWeatherMap which API is being used
/// to make the conversion
///
WeatherFactory wf = WeatherFactory("c3b644f0c85d9b7d64e4857adb7abd38");

///
/// main screen
///
class LocationWeatherScreen extends StatefulWidget {
  const LocationWeatherScreen({Key? key}) : super(key: key);

  @override
  State<LocationWeatherScreen> createState() => _LocationWeatherScreen();
}

class _LocationWeatherScreen extends State<LocationWeatherScreen> {
  // overlay
  OverlayEntry? entry;
  Offset offset = const Offset(650, 100);
  // controller for city change
  TextEditingController textarea = TextEditingController();
  // name of actual displayed city
  String city_name = "Warszawa";
  String old_city_name = "Warszawa";
  // coordinates of actual city
  double lat = 52.2298;
  double lon = 21.0118;
  // list for weather predicitons to save
  List<WeatherData> data_list = List.empty(growable: true);
  // actual weather to save
  late WeatherData actual_temp;
  // actual time to display
  DateTime now = DateTime.now();
  // does the given city exist
  bool city_exist = true;

  // get predicitons for given city
  Future<Response<Prediction>> getWeather() async {
    return context
        .read<APIProvider>()
        .api
        .getDefaultApi()
        .forecastForecastLatLonGet(lat: lat, lon: lon);
  }

// conversion of given city to the coordinates
  void changeCity(String new_city) async {
    Weather? w;
    try {
      w = await wf.currentWeatherByCityName(new_city);
    } catch (e) {
      print(e);
      // if(e.hashCode == 404)
      // the exception is because:
      // An bad response was given by the API; it may be down.
    }

    if (w != null && w.country != null && w.country! == "PL") {
      setState(() {
        city_exist = true;
        city_name = new_city;
        now = DateTime.now();
      });
      lat = w.latitude!;
      lon = w.longitude!;
    } else {
      setState(() {
        city_exist = false;
      });
    }
  }

  // weather predicitons into data_list and actual_temp
  bool dataToLlist(Prediction? data) {
    if (data == null) return false;
    BuiltList<num> hour0 = data.hour0;
    BuiltList<num> hour1 = data.hour1;
    BuiltList<num> hour2 = data.hour2;
    BuiltList<num> hour3 = data.hour3;
    data_list.clear();
    data_list.add(WeatherData(
        humidity: hour1[0].toInt().toString(),
        wind: (hour1[1] * 0.28).toInt().toString(),
        temperature: hour1[2].toInt().toString(),
        hour: 1));
    data_list.add(WeatherData(
        humidity: hour2[0].toInt().toString(),
        wind: (hour2[1] * 0.28).toInt().toString(),
        temperature: hour2[2].toInt().toString(),
        hour: 2));
    data_list.add(WeatherData(
        humidity: hour3[0].toInt().toString(),
        wind: (hour3[1] * 0.28).toInt().toString(),
        temperature: hour3[2].toInt().toString(),
        hour: 3));

    actual_temp = WeatherData(
        humidity: hour0[0].toInt().toString(),
        wind: (hour0[1] * 0.28).toInt().toString(),
        temperature: (hour0[2]).toInt().toString(),
        hour: 0);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.8,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    clipBehavior: Clip.antiAlias,
                    // future builder for data get request
                    child: FutureBuilder<Response<Prediction>>(
                        future: getWeather().catchError((e) {
                          print(e);
                        }),
                        builder: (context,
                            AsyncSnapshot<Response<Prediction>> response) {
                          if (response.hasData) {
                            dataToLlist(response.data!.data);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.1,
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Row(children: <Widget>[
                                    MainScreenComponents.actualWeatherPanel(
                                        actual_temp.temperature,
                                        actual_temp.wind,
                                        actual_temp.humidity,
                                        DateFormat('h:mm a').format(now),
                                        DateFormat('EEEEE').format(now),
                                        DateFormat('MMM d').format(now),
                                        city_name),
                                  ]),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        for (WeatherData d in data_list)
                                          CommonWidgets.weatherPanel(
                                              d.temperature,
                                              d.wind,
                                              d.humidity,
                                              DateFormat('kk:mm').format(
                                                  now.add(
                                                      Duration(hours: d.hour))),
                                              PageColor.background_col1),
                                      ]),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.1,
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        MainScreenComponents
                                            .actualWeatherPanelCirc(),
                                      ]),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        for (int index = 0; index < 3; index++)
                                          CommonWidgets.weatherPanelCirc(
                                              PageColor.background_col1, true),
                                      ]),
                                ),
                              ],
                            );
                          }
                        }),
                  ),
                ),
              ),
            ),
            // lef menu container
            Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.2,
                color: PageColor.background_col2, // or backgroundcol
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // LOGO
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              'GEOweather',
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.white, fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      // WHICH MODEL
                      Text(
                        'Predictions by',
                        style: StaticTextsStyle.menu_style2,
                      ),
                      Text(
                        'XGBoost&LSTM',
                        style: StaticTextsStyle.menu_style2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      CommonWidgets.dividerWhite(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      // SEARCH
                      Text(
                        'Search city',
                        style: StaticTextsStyle.menu_style,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SearchBar(
                            key: const ValueKey("searchArea"),
                            hintText:
                                city_exist ? null : "No data for this city",
                            controller: textarea,
                            onSubmitted: (_) {
                              changeCity(textarea.text);

                              textarea.clear();
                            },
                            leading: const Icon(
                              Icons.search,
                              color: PageColor.background_col2,
                            ),
                            trailing: const <Widget>[
                              Icon(
                                Icons.wb_sunny_outlined,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      CommonWidgets.dividerWhite(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      // MAP
                      Text(
                        'Open map',
                        style: StaticTextsStyle.menu_style,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Material(
                            color: PageColor.items_col,
                            shadowColor: PageColor.background_col2,
                            elevation: 3,
                            borderRadius: BorderRadius.circular(50),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/second');
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 250,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'geohashes',
                                  style: StaticTextsStyle.predictions_style,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      CommonWidgets.dividerWhite(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
