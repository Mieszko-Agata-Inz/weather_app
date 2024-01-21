// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weather_app/main_components/page_colors.dart';

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

// class for predictions save
class Prediction {
  // list for weather predicitons to save
  late List<WeatherData> data_list;
  // actual weather to save
  late WeatherData actual_temp;

  Prediction() {
    data_list = List.empty(growable: true);
  }

  // weather predicitons into data_list and actual_temp
  bool weatherPredictions(dynamic data) {
    if (data == null) return false;
    try {
      List<dynamic> hour0 = data['hour0'];
      List<dynamic> hour1 = data['hour1'];
      List<dynamic> hour2 = data['hour2'];
      List<dynamic> hour3 = data['hour3'];

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
          temperature: hour0[2].toInt().toString(),
          hour: 0);
      return true;
    } catch (e) {
      return false;
    }
  }
}

///
/// class CommonWidgets for widgets in both location weather and map screens
///

class CommonWidgets {
  ///
  /// single weather panel for future weather data
  ///

  static Widget weatherPanel(String t, String v, String h, String hour,
      int index_number, Color background_col) {
    return Padding(
        key: ValueKey("weatherPanel$index_number"),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.only(
              top: 20, bottom: 30, right: 30, left: 30.0), //
          decoration: BoxDecoration(
            color: background_col, // PageColor.itemscol,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(57, 0, 0, 0),
                offset: Offset(1, 2.0),
                blurStyle: BlurStyle.inner,
              ),
            ],
          ),
          child: SizedBox(
            width: 260,
            height: 150,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        hour,
                        style: StaticTextsStyle.hour_style,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Temperature",
                              style: StaticTextsStyle.predictions_style,
                            ),
                            Text(
                              "Wind",
                              style: StaticTextsStyle.predictions_style,
                            ),
                            Text(
                              "Humidity",
                              style: StaticTextsStyle.predictions_style,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "$t°C",
                              style: StaticTextsStyle.predictions_style,
                            ),
                            Text(
                              "$v m/s",
                              style: StaticTextsStyle.predictions_style,
                            ),
                            Text(
                              "$h %",
                              style: StaticTextsStyle.predictions_style,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  ///
  /// single weather data panel displayed when waiting for data
  ///

  static Widget weatherPanelCirc(
      int index, Color background_col, bool main_screen) {
    return Padding(
      key: ValueKey("weatherPanelCirc$index"),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, bottom: 30, right: 30, left: 30.0),
        decoration: BoxDecoration(
          color: background_col, // PageColor.itemscol,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: PageColor.shadow_col,
              offset: Offset(1, 2.0),
              blurStyle: BlurStyle.inner,
            ),
          ],
        ),
        child: const SizedBox(
          width: 260,
          height: 150,
          child: Center(
            child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: PageColor.circ_col,
                )),
          ),
        ),
      ),
    );
  }

  ///
  /// divider used in menu
  ///
  static Widget dividerWhite() {
    return const Center(
      child: SizedBox(
        width: 85,
        child: Divider(
          color: Colors.white,
        ),
      ),
    );
  }
}
