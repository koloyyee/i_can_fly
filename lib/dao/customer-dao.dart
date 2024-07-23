import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/customer.dart';

@dao
abstract class CustomerDao {

  @Query("SELECT * FROM customers")
  Future<List<Customer>> findAllCustomers();

  @Query("SELECT * FROM customers WHERE id = :id")
  Future<Customer?> findCustomerById(int id);


  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createCustomer(Customer newCustomer);

  @update
  Future<int> updateCustomer(Customer newCustomer);

  @delete
  Future<int> deleteCustomer(Customer newCustomer);
}

