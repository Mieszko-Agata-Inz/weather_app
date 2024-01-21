// ignore_for_file: constant_identifier_names

import 'package:weather_app/main_components/common_code.dart';
import 'package:test/test.dart';

// Mock proper data for predictions
const data_proper = {
  'hour0': [1, 2, 3],
  'hour1': [1, 2, 3],
  'hour2': [1, 2, 3],
  'hour3': [1, 2, 3]
};
// Mock not proper data for predictions
const data_not_proper = {
  'hour': [1, 2, 3],
  'hour1': [1, 2, 3],
  'hour2': [1, 2, 3],
  'hour3': [1, 2, 3]
};

void main() {
  test('Object of Prediction class with empty list has been created', () {
    final prediction = Prediction();
    expect(prediction.data_list, List.empty(growable: true));
  });
  test('Object of WeatherData class with specified elements has been created',
      () {
    const weatherData =
        WeatherData(humidity: '80', wind: '20', temperature: '18', hour: 1);
    expect(weatherData.humidity, '80');
    expect(weatherData.wind, '20');
    expect(weatherData.temperature, '18');
    expect(weatherData.hour, 1);
  });

  test(
      'Method weatherPredictions of object of Prediction class with not proper data',
      () {
    final prediction = Prediction();
    bool result = prediction.weatherPredictions(data_not_proper);
    expect(result, false);
    expect(prediction.data_list, List.empty(growable: true));
  });
  test(
      'Method weatherPredictions of object of Prediction class with proper data',
      () {
    final prediction = Prediction();
    bool result = prediction.weatherPredictions(data_proper);
    // function returns true
    expect(result, true);
    // first element in data_list with proper data
    expect(prediction.data_list[0].humidity, '1');
    expect(prediction.data_list[0].wind, '0');
    expect(prediction.data_list[0].temperature, '3');
    expect(prediction.data_list[0].hour, 1);
    // actual_temp with proper data
    expect(prediction.actual_temp.humidity, '1');
    expect(prediction.actual_temp.wind, '0');
    expect(prediction.actual_temp.temperature, '3');
    expect(prediction.actual_temp.hour, 0);
  });
}
