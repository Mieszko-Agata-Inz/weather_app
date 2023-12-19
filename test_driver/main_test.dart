import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('ensure all widgets are being displayed on main screen',
        (tester) async {
      // Load app widget.
      await tester.pumpWidget(app.MyApp());
      // await tester.pumpWidget(MyApp());
      // await tester.pump();
      // const testKey_circ = Key('circ');
      const testKey_search_bar = Key('searchArea');
      // const testKey_map = Key('mapButton');

      // expect(find.byKey(testKey_circ), findsOneWidget);
      expect(find.byKey(testKey_search_bar), findsOneWidget);
      // expect(find.byKey(testKey_map), findsOneWidget);
    });

    //   testWidgets('enter text in searchArea', (tester) async {
    //     // Load app widget.
    //     await tester.pumpWidget(ChangeNotifierProvider(
    //       create: (context) => APIProvider(),
    //       child: MyApp(),
    //     ));
    //     const testKey = Key('searchArea');
    //     await tester.enterText(find.byKey(testKey), 'Iława');
    //     expect(find.text("Iława"), findsOne);
    //     await tester.testTextInput.receiveAction(TextInputAction.done);
    //     await tester.pump();
    //     expect(find.text("Iława"), findsNothing);
    //   });
  });
}
