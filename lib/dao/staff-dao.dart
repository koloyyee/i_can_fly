
import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/staff.dart';

@dao
abstract class StaffDao {
  @Query("select * from staffs")
  Future<List<Staff>> findAllStaffs();

  @Query('select * from staffs where id = :id')
  Future<Staff?> findStaffById(int id);

  @Query("select * from staffs where email = :email")
  Future<Staff?>findStaffByEmail(String email);
  
 @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createStaff(Staff newStaff);
  
  @update
  Future<int> updateStaff(Staff newStaff);

  @delete
  Future<int> deleteStaff(Staff newStaff);
}