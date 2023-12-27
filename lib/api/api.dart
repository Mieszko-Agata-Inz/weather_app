import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:openapi/openapi.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class APIProvider extends ChangeNotifier {
  // Initialize the logger
  Logger logger = Logger();
  APIProvider() {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      api = Openapi(
          dio: Dio(BaseOptions(
            baseUrl: 'http://localhost:83',
          )), // 'http://108.143.184.203:83')),
          serializers: standardSerializers);
    } catch (e) {
      // Log the error using the logger
      logger.e('Failed to connect localhost:83. Error caught: $e');
    }
  }
  late Openapi api;
}
