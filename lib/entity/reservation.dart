import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/entity/flight.dart';





@Entity(tableName: "reservations")
class Reservation {
  @PrimaryKey(autoGenerate: true)
  final int? reservationId;
  final int? customerId;
  final int? flightId;

  String? departureCity;
  String? arrivalCity;
  DateTime departureDateTime;
  DateTime arrivalDateTime;
  String? customerName; // Optionally store the customer's name directly if frequently accessed

  final String reservationName;

  Reservation({
    this.reservationId,
    required this.customerId,
    required this.flightId,
    this.departureCity,
    this.arrivalCity,
    required this.departureDateTime,
    required this.arrivalDateTime,
    this.customerName,
    required this.reservationName,
  });
}


