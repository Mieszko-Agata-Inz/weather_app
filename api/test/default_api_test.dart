import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for DefaultApi
void main() {
  final instance = Openapi().getDefaultApi();

  group(DefaultApi, () {
    // Forecast
    //
    // function returns a forecast for a given geohash  geohash - string of a geohash, must correspond to a geohash present in redis
    //
    //Future<Prediction> forecastForecastLatLonGet(num lat, num lon) async
    test('test forecastForecastLatLonGet', () async {
      // TODO
    });

    // Root
    //
    //Future<JsonObject> rootGet() async
    test('test rootGet', () async {
      // TODO
    });

  });
}
