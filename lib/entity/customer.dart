import 'package:floor/floor.dart';


@Entity(tableName: "customers")
class Customer {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthday;
  final String address;
  final DateTime createdAt;

  Customer({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.firstName = "",
    this.lastName = "",
    required this.birthday,
    this.address = "",
    required this.createdAt,
  });
}