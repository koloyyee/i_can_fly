// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i_can_fly/page/admin/admin_login.dart';

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

  /// Admin login page test
  testWidgets("Admin login page", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AdminLoginPage(),
        ),
      ),
    );
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byKey(const Key('emailField')), findsOneWidget);
    expect(find.byKey(const Key('passwordField')), findsOneWidget);
  });

 testWidgets("Admin login invalid email ", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AdminLoginPage(),
        ),
      ),
    );
    expect(find.text('Please enter email'), findsNothing);

    // expect to failed
    await tester.enterText(find.byKey(const Key("emailField")), "invalidEmail");
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Please enter a valid email address'), findsOneWidget);
 });

 testWidgets("Admin login invalid password", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AdminLoginPage(),
        ),
      ),
    );
    expect(find.text('Please enter password'), findsNothing);

    // testing password
    await tester.enterText(find.byKey(const Key("passwordField")), "123");
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text("Password must be at least 8 characters"), findsOneWidget);
 });
 testWidgets("Admin login valid email ", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AdminLoginPage(),
        ),
      ),
    );
    expect(find.text('Please enter email'), findsNothing);

    // expect to failed
    await tester.enterText(find.byKey(const Key("emailField")), "valid@email.com");
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Please enter a valid email address'), findsNothing);
 });

 testWidgets("Admin login password", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AdminLoginPage(),
        ),
      ),
    );
    expect(find.text('Please enter password'), findsNothing);

    // testing password
    await tester.enterText(find.byKey(const Key("passwordField")), "password123");
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text("Password must be at least 8 characters"), findsNothing);
 });

 testWidgets("Admin login password", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AdminLoginPage(),
        ),
      ),
    );
    expect(find.text('Please enter password'), findsNothing);

    // testing password
    await tester.enterText(find.byKey(const Key("passwordField")), "password123");
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text("Password must be at least 8 characters"), findsNothing);
 });
}
