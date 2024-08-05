import 'package:floor/floor.dart';

/// Flight entity class that represents the flight table in the database
/// 
/// - id as primary key
/// - airplaneType as the type of airplane
/// - arrivalCity as the city of arrival
/// - departureCity as the city of departure
/// - departureDateTime as the date and time of departure
/// - arrivalDateTime as the date and time of arrival
/// 
/// usage:
/// 
/// ```dart
/// var newFlight = Flight(
///  airplaneType: 'Boeing 737',
/// arrivalCity: 'Lagos',
/// departureCity: 'Abuja',
/// departureDateTime: DateTime.now(),
/// arrivalDateTime: DateTime.now().add(Duration(hours: 1))
/// );
/// ```
@Entity(tableName: "flights")
class Flight {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? airplaneType;
  final String arrivalCity;
  final String departureCity;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;

  Flight({
    this.id,
    this.airplaneType,
    required this.arrivalCity,
    required this.departureCity,
    required this.departureDateTime,
    required this.arrivalDateTime,
  });
}
