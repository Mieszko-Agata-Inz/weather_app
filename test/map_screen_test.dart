import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/api/api.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify changing of widgets when on map tapped',
        (tester) async {
      // Load app widget.
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => APIProvider(),
        child: MyApp(),
      ));
      const testKey = Key('mapButton');
      await tester.tap(find.byKey(testKey));
      // Rebuild the widget after the state has changed.
      await tester.pump();
      const testKey2 = Key('mapButton');
      // Expect to find the item on screen.
      expect(find.byKey(testKey2), findsOneWidget);
    });
  });
}
