import 'package:floor/floor.dart';

@Entity(tableName: 'airplanes')
class Airplane {
  @primaryKey
  final int id;
  final String type;
  final int capacity;
  final int maxSpeed;
  final int maxRange;

  Airplane({
    required this.id,
    required this.type,
    required this.capacity,
    required this.maxSpeed,
    required this.maxRange,
  });

  Airplane copyWith({
    int? id,
    String? type,
    int? capacity,
    int? maxSpeed,
    int? maxRange,
  }) {
    return Airplane(
      id: id ?? this.id,
      type: type ?? this.type,
      capacity: capacity ?? this.capacity,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      maxRange: maxRange ?? this.maxRange,
    );
  }
}
