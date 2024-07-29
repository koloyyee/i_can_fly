import 'package:floor/floor.dart';

@Entity(tableName: 'airplanes')
class Airplane {
  @primaryKey
  final int? id; // Nullable for auto-increment
  final String type;
  final int capacity;
  final int maxSpeed;
  final int maxRange;

  Airplane({
    this.id, // Can be null for new entries
    required this.type,
    required this.capacity,
    required this.maxSpeed,
    required this.maxRange,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'capacity': capacity,
      'maxSpeed': maxSpeed,
      'maxRange': maxRange,
    };
  }
}
