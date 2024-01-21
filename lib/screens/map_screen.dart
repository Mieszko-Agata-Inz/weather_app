// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/api/api.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

import 'package:weather_app/main_components/common_code.dart';
import 'package:weather_app/main_components/components.dart';
import 'package:weather_app/main_components/page_colors.dart';
import 'package:weather_app/main_components/lat_lon_coord.dart';

///
/// map screen
///

/// logger for logs init
Logger logger = Logger();

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
  // weather prediction to save
  Prediction prediction = Prediction();
  // actual time to display
  DateTime now = DateTime.now();
  // get predicitons for given city
  Future<Response<dynamic>> getWeather() async {
    return context.read<APIProvider>().getDataLonLat(lat2, lon2);
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
        child: Image.asset('images/hash2.png',
            scale: 2, filterQuality: FilterQuality.high),
      );
    } catch (e) {
      logger.e('Failed to connect localhost:83. Error caught: $e');
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
              backgroundColor: const Color.fromARGB(230, 1, 23, 36),
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
                      child: Image.asset('images/hash2.png',
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
                    // 'https://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
          FutureBuilder<Response<dynamic>>(
              future: getWeather().catchError((e) {
                logger.e('Error caught: $e');
                return e;
              }),
              builder: (context, AsyncSnapshot<Response<dynamic>> response) {
                if (response.hasData) {
                  if (prediction.weatherPredictions(response.data!.data)) {
                    // if there was data in the response

                    return Stack(children: <Widget>[
                      MapScreenComponents.leftMenuGeoChosen(
                          context, lat2, lon2, prediction.actual_temp, now),
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
                                  for (WeatherData d in prediction.data_list)
                                    CommonWidgets.weatherPanel(
                                        d.temperature,
                                        d.wind,
                                        d.humidity,
                                        DateFormat('h:mm a').format(
                                            now.add(Duration(hours: d.hour))),
                                        d.hour,
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
