
import 'package:floor/floor.dart';
import 'package:i_can_fly/model/flight.dart';

@dao
abstract class FlightDao {
  @Query("select * from flights")
  Future<List<Flight>> findAll();
  
  @Query("select * from flights where id = :id")
  Future<List<Flight>> findById(int id);
  
  @insert
  Future<void> createFlight(Flight newFlight);
  
  @update
  Future<int> updateFlight(Flight newFlight);

  @delete
  Future<int> deleteFlight(Flight newFlight);
}