import 'package:flutter_test/flutter_test.dart';

import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = await $FloorAppDatabase.databaseBuilder('test_database.db').build();
  });

  test('Insert and retrieve customer', () async {
    final DateTime now = DateTime.now();
    final customer = Customer(
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password',
      firstName: 'John',
      lastName: 'Doe',
      birthday: now,
      createdAt: now,
    );

    await database.customerDao.createCustomer(customer);

    final retrievedCustomer = await database.customerDao.findCustomerByEmailAndPassword(
      'john.doe@example.com',
      'password',
    );

    expect(retrievedCustomer, isNotNull);
    expect(retrievedCustomer!.name, 'John Doe');
    expect(retrievedCustomer.email, 'john.doe@example.com');

    // Allow a tolerance for datetime comparison
    const tolerance = Duration(seconds: 10); // Adjust tolerance as needed

    // Print values for debugging
    print('Original birthday: ${customer.birthday}');
    print('Retrieved birthday: ${retrievedCustomer.birthday}');
    print('Original createdAt: ${customer.createdAt}');
    print('Retrieved createdAt: ${retrievedCustomer.createdAt}');

    // Check that datetime values are within tolerance
    expect(
      retrievedCustomer.birthday.difference(customer.birthday).abs(),
      lessThan(tolerance),
    );
    expect(
      retrievedCustomer.createdAt.difference(customer.createdAt).abs(),
      lessThan(tolerance),
    );
  });
}

