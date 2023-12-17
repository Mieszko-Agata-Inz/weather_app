import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:openapi/openapi.dart';
import 'package:dio/dio.dart';

class APIProvider extends ChangeNotifier {
  APIProvider() {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      api = Openapi(
          dio: Dio(BaseOptions(
              baseUrl:
                  'http://108.143.184.203:83')), // 'http://108.143.184.203:83')),
          serializers: standardSerializers);
    } catch (e) {
      print("failed to connect");
    }
  }
  late Openapi api;
}
