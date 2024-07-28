import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/admin.dart';

@dao
abstract class AdminDao {
  @Query("select * from Admins ")
  Future<List<Admin>> findAllAdmins();

  @Query("select  * from Admins where id = :id")
  Future<Admin?> findAdminById(int id);

  @Query("select * from Admins where email = :email")
  Future<Admin?> findAdminByEmail(String email);

  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createAdmin(Admin newAdmin);

  @update
  Future<int> updateAdmin(Admin newAdmin);

  @delete
  Future<int> deleteAdmin(Admin newAdmin);
}
