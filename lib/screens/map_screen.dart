import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/api/api.dart';
import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import 'package:weather_app/main_components/common_code.dart';
import 'package:weather_app/main_components/components.dart';
import 'package:weather_app/main_components/page_colors.dart';
import 'package:weather_app/main_components/lat_lon_coord.dart';

///
/// map screen
///

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  // polygons and markers to display
  late Polygon chosen_polygon;
  late Marker marker;
  // coordinates of actual and chosen geohashes
  late double lat2;
  late double lon2;
  // list for weather predicitons to save
  List<WeatherData> data_list = List.empty(growable: true);
  // actual weather to save
  late WeatherData actual_temp;
  // actual time to display
  DateTime now = DateTime.now();
  // get predicitons for given city
  Future<Response<Prediction>> getWeather() async {
    return context
        .read<APIProvider>()
        .api
        .getDefaultApi()
        .forecastForecastLatLonGet(lat: lat2, lon: lon2);
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
        temperature: hour0[2].toInt().toString(),
        hour: 0);
    return true;
  }

  // controller for map
  final MapController _mapController = MapController();

  @override
  void initState() {
    try {
      lat2 = 52.74;
      lon2 = 20.40;
      chosen_polygon = Polygon(
          points: [
            LatLng(lat2 - 0.7, lon2 - 0.7),
            LatLng(lat2 + 0.7, lon2 - 0.7),
            LatLng(lat2 + 0.7, lon2 + 0.7),
            LatLng(lat2 - 0.7, lon2 + 0.7)
          ],
          color: PageColor.chosen_rectangle_col,
          borderStrokeWidth: 2,
          borderColor: PageColor.chosen_rectangle_border_col,
          isFilled: true);

      marker = Marker(
        point: LatLng(lat2, lon2),
        width: 45,
        height: 45,
        child: Image.asset('images/sun.png',
            scale: 2, filterQuality: FilterQuality.high),
      );
    } catch (e) {
      print('blad');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialZoom: 6.7,
              initialCenter: const LatLng(52.1, 19.4560),
              // cameraConstraint: CameraConstraint.contain(
              //     bounds: LatLngBounds(LatLng(59, 34), LatLng(44, 3))),
              backgroundColor: PageColor.items_col,
              onPointerDown: (event, position) {
                setState(() {
                  LatLng point = latLngList[0];
                  double dist, dist2;
                  dist = (position.latitude - point.latitude) *
                          (position.latitude - point.latitude) +
                      (position.longitude - point.longitude) *
                          (position.longitude - point.longitude);

                  for (var el in latLngList) {
                    dist2 = (position.latitude - el.latitude) *
                            (position.latitude - el.latitude) +
                        (position.longitude - el.longitude) *
                            (position.longitude - el.longitude);
                    if (dist2 < dist) {
                      point = el;
                      dist = dist2;
                    }
                  }
                  if (dist <= 1) {
                    lat2 = point.latitude;
                    lon2 = point.longitude;

                    marker = Marker(
                      point: point,
                      width: 45,
                      height: 45,
                      child: Image.asset('images/sun.png',
                          scale: 2, filterQuality: FilterQuality.high),
                    );

                    chosen_polygon = Polygon(
                        points: [
                          LatLng(lat2 - 0.7, lon2 - 0.7),
                          LatLng(lat2 + 0.7, lon2 - 0.7),
                          LatLng(lat2 + 0.7, lon2 + 0.7),
                          LatLng(lat2 - 0.7, lon2 + 0.7)
                        ],
                        color: PageColor.chosen_rectangle_col,
                        borderStrokeWidth: 2,
                        borderColor: PageColor.chosen_rectangle_border_col,
                        isFilled: true);

                    now = DateTime.now();
                  }
                });
              },
            ),
            children: [
              TileLayer(
                key: const ValueKey('map'),
                // errorImage: ,
                urlTemplate:
                    'https://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
              ),
              Container(
                color: const Color.fromARGB(55, 0, 30, 54),
              ),
              PolygonLayer(polygons: [
                chosen_polygon,
              ]),
              MarkerLayer(
                markers: [
                  marker,
                ],
              ),
            ],
          ),
          FutureBuilder<Response<Prediction>>(
              future: getWeather(),
              builder: (context, AsyncSnapshot<Response<Prediction>> response) {
                if (response.hasData) {
                  if (dataToLlist(response.data!.data)) {
                    // if there was data in the response

                    return Stack(children: <Widget>[
                      MapScreenComponents.leftMenuGeoChosen(
                          context, lat2, lon2, actual_temp, now),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.02),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  for (WeatherData d in data_list)
                                    CommonWidgets.weatherPanel(
                                        d.temperature,
                                        d.wind,
                                        d.humidity,
                                        DateFormat('h:mm a').format(
                                            now.add(Duration(hours: d.hour))),
                                        PageColor.background_col3),
                                ]),
                          ),
                        ),
                      ),
                    ]);
                  } else {
                    return MapScreenComponents.waitingForDataScreen(context);
                  }
                } else {
                  return MapScreenComponents.waitingForDataScreen(context);
                }
              }),
        ],
      ),
    );
  }
}
