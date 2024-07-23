import 'package:floor/floor.dart';

@entity
class Airplane {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String type;
  final int capacity;
  final int maxSpeed;
  final int maxRange;
  final String manufacturer;

  Airplane({
    this.id,
    required this.type,
    required this.capacity,
    required this.maxSpeed,
    required this.maxRange,
    required this.manufacturer,
  });
}
