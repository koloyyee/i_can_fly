import 'package:floor/floor.dart';

@Entity(tableName: "reservation")
class Reservation {
  @PrimaryKey(autoGenerate: true)
  final int? reservationId;
  final String customerName;
  final String departureCity;
  final String destinationCity;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String reservationName;



  Reservation({
    this.reservationId,
    required this.customerName,
    required this.departureCity,
    required this.destinationCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.reservationName,
  });


}

