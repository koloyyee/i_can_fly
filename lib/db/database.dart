import 'dart:async';
import 'package:floor/floor.dart';
import 'package:i_can_fly/dao/airline_dao.dart';
import 'package:i_can_fly/dao/airplane_dao.dart';
import 'package:i_can_fly/dao/customer_dao.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/dao/admin_dao.dart';
import 'package:i_can_fly/dao/reservation-dao.dart';
import 'package:i_can_fly/db/datetime-converter.dart';
import 'package:i_can_fly/entity/airline.dart';
import 'package:i_can_fly/entity/airplane.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/entity/admin.dart';
import 'package:i_can_fly/entity/reservation.dart';
import 'package:sqflite/sqflite.dart' as sqflite;



part 'database.g.dart'; // Make sure this matches the generated file name

// dart run build_runner build
// dart run build_runner watch  

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Admin, Airline, Airplane, Flight, Customer, Reservation])
abstract class AppDatabase extends FloorDatabase {
  FlightDao get flightDao;
  AirlineDao get airlineDao;
  AirplaneDao get airplaneDao;
  AdminDao get adminDao;
  CustomerDao get customerDao;
  ReservationDao get reservationDao;

  static AppDatabase? _instance;

  static Future<AppDatabase> getInstance() async {
    _instance ??= await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return _instance!;
  }
}
