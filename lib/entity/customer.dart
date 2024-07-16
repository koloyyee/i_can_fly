
import 'package:floor/floor.dart';

@Entity(tableName: "customers")
class Customer{

  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthday;
  final String address;
  final DateTime createdAt;

 Customer({required this.id, required this.name, required this.email, required this.password, required this.firstName, required this.lastName, required this.birthday, required this.address, required this.createdAt});
}