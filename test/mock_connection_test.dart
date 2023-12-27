import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/mocks/mock_prediction.dart';

void main() {
  test("Testing the mock network call", () async {
    final mockAPIProvider = MockAPIProvider();
    final item = await mockAPIProvider.fetchPosts();
    expect(item.hour0, [0, 0, 0]);
    expect(item.hour3, [3, 3, 3]);
  });
}
