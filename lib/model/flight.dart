import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:i_can_fly/model/airplane.dart';

/// Flight: id, arrival_city, departure_city, airplane_id, departure_time, arrival_time,
/// enter the departure and destination cities, as well as the departure and arrival times. You should check that all fields have a value before letting the user submit the new airplane type.
@Entity(tableName: "flights")
class Flight {
  static int ID = 1;

  @primaryKey
  final int id;
  final int airplaneId;
  final String arrivalCity;
  final String departureCity;
  final DateTime departureTime;
  final DateTime arrivalTime;

  Flight(
      {required this.id,
      required this.airplaneId,
      required this.arrivalCity,
      required this.departureCity,
      required this.departureTime,
      required this.arrivalTime}) {
    if (id > ID) {
      ID = id;
    }
  }
}
