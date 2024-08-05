import 'package:floor/floor.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/reservation.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/entity/reservation.dto.dart';
import 'package:sqflite/sqflite.dart';

@dao
abstract class ReservationDao {
  @Query("SELECT * FROM reservations")
  Future<List<Reservation>> findAllReservations();

  @Query("SELECT * FROM reservations WHERE reservationId = :id")
  Future<Reservation?> findReservationById(int id);

  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createReservation(Reservation newReservation);

  @update
  Future<int> updateReservation(Reservation newReservation);

  @delete
  Future<void> deleteReservation(Reservation newReservation);

  @Query("""
      select 
      r.reservationId, 
      c.name AS customerName,
      f.departureCity, 
      f.arrivalCity, 
      f.departureDateTime, 
      f.arrivalDateTime
      from reservations r
      join flights f on r.flightId  = f.id 
      join customers c on r.customerId = c.id 
      where r.reservationId = :id
  """)
  Future<Reservation?> findDetailedReservationById(int id) ;
 
}


