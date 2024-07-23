import 'package:floor/floor.dart';

@Entity(tableName: "airplanes")
class Airplane {
  @PrimaryKey(autoGenerate: true)
  final int? id; // Make id nullable because it's auto-generated
  final String type;
  final int capacity;
  final int maxSpeed;
  final int maxRange;
  final String manufacturer;

  Airplane({
    this.id, // Make id optional
    required this.type,
    required this.capacity,
    required this.maxSpeed,
    required this.maxRange,
    required this.manufacturer,
  });
}
