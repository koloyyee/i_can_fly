import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/airplane.dart';

/// Data Access Object (DAO) for performing CRUD operations on `Airplane`.
///
/// This DAO provides methods for querying, inserting, updating, and deleting
/// airplane records in the `airplanes` table of the Floor database.
///
/// Methods:
/// - `findAllAirplanes`: Retrieves all airplane records from the database.
/// - `findAirplaneById`: Retrieves a specific airplane record based on the provided `id`.
/// - `createAirplane`: Inserts a new airplane record into the database.
/// - `updateAirplane`: Updates an existing airplane record in the database.
/// - `deleteAirplane`: Deletes an airplane record from the database based on the provided `Airplane` object.
///
@dao
abstract class AirplaneDao {
  @Query('SELECT * FROM airplanes')
  Future<List<Airplane>> findAllAirplanes();

  @Query('SELECT * FROM airplanes WHERE id = :id')
  Future<Airplane?> findAirplaneById(int id);

  @insert
  Future<void> createAirplane(Airplane airplane);

  @update
  Future<void> updateAirplane(Airplane airplane);

  @delete
  Future<void> deleteAirplane(Airplane airplane);
}
