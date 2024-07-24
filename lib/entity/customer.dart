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
  final int birthday;
  final String address;
  final int createdAt;

  Customer({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.address,
    required this.createdAt,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    int? birthday,
    String? address,
    int? createdAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

}

