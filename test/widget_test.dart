// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:collaction_app/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// class MockHiveInterface extends Mock implements HiveInterface {}
// class MockHiveBox extends Mock implements Box {}
import 'package:hive/hive.dart';

// void initHive() {
//   var path = Directory.current.path;
//   Hive.init(path + '/test/hive_testing_path');
//   Hive.openBox();
// }

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  testWidgets('Example widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    MyApp app = MyApp();
    await tester.pumpWidget(app);


    // Verify that welcome text is shown
    expect(find.text('Hello user!'), findsOneWidget);

    // Tap the 'Browse actions' button and trigger a page transition (multiple frame).
    await tester.tap(find.text('Browse actions'));
    await tester.pumpAndSettle();

    // Verify that the page has changed.
    expect(find.text('Hello user!'), findsNothing);
  });
}
