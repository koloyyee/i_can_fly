import 'package:floor/floor.dart';

@DatabaseView("""
      select 
      r.reservationId, 
      c.name AS customerName,
      f.departureCity, 
      f.arrivalCity, 
      f.departureDateTime, 
      f.arrivalDateTime
      from reservations r
      join flights f on r.flightId  = f.id 
      join customers c on r.customerId = c.id 
  """,
  viewName: "reservationDetail"
  )
class ReservationDTO {
  @PrimaryKey(autoGenerate: true)
  int id;
  String customerName;
  String departureCity;
  String arrivalCity;
  DateTime departureDateTime;
  DateTime arrivalDateTime;

  ReservationDTO({
    required this.id,
    required this.customerName,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDateTime,
    required this.arrivalDateTime,
  });
}