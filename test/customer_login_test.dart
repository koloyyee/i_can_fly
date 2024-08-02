import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i_can_fly/dao/customer_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/page/customer/customer_home.dart';
import 'package:i_can_fly/page/customer/customer_login_page.dart';
import 'package:mockito/mockito.dart';

// Mock implementation
class MockCustomerDao extends Mock implements CustomerDao {}

class MockAppDatabase extends Mock implements AppDatabase {}

void main() {
  Widget createTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('CustomerLoginPage has email and password fields', (WidgetTester tester) async {
    final mockDatabase = MockAppDatabase();
    final mockDao = MockCustomerDao();
    when(mockDatabase.customerDao).thenReturn(mockDao);

    await tester.pumpWidget(createTestableWidget(CustomerLoginPage(database: mockDatabase)));
    await tester.pumpAndSettle();

    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byKey(const Key('emailField')), findsOneWidget);
    expect(find.byKey(const Key('passwordField')), findsOneWidget);
  });

  testWidgets('CustomerLoginPage shows error for invalid email', (WidgetTester tester) async {
    final mockDatabase = MockAppDatabase();
    final mockDao = MockCustomerDao();
    when(mockDatabase.customerDao).thenReturn(mockDao);

    await tester.pumpWidget(createTestableWidget(CustomerLoginPage(database: mockDatabase)));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('emailField')), 'invalidEmail');
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Please enter a valid email address'), findsOneWidget);
  });

  testWidgets('CustomerLoginPage shows error for invalid password', (WidgetTester tester) async {
    final mockDatabase = MockAppDatabase();
    final mockDao = MockCustomerDao();
    when(mockDatabase.customerDao).thenReturn(mockDao);

    await tester.pumpWidget(createTestableWidget(CustomerLoginPage(database: mockDatabase)));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('passwordField')), '123');
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
  });

  testWidgets('CustomerLoginPage allows login with valid credentials', (WidgetTester tester) async {
    final mockDatabase = MockAppDatabase();
    final mockDao = MockCustomerDao();
    when(mockDatabase.customerDao).thenReturn(mockDao);

    // Mock the findCustomerByEmailAndPassword method to return a Future<Customer?> instance
    when(mockDao.findCustomerByEmailAndPassword('valid@example.com', 'password123'))
        .thenAnswer((_) async => Customer(
        email: 'paulo@123.com',
        password: '12345678',
        name: 'paulo',
        birthday: DateTime(2000, 01, 01),
        createdAt: DateTime(2000, 01, 01)
    ));

    await tester.pumpWidget(createTestableWidget(CustomerLoginPage(database: mockDatabase)));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('emailField')), 'valid@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password123');
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Assuming CustomerHomePage is the correct page to expect after successful login
    expect(find.byType(CustomerHomePage), findsOneWidget);
  });
}

