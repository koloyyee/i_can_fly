import 'package:floor/floor.dart';


import 'customer.dart';
import 'flight.dart';



@Entity(tableName: "reservation")
class Reservation {
  @PrimaryKey(autoGenerate: true)

  // final int? id;
  // final String name;
  // final String email;
  // final String password;
  // final String firstName;
  // final String lastName;
  // final int birthday;
  // final String address;
  // final int createdAt;

  final int? reservationId;
  final String customerName;
  final String departureCity;
  final String destinationCity;
  final DateTime departureTime;

  final DateTime arrivalTime;

  final DateTime arivalTime;

  final String reservationName;



  Reservation({

    // this.id,
    // required this.name,
    // required this.email,
    // required this.password,
    // required this.firstName,
    // required this.lastName,
    // required this.birthday,
    // required this.address,
    // required this.createdAt,

    this.reservationId,
    required this.customerName,
    required this.departureCity,
    required this.destinationCity,
    required this.departureTime,

    required this.arrivalTime,

    required this.arivalTime,

    required this.reservationName,
  });


}

