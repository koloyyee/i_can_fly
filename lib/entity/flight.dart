
import 'package:floor/floor.dart';

/// Flight: id, arrival_city, departure_city, airplane_id, departure_time, arrival_time,
/// enter the departure and destination cities, as well as the departure and arrival times. You should check that all fields have a value before letting the user submit the new airplane type.
@Entity(tableName: "flights",)
class Flight {

  //static int ID = 1;

  @primaryKey
  final int? id;
  final String? airplaneType;
  final String arrivalCity;
  final String departureCity;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;

  Flight({required this.id,
    required this.airplaneType,
    required this.arrivalCity,
    required this.departureCity,
    required this.departureDateTime,
    required this.arrivalDateTime,
  });
}
