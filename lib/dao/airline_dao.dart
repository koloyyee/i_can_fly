import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/airline.dart';

/// Airline Data Access Object
/// This class is used to interact with the database
/// and perform CRUD operations on the airlines table.
/// The @dao annotation is used to indicate that this class
/// is a Data Access Object.
/// 
/// [findAllAirlines]: Retrieves all airline records from the database.
/// [findAirlineById]: Retrieves a specific airline record based on the provided `id`.
/// [createAirline]: Inserts a new airline record into the database.
/// [updateAirline]: Updates an existing airline record in the database.
/// [deleteAirline]: Deletes an airline record from the database based on the provided `Airline` object.
/// 
@dao
abstract class AirlineDao {

  /// Select all airlines from the database
  @Query("select * from airlines ")
  Future<List<Airline>> findAllAirlines();

  /// Select an airline by its id
  @Query("""
select  
*
from airlines   
where id = :id
""")
  Stream<Airline?> findAirlineById(int id);

  /// Insert a new airline into the database
  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createAirline(Airline newAirline);

  /// Update an airline in the database
  @update
  Future<int> updateAirline(Airline newAirline);

  /// Delete an airline from the database
  @delete
  Future<int> deleteAirline(Airline newAirline);
}
