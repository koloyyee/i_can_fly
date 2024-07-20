import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/Customer.dart';

@dao
abstract class CustomerDao {
  @Query("select * from Customers ")
  Future<List<Customer>> findAllCustomers();

  @Query("""
select  
*
from Customers   
where id = :id
""")
  Stream<Customer?> findCustomerById(int id);

  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> createCustomer(Customer newCustomer);

  @update
  Future<int> updateCustomer(Customer newCustomer);

  @delete
  Future<int> deleteCustomer(Customer newCustomer);
}
