import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/airline.dart';

@dao
abstract class AirlineDao {
  @Query("select * from airlines ")
  Future<List<Airline>> findAllAirlines();

  @Query("""
select  
*
from airlines   
where id = :id
""")
  Stream<Airline?> findAirlineById(int id);

  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createAirline(Airline newAirline);

  @update
  Future<int> updateAirline(Airline newAirline);

  @delete
  Future<int> deleteAirline(Airline newAirline);
}
