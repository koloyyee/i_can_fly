import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/reservation.dart';

@dao
abstract class ReservationDao {
  @Query("SELECT * FROM reservation")
  Future<List<Reservation>> findAllReservation();

  @Query("SELECT * FROM reservations WHERE id = :id")
  Future<Reservation?> findReservationById(int id);

  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createReservation(Reservation newReservation);

  @update
  Future<int> updateReservation(Reservation newReservation);

  @delete
  Future<void> deleteReservation(Reservation newReservation);
}

