import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/airplane.dart';

@dao
abstract class AirplaneDao {
  @Query('SELECT * FROM airplanes')
  Future<List<Airplane>> findAllAirplanes();

  @Query('SELECT * FROM airplanes WHERE id = :id')
  Future<Airplane?> findAirplaneById(int id);

  @insert
  Future<void> createAirplane(Airplane airplane);

  @update
  Future<int> updateAirplane(Airplane airplane);

  @delete
  Future<int> deleteAirplane(Airplane airplane);
}
