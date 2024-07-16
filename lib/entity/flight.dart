import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/airline.dart';
import 'package:i_can_fly/entity/airplane.dart';

/// Flight: id, arrival_city, departure_city, airplane_id, departure_time, arrival_time,
/// enter the departure and destination cities, as well as the departure and arrival times. You should check that all fields have a value before letting the user submit the new airplane type.
@Entity(tableName: "flights", foreignKeys: [
  ForeignKey(
      childColumns: ['airplane_id'], parentColumns: ['id'], entity: Airplane),
  ForeignKey(
      childColumns: ['airline_id'], parentColumns: ['id'], entity: Airline)
],

)
class Flight {

  static int ID = 1;

  @primaryKey
  final int id;
  @ColumnInfo(name: 'airplane_id')
  final int airplaneId;
  @ColumnInfo(name: 'airline_id')
  final int airlineId;
  final String? airlineCode;
  final String? airplaneType; 
  final String arrivalCity;
  final String departureCity;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;

  Flight(
      {required this.id,
      required this.airplaneId,
      required this.airlineId,
      required this.arrivalCity,
      required this.departureCity,
      required this.departureDateTime,
      required this.arrivalDateTime,
      this.airlineCode,
      this.airplaneType,
      }) {
    if (id > ID) {
      ID = id;
    }
  }
  
}
