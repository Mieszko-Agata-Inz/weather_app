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

  Future<Response<dynamic>> getDataLonLat(double lon, double lat) {
    return dio.get('$path/$lon/$lat');
  }
}
// class APIProvider extends ChangeNotifier {
//   // initialize the logger
//   APIProvider(Dio providedDio) {
//     WidgetsFlutterBinding.ensureInitialized();
//     dio = Dio();
//     final dioAdapter = DioAdapter(dio: dio);
//     dio.httpClientAdapter = dioAdapter;
//     dioAdapter.onGet(
//       path,
//       (request) => request.reply(200, {
//         'hour0': [1, 2, 3],
//         'hour1': [1, 2, 3],
//         'hour2': [1, 2, 3],
//         'hour3': [1, 2, 3]
//       }),
//     );
//   }
//   String path = 'http://localhost:83/forecast';
//   late Dio dio;

//   Future<Response<dynamic>> getDataLonLat(double lon, double lat) {
//     return dio.get(path);
//   }
// }
