import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('widgets are being displayed on map screen usual size',
        (tester) async {
      tester.view.physicalSize = const Size(1536, 695);
      // Load app widget.
      await tester.pumpWidget(const MyApp(initRoute: '/map_screen'));
      // in the beginning
      const closeMap = Key('closeMap');
      const leftMenu = Key('leftMenu');
      const weatherPanelCirc1 = Key('weatherPanelCirc1');
      const weatherPanelCirc2 = Key('weatherPanelCirc2');
      const weatherPanelCirc3 = Key('weatherPanelCirc3');
      const map = Key('map');

      expect(find.byKey(closeMap), findsOneWidget);
      expect(find.byKey(leftMenu), findsOneWidget);

      expect(find.byKey(weatherPanelCirc1), findsOneWidget);
      expect(find.byKey(weatherPanelCirc2), findsOneWidget);
      expect(find.byKey(weatherPanelCirc3), findsOneWidget);
      expect(find.byKey(map), findsOneWidget);
    });

    testWidgets(
        'widgets are being displayed on map screen usual size divided by 3',
        (tester) async {
      tester.view.physicalSize = const Size(500, 200);
      // Load app widget.
      await tester.pumpWidget(const MyApp(initRoute: '/map_screen'));
      // in the beginning
      const closeMap = Key('closeMap');
      const leftMenu = Key('leftMenu');
      const weatherPanelCirc1 = Key('weatherPanelCirc1');
      const weatherPanelCirc2 = Key('weatherPanelCirc2');
      const weatherPanelCirc3 = Key('weatherPanelCirc3');
      const map = Key('map');

      expect(find.byKey(closeMap), findsOneWidget);
      expect(find.byKey(leftMenu), findsOneWidget);

      expect(find.byKey(weatherPanelCirc1), findsOneWidget);
      expect(find.byKey(weatherPanelCirc2), findsOneWidget);
      expect(find.byKey(weatherPanelCirc3), findsOneWidget);
      expect(find.byKey(map), findsOneWidget);
    });
    testWidgets('verify changing of widgets when on map tapped',
        (tester) async {
      // Load app widget.
      await tester.pumpWidget(
        const MyApp(initRoute: '/map_screen'),
      );
      const testKey = Key('map');
      await tester.tap(find.byKey(testKey));
      // Rebuild the widget after the state has changed.
    });
  });
}
