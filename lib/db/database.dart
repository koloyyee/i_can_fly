  import 'package:floor/floor.dart';
  import 'package:i_can_fly/dao/airline-dao.dart';
  import 'package:i_can_fly/dao/airplane-dao.dart';
  import 'package:i_can_fly/dao/customer-dao.dart';
  import 'package:i_can_fly/dao/flight-dao.dart';
  import 'package:i_can_fly/dao/staff-dao.dart';




  import 'package:i_can_fly/db/datetime-converter.dart';
  import 'package:i_can_fly/entity/airline.dart';
  import 'package:i_can_fly/entity/airplane.dart';
  import 'package:i_can_fly/entity/customer.dart';
  import 'package:i_can_fly/entity/flight.dart';
  import 'package:i_can_fly/entity/staff.dart';

  part 'database.g.dart';

  @TypeConverters([DateTimeConverter])
  @Database(version: 1, entities: [Airline, Airplane, Flight, Customer, Staff])
  abstract class AppDatabase extends FloorDatabase {
    FlightDao get flightDao;
    AirlineDao get airlineDao;
    AirplaneDao get airplaneDao;
    CustomerDao get customerDao;
    StaffDao get staffDao;
    //AdminDao get adminDao;


  }

