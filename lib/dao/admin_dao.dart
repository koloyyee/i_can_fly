import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/admin.dart';

/// AdminDao is a Data Access Object for Admin
/// It contains all the queries for Admin
/// It is used by the database to perform CRUD operations on Admin
/// 
/// [findAllAdmins]: Retrieves all Admin records from the database.
/// [findAdminById]: Retrieves a specific Admin record based on the provided `id`.
/// [findAdminByEmail]: Retrieves a specific Admin record based on the provided `email`.
/// [createAdmin]: Inserts a new Admin record into the database.
/// [updateAdmin]: Updates an existing Admin record in the database.
/// [deleteAdmin]: Deletes an Admin record from the database based on the provided `Admin` object.
/// 
@dao
abstract class AdminDao {
  @Query("select * from admins ")
  Future<List<Admin>> findAllAdmins();

  @Query("select  * from admins where id = :id")
  Future<Admin?> findAdminById(int id);

  @Query("select * from admins where email = :email")
  Future<Admin?> findAdminByEmail(String email);

  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createAdmin(Admin newAdmin);

  @update
  Future<int> updateAdmin(Admin newAdmin);

  @delete
  Future<int> deleteAdmin(Admin newAdmin);
}
