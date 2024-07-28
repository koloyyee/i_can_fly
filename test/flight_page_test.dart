// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:i_can_fly/main.dart';
import 'package:i_can_fly/page/flight/flight_page.dart';

void main() {
  testWidgets('Should see See All Your Flights Here!',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlightsPage(),
        ),
      ),
    );

    expect(find.text('See All Your Flights Here!'), findsOneWidget);
  });


}
