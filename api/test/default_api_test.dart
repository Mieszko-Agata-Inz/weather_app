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
    //Future<JsonObject> forecastForecastGeohashGet(JsonObject geohash) async
    test('test forecastForecastGeohashGet', () async {
      // TODO
    });

    // Rawdata
    //
    // function returns all raw data from  timestamp up until now timestamp - unix timestamp in miliseconds, defaults to 1 hour
    //
    //Future<JsonObject> rawdataRawdataTimestampGet(JsonObject timestamp) async
    test('test rawdataRawdataTimestampGet', () async {
      // TODO
    });

    // Root
    //
    //Future<BuiltList<String>> rootGet() async
    test('test rootGet', () async {
      // TODO
    });

    // Update Model
    //
    // function returns all raw data from  timestamp up until now timestamp - unix timestamp in miliseconds, defaults to 1 hour
    //
    //Future<JsonObject> updateModelUpdateStateModelNamePost(String state, String modelName, String reqApiKey, MultipartFile file) async
    test('test updateModelUpdateStateModelNamePost', () async {
      // TODO
    });

  });
}
