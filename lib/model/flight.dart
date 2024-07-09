

import 'dart:ffi';

/// Flight: id, arrival_city, departure_city, airplane_id, departure_time, arrival_time, 
class Flight {
  final Long id;
  final String arrivalCity;
  final String departureCity;
  final DateTime departureTime;
  final DateTime arrivalTime;

  Flight({
     required this.id, 
     required this.arrivalCity, 
     required this.departureCity, 
     required this.departureTime, 
     required this.arrivalTime});

}