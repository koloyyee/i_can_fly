
import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/flight.dart';

@dao
abstract class FlightDao {
  @Query("select * from flights")
  Future<List<Flight>> findAllFlights();
  
  @Query("select  * where f.id = :id")
  Future<Flight?> findFlightById(int id);

  @Query("select type as airplaneType from airplanes")
  Future<List<String>> findAllAirplaneTypes();

  @Query("""
  select
  f.id as flight_id,
  f.departure_city,
  f.arrival_city,
  f.departure_datetime,
  f.arrival_datetime,
  f.airline_id,
  f.airplane_id,
  al.code as airline_code,
  ap.manufacturer || ' ' || ap.type) as airplane_type
  from flights f
  join airplanes ap on f.airplane_id = ap.id
  join airlines al on f.airline_id = al.id
  where f.id = :id
  """)
  Future<Flight?> findFlightDetails(int id);
  
  @insert
  Future<void> createFlight(Flight newFlight);
  
  @update
  Future<int> updateFlight(Flight newFlight);

  @delete
  Future<int> deleteFlight(Flight newFlight);
}