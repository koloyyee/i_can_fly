import 'package:floor/floor.dart';

/// Represents an airplane entity for use with the Floor database.
///
/// This class defines the structure of the `airplanes` table in the database,
/// including fields for the airplane's type, capacity, maximum speed, and range.
/// The `id` field is optional and is used for auto-incremented primary keys.
///
/// Example usage:
/// ```dart
/// final airplane = Airplane(
///   type: 'Boeing 747',
///   capacity: 400,
///   maxSpeed: 900,
///   maxRange: 13000,
/// );
/// ```

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
