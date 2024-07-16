
import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/airline.dart';
import 'package:i_can_fly/entity/flight.dart';

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
  Stream<                     Airline?                 > findAirlineById(int id);
  
 @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createAirline(Flight newFlight);
  
  @update
  Future<int> updateAirline(Flight newFlight);

  @delete
  Future<int> deleteAirline(Flight newFlight);
}