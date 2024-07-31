import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i_can_fly/page/flight/add_flight.dart';
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

  /// create flight
  testWidgets("Create Flight with invalids", (WidgetTester tester) {
    // Build our app and trigger a frame.
    return tester
        .pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AddFlightPage(),
        ),
      ),
    )
        .then((value) async {
      // expect to failed
      expect(find.text('Please enter a valid city'), findsNothing);
      expect(find.text('Please select a valid airplane type'), findsNothing);

      // testing departure city
      await tester.enterText(find.byKey(const Key("departureCityField")), "");
      await tester.pump();

      // testing destination city
      await tester.enterText(find.byKey(const Key("arrivalCityField")), "");
      await tester.pump();


      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Please enter a valid city'), findsNWidgets(2));
      expect(find.text('Please select a valid airplane type'), findsOneWidget);
    });
  });
  testWidgets("Create Flight valid", (WidgetTester tester) {
    // Build our app and trigger a frame.
    return tester
        .pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AddFlightPage(),
        ),
      ),
    )
        .then((value) async {
      // expect to failed
      expect(find.text('Please enter a valid city'), findsNothing);
      expect(find.text('Please select a valid airplane type'), findsNothing);

      // testing departure city
      await tester.enterText(find.byKey(const Key("departureCityField")), "Toronto");
      await tester.pump();

      // testing destination city
      await tester.enterText(find.byKey(const Key("arrivalCityField")), "New York");
      await tester.pump();

      await tester.tap(find.byType(DropdownButtonFormField));
      await tester.pump();
      await tester.tap(find.text('Boeing 737').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Please enter a valid city'), findsNothing);
      expect(find.text('Please select a valid airplane type'), findsNothing);
    });
  });
}
