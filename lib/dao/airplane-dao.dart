import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/airplane.dart';

@dao
abstract class AirplaneDao {
  @Query("select * from airplanes")
  Future<List<Airplane>> findAllAirplanes();
  
  @Query("select * from airplanes where id = :id")
  Future<Airplane?> findAirplaneById(int id);
  
 @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createAirplane(Airplane newAirplane);
  
  @update
  Future<int> updateAirplane(Airplane newAirplane);

  @delete
  Future<int> deleteAirplane(Airplane newAirplane);
}