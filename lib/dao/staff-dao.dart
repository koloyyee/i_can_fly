
import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/Staff.dart';

@dao
abstract class StaffDao {
  @Query("select * from Staffs ")
  Future<List<Staff>> findAllStaffs();
  
  @Query("select  * from Staffs  where id = :id")
  Future<Staff?>findStaffById(int id);

  @Query("select * from Staffs where email = :email")
  Future<Staff?>findStaffByEmail(String email);
  
 @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createStaff(Staff newStaff);
  
  @update
  Future<int> updateStaff(Staff newStaff);

  @delete
  Future<int> deleteStaff(Staff newStaff);
}