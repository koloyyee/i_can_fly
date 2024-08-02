import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/main.dart';
import 'package:i_can_fly/page/customer/add_customer_page.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import 'package:intl/intl.dart';
import '../../db/database.dart';

class CustomerListPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AppDatabase database;

  CustomerListPage({super.key, required this.database});

  Future<List<Customer>> _fetchCustomers() async {
    try {
      final customerDao = database.customerDao;
      final customers = await customerDao.findAllCustomers();
      print("Fetched customers: $customers");
      return customers;
    } catch (e) {
      print("Error fetching customers: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.translate('customer_list') ?? 'Customer List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppLocalizations.of(context)?.translate('english') ?? 'English'),
              onTap: () {
                MyApp.setLocale(context, const Locale('en', ''));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppLocalizations.of(context)?.translate('spanish') ?? 'Spanish'),
              onTap: () {
                MyApp.setLocale(context, const Locale('es', ''));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Customer>>(
        future: _fetchCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No customers found.'));
          } else {
            final customers = snapshot.data!;
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                final birthdayDateTime = customer.birthday;
                final createdAtDateTime = customer.createdAt;
                return ListTile(
                  title: Text(customer.name),
                  subtitle: Text(DateFormat('yyyy-MM-dd').format(birthdayDateTime)),
                  onTap: () {
                    // Handle tap for viewing or editing the customer
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCustomerPage(),
            ),
          );
        },
        tooltip: AppLocalizations.of(context)?.translate('add_customer') ?? 'Add Customer',
        child: const Icon(Icons.add),
      ),
    );
  }
}
