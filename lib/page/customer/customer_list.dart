import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/customer_dao.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/page/customer/add_customer_page.dart';
import 'package:i_can_fly/page/customer/edit_customer_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../db/database.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  late CustomerDao customerDao;
  List<Customer> customerList = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    customerDao = database.customerDao;
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    final customers = await customerDao.findAllCustomers();
    setState(() {
      customerList = customers;
    });
  }

  void _navigateToAddCustomerPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCustomerPage()),
    );

    if (result != null && result) {
      // Fetch the updated list
      _fetchCustomers();
      Fluttertoast.showToast(msg: 'New customer added with success');
    }
  }

  void _navigateToEditCustomerPage(Customer customer) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditCustomerPage(customer: customer)),
    );

    if (result != null && result) {
      // Fetch the updated list
      _fetchCustomers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _navigateToAddCustomerPage,
              child: const Text("Add Customer"),
            ),
          ),
          Expanded(
            child: customerList.isEmpty
                ? const Center(child: Text("No customers found."))
                : ListView.builder(
              itemCount: customerList.length,
              itemBuilder: (context, index) {
                final customer = customerList[index];
                return ListTile(
                  title: Text(customer.name),
                  onTap: () => _navigateToEditCustomerPage(customer),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

