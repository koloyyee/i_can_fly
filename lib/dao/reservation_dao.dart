import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/reservation.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/entity/customer.dart';

@dao
abstract class ReservationDao {
  @Query("SELECT * FROM reservations")
  Future<List<Reservation>> findAllReservations();

  @Query("SELECT * FROM reservations WHERE id = :id")
  Future<Reservation?> findReservationById(int id);

  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createReservation(Reservation newReservation);

  @update
  Future<int> updateReservation(Reservation newReservation);

  @delete
  Future<void> deleteReservation(Reservation newReservation);

  @Query("""
    SELECT 
      r.id, 
      c.name AS customerName,
      f.departure_city, 
      f.arrival_city, 
      f.departure_datetime, 
      f.arrival_datetime
    FROM reservations r
    JOIN flights f ON r.flight_id = f.id
    JOIN customers c ON r.customer_id = c.id
    WHERE r.id = :id
  """)
  Future<void> findDetailedReservationById(int id);
}
