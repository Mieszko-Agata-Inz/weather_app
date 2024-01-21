// ignore_for_file: non_constant_identifier_names, use_super_parameters, use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:weather/weather.dart';
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
API_KEY=""
WeatherFactory wf = WeatherFactory(API_KEY);
// logger for logs init
Logger logger = Logger();

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
  // weather prediction to save
  Prediction prediction = Prediction();
  // actual time to display
  DateTime now = DateTime.now();
  // does the given city exist
  bool city_exist = true;
  String status_text_in_search = "No data for this input";

  // get predicitons for given city
  Future<Response<dynamic>> getWeather() async {
    return context.read<APIProvider>().getDataLonLat(lat, lon);
  }

// conversion of given city to the coordinates
  void changeCity(String new_city) async {
    Weather? w;
    try {
      w = await wf.currentWeatherByCityName(new_city);
    } catch (e) {
      logger.e('Error changeCity caught: $e');

      if (e.toString().contains('city not found')) {
        status_text_in_search = "No data for this input";
      } else {
        status_text_in_search = "Connection lost";
      }
      setState(() {
        city_exist = false;
      });
      return;
    }

    if (w.country != null && w.country == "PL") {
      setState(() {
        city_exist = true;
        city_name = new_city;
        now = DateTime.now();
      });
      lat = w.latitude!;
      lon = w.longitude!;
    } else {
      status_text_in_search = "No data for this input";
      setState(() {
        city_exist = false;
      });
    }
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
                    child: FutureBuilder<Response<dynamic>>(
                        future: getWeather().catchError((e) {
                          logger.e('Error caught: $e');
                          return e;
                        }),
                        builder: (context,
                            AsyncSnapshot<Response<dynamic>> response) {
                          if (response.hasData) {
                            if (prediction.weatherPredictions(
                                response.data!.data)) // response.data!
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Row(children: <Widget>[
                                      MainScreenComponents.actualWeatherPanel(
                                          prediction.actual_temp.temperature,
                                          prediction.actual_temp.wind,
                                          prediction.actual_temp.humidity,
                                          DateFormat('h:mm a').format(now),
                                          DateFormat('EEEEE').format(now),
                                          DateFormat('MMM d').format(now),
                                          "${city_name[0].toUpperCase()}${city_name.substring(1).toLowerCase()}"),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          for (WeatherData d
                                              in prediction.data_list)
                                            CommonWidgets.weatherPanel(
                                                d.temperature,
                                                d.wind,
                                                d.humidity,
                                                DateFormat('h:mm a').format(
                                                    now.add(Duration(
                                                        hours: d.hour))),
                                                d.hour,
                                                PageColor.background_col1),
                                        ]),
                                  ),
                                ],
                              );
                            else
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
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
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          for (int index = 0;
                                              index < 3;
                                              index++)
                                            CommonWidgets.weatherPanelCirc(
                                                index + 1,
                                                PageColor.background_col1,
                                                true),
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
                                              index + 1,
                                              PageColor.background_col1,
                                              true),
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
                key: const ValueKey("leftMenuMainScreen"),
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
                            child: Image.asset('images/logoGEO.png',
                                scale: 1.3, filterQuality: FilterQuality.high),
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
                      // MAP
                      Column(
                        children: [
                          Text(
                            'Route to',
                            style: StaticTextsStyle.menu_style,
                          ),
                          Text(
                            'the map screen',
                            style: StaticTextsStyle.menu_style,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Material(
                            key: const ValueKey("openMap"),
                            color: PageColor.items_col,
                            shadowColor: PageColor.background_col2,
                            elevation: 3,
                            borderRadius: BorderRadius.circular(50),
                            child: InkWell(
                              onTap: () {
                                if (Navigator.canPop(context)) {
                                  // If there is, pop to the previous screen
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pushNamed(context, '/map_screen');
                                }
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 250,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'open map',
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
                      // SEARCH
                      Text(
                        'Search Polish city',
                        style: StaticTextsStyle.menu_style,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SearchBar(
                            key: const ValueKey("searchCityArea"),
                            hintText: city_exist ? null : status_text_in_search,
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
                                color: Color.fromARGB(255, 219, 164, 0),
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
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
