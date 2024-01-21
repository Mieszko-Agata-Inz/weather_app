import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

// class provding API connection

class APIProvider extends ChangeNotifier {
  // initialize the logger
  APIProvider(Dio providedDio) {
    WidgetsFlutterBinding.ensureInitialized();
    dio = providedDio;
  }
  String path = 'http://localhost:83/forecast';
  late Dio dio;

  Future<Response<dynamic>> getDataLonLat(double lat, double lon) {
    return dio.get('$path/$lat/$lon');
  }
}
