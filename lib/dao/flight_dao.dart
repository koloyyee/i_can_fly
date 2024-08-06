import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/flight.dart';

/// Flight Data Access Object
/// This class is used to interact with the database
/// and perform CRUD operations on the flights table.
/// The @dao annotation is used to indicate that this class
/// is a Data Access Object.
/// 
/// [findAllFlights]: Retrieves all flight records from the database.
/// [findFlightById]: Retrieves a specific flight record based on the provided `id`.
/// [findAllAirplaneTypes]: Retrieves all airplane types from the database.
/// [findFlightDetails]: Retrieves a specific flight record with details based on the provided `id`.
/// [createFlight]: Inserts a new flight record into the database.
/// [updateFlight]: Updates an existing flight record in the database.
/// [deleteFlight]: Deletes a flight record from the database based on the provided `Flight` object.
/// 
/// 3. You must use a database to store items that were inserted into the ListView to repopulate the list when the application is restarted.
@dao
abstract class FlightDao {
  /// Select all flights from the database
  @Query("select * from flights")
  Future<List<Flight>> findAllFlights();

  /// Select a flight by its id
  @Query("select  * where f.id = :id")
  Future<Flight?> findFlightById(int id);

  /// Select all flight ids from the database
  @Query("select type as airplaneType from airplanes")
  Future<List<String>> findAllAirplaneTypes();

  /// Select flight and perform a join with the airlines and airplanes tables
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
   ap.type as airplane_type
  from flights f
  join airplanes ap on f.airplane_id = ap.id
  join airlines al on f.airline_id = al.id
  where f.id = :id
  """)
  Future<Flight?> findFlightDetails(int id);

  /// Insert a new flight into the database
  @insert
  Future<void> createFlight(Flight newFlight);
  
  /// Update a flight in the database
  @update
  Future<int> updateFlight(Flight newFlight);

  /// Delete a flight from the database
  @delete
  Future<int> deleteFlight(Flight newFlight);
}
