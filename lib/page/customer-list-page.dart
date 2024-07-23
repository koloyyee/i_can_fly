import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/customer-dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/page/customer/edit-customer-page.dart';
import 'package:i_can_fly/page/customer/add-customer-page.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  List<Customer> customers = [];
  late CustomerDao customerDao;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  fetchCustomers() async {
    final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    customerDao = db.customerDao;
    final fetchedCustomers = await customerDao.findAllCustomers();
    setState(() {
      customers = fetchedCustomers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer List"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCustomerPage()))
                  .then((_) => fetchCustomers());
            },
          ),
        ],
      ),
      body: customers.isEmpty
          ? Center(child: const Text("No customers found :(", style: TextStyle(fontSize: 36)))
          : ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return ListTile(
            title: Text(customer.name),
            subtitle: Text(customer.email),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => EditCustomerPage(customer: customer),
              )).then((_) => fetchCustomers());
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete Customer"),
                    content: Text("Are you sure you want to delete ${customer.name}?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          customerDao.deleteCustomer(customer);
                          fetchCustomers();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Delete"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


