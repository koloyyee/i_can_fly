import 'package:floor/floor.dart';





@Entity(tableName: "reservation")
class Reservation {
  @PrimaryKey(autoGenerate: true)
  final int? reservationId;

  final int customerId;
  final int flightId;

  // Optional: If you want to store these directly in the reservation for quicker access
  // Not necessary if you only access them through joined queries
  String? departureCity;
  String? arrivalCity;
  DateTime departureDateTime;
  DateTime arrivalDateTime;
  String? customerName; // Optionally store the customer's name directly if frequently accessed


  final String reservationName;



  Reservation( {

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

