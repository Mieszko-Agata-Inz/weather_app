import 'package:flutter/material.dart';
import 'package:weather_app/main_components/page_colors.dart';

///
/// class CommonWidgets for widgets in both location weather and map screens
///

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

class CommonWidgets {
  ///
  /// single weather panel for future weather data
  ///

  static Widget weatherPanel(
      String t, String v, String h, String godz, Color background_col) {
    return Padding(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      godz,
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
        ));
  }

  ///
  /// single weather data panel displayed when waiting for data
  ///

  static Widget weatherPanelCirc(Color background_col, bool main_screen) {
    return Padding(
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
        child: SizedBox(
          width: 260,
          height: 150,
          child: Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: main_screen
                  ? const CircularProgressIndicator(
                      color: PageColor.circ_col,
                    )
                  : Image.asset('images/sun.png',
                      scale: 3, filterQuality: FilterQuality.high),
            ),
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
        width: 25,
        child: Divider(
          color: Colors.white,
        ),
      ),
    );
  }
}
