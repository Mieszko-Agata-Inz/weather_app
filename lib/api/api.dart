import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:openapi/openapi.dart';
import 'package:dio/dio.dart';

class APIProvider extends ChangeNotifier {
  APIProvider() {
    WidgetsFlutterBinding.ensureInitialized();
    api = Openapi(
        dio: Dio(BaseOptions(baseUrl: 'http://localhost:83')),
        serializers: standardSerializers);
  }
  late Openapi api;
}
