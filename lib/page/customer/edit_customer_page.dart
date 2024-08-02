import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/main.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import '../../db/database.dart';


/// A StatefulWidget that allows editing a customer's profile.
class EditCustomerPage extends StatefulWidget {
  final Customer customer;

  const EditCustomerPage({super.key, required this.customer});

  @override
  _EditCustomerPageState createState() => _EditCustomerPageState();
}

/// The state for the [EditCustomerPage] widget.
class _EditCustomerPageState extends State<EditCustomerPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController addressController;
  late TextEditingController birthdayController;

  @override
  void initState() {
    super.initState();

    /// Initialize controllers with current customer data
    nameController = TextEditingController(text: widget.customer.name);
    emailController = TextEditingController(text: widget.customer.email);
    passwordController = TextEditingController(text: widget.customer.password);
    firstNameController = TextEditingController(text: widget.customer.firstName);
    lastNameController = TextEditingController(text: widget.customer.lastName);
    addressController = TextEditingController(text: widget.customer.address);
    birthdayController = TextEditingController(text: widget.customer.birthday.toIso8601String());
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  void _updateCustomer() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        birthdayController.text.isNotEmpty) {
      final birthday = DateTime.tryParse(birthdayController.text) ?? widget.customer.birthday;
      final updatedCustomer = Customer(
        id: widget.customer.id,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        birthday: birthday,
        address: addressController.text,
        createdAt: widget.customer.createdAt,
      );

      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final customerDao = database.customerDao;
      await customerDao.updateCustomer(updatedCustomer);

      Navigator.pop(context, true);

      /// Close the page and indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer updated successfully.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields.')),
      );
    }
  }

  void _deleteCustomer() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final customerDao = database.customerDao;
    await customerDao.deleteCustomer(widget.customer);

    Navigator.pop(context, true);

    /// Close the page and indicate success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Customer deleted successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.translate('edit_profile')),
        backgroundColor: Colors.teal,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
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
              title: Text(appLocalizations.translate('english')),
              onTap: () {
                MyApp.setLocale(context, const Locale('en', ''));
                Navigator.pop(context); // Close the drawer after changing locale
              },
            ),
            ListTile(
              title: Text(appLocalizations.translate('spanish')),
              onTap: () {
                MyApp.setLocale(context, const Locale('es', ''));
                Navigator.pop(context); // Close the drawer after changing locale
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: appLocalizations.translate('name')),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: appLocalizations.translate('email')),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: appLocalizations.translate('password')),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: appLocalizations.translate('first_name')),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: appLocalizations.translate('last_name')),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: appLocalizations.translate('address')),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: birthdayController,
                decoration: InputDecoration(labelText: appLocalizations.translate('birthday') + ' (yyyy-MM-dd)'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _updateCustomer,
                    child: Text(appLocalizations.translate('update')),
                  ),
                  ElevatedButton(
                    onPressed: _deleteCustomer,
                    child: Text(appLocalizations.translate('delete')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}