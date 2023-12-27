import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/main_components/common_code.dart';
import 'package:weather_app/main_components/page_colors.dart';

///////////////
/// WIDGETS ///
///////////////

class MainScreenComponents {
  ///
  /// single weather panel for actual data
  ///

  static Widget actualWeatherPanel(String t, String v, String h, String hour,
      String day_name, String date, String city_name) {
    return Padding(
      key: const ValueKey("actualWeatherPanel"),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
        width: 900,
        padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
        decoration: const BoxDecoration(
          // color: Color.fromARGB(0, 0, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
          width: 810,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$hour   $date',
                style: StaticTextsStyle.hour_style,
              ),
              Row(
                children: [
                  Text(
                    city_name,
                    style: StaticTextsStyle.city_name_style,
                  ),
                ],
              ),
              SizedBox(
                width: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// single actual weather panel if no data
  ///

  static Widget actualWeatherPanelCirc() {
    return Padding(
      key: const ValueKey("actualWeatherPanelCirc"),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
        width: 900,
        padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: const SizedBox(
          width: 810,
          height: 300,
          child: Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: PageColor.circ_col,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///////////////
/// WIDGETS ///
///////////////
///
class MapScreenComponents {
  ///
  /// Widget with left menu when geohash not chosen
  ///
  static Widget leftMenu(BuildContext context) {
    return Container(
        key: const ValueKey("leftMenu"),
        alignment: Alignment.topLeft,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.2,
        color: PageColor.background_col2,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // LOGO
              const SizedBox(
                height: 10,
              ),
              Text(
                'GEOweather',
                style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 30),
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
              Text(
                'Close map',
                style: StaticTextsStyle.menu_style,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.18,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Material(
                    key: const ValueKey("closeMap"),
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
                          Navigator.pushNamed(context, '/main_screen');
                        }
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 250,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'weather',
                          style: StaticTextsStyle.predictions_style,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //SEARCH
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              CommonWidgets.dividerWhite(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Geohash weather',
                style: StaticTextsStyle.menu_style,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ));
  }

  ///
  /// Widget with left menu when geohash chosen
  ///
  ///

  static Widget leftMenuGeoChosen(BuildContext context, double lat, double lon,
      WeatherData actual_temp, DateTime now) {
    return Container(
        key: const ValueKey("leftMenuGeoChosen"),
        alignment: Alignment.topLeft,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.2,
        color: PageColor.background_col2,
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
              // MAP
              Text(
                'Close map',
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
                        if (Navigator.canPop(context)) {
                          // If there is, pop to the previous screen
                          Navigator.pop(context);
                        } else {
                          Navigator.pushNamed(context, '/main_screen');
                        }
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 250,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'weather',
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
              Text(
                'Geohash weather',
                style: StaticTextsStyle.menu_style,
              ),
              Text(
                "($lat, $lon)",
                style: StaticTextsStyle.hour_style,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Actual',
                style: StaticTextsStyle.menu_style,
              ),
              geohashPanel(
                  actual_temp.temperature,
                  actual_temp.wind,
                  actual_temp.humidity,
                  DateFormat('h:mm a')
                      .format(now.add(Duration(hours: actual_temp.hour)))),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ));
  }

  ///
  /// panel in left menu for actual weather display
  ///

  static Widget geohashPanel(String t, String v, String h, String godz) {
    return Padding(
        key: const ValueKey("geohashPanel"),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          width: 260,
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
        ));
  }

  static Widget waitingForDataScreen(BuildContext context) {
    return Stack(children: <Widget>[
      MapScreenComponents.leftMenu(context),
      Container(
        alignment: Alignment.centerRight,
        child: Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int index = 0; index < 3; index++)
                    CommonWidgets.weatherPanelCirc(
                        index + 1, PageColor.background_col3, false),
                ]),
          ),
        ),
      ),
    ]);
  }
}
