import 'package:floor/floor.dart';

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
