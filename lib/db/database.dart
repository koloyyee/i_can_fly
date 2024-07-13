import 'dart:async';
import 'package:floor/floor.dart';
import 'package:i_can_fly/dao/flight-dao.dart';
import 'package:i_can_fly/model/flight.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

/// https://pub.dev/documentation/floor/latest/floor/TypeConverter-class.html
class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}


/// flutter packages pub run build_runner build
/// flutter packages pub run build_runner watch
@TypeConverters([DateTimeConverter])
@Database(version: 1, entities:[Flight])
abstract class AppDatabase extends FloorDatabase {
  FlightDao get flightDao;
}
