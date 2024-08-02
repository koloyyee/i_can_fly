import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/main.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/database.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController birthdayController;
  bool useLastCustomerInfo = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();
    birthdayController = TextEditingController();
    _showOptionsDialog();
  }

  Future<void> _showOptionsDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCustomerName = prefs.getString('lastCustomerName') ?? '';
    final lastCustomerAddress = prefs.getString('lastCustomerAddress') ?? '';
    final lastCustomerBirthday = prefs.getString('lastCustomerBirthday') ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Use Last Customer Information?'),
        content: const Text('Do you want to use information from the last customer?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                useLastCustomerInfo = true;
                nameController.text = lastCustomerName;
                addressController.text = lastCustomerAddress;
                birthdayController.text = lastCustomerBirthday;
              });
              Navigator.pop(context);
            },
            child: const Text('Use Last Info'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Start Blank'),
          ),
        ],
      ),
    );
  }

  void _submitCustomer() async {
    if (nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        birthdayController.text.isNotEmpty) {

      final birthday = DateTime.tryParse(birthdayController.text) ?? DateTime.now();
      final newCustomer = Customer(
        id: DateTime.now().millisecondsSinceEpoch,
        name: nameController.text,
        address: addressController.text,
        birthday: birthday,
        email: '',
        password: '',
        firstName: '',
        lastName: '',
        createdAt: DateTime.now(),
      );

      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final customerDao = database.customerDao;
      await customerDao.createCustomer(newCustomer);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('lastCustomerName', nameController.text);
      prefs.setString('lastCustomerAddress', addressController.text);
      prefs.setString('lastCustomerBirthday', birthdayController.text);

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields.')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    birthdayController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.translate('add_customer') ?? 'Add Customer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
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
              title: Text(AppLocalizations.of(context)?.translate('english') ??
                  'English'),
              onTap: () {
                MyApp.setLocale(context, const Locale('en', ''));
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppLocalizations.of(context)?.translate('spanish') ??
                  'Spanish'),
              onTap: () {
                MyApp.setLocale(context, const Locale('es', ''));
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: birthdayController,
              decoration: const InputDecoration(labelText: 'Birthday (yyyy-MM-dd)'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitCustomer,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}