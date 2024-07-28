import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      final newCustomer = Customer(
        id: DateTime.now().millisecondsSinceEpoch,
        name: nameController.text,
        address: addressController.text,
        birthday: int.tryParse(birthdayController.text) ?? 0,
        email: '',
        password: '',
        firstName: '',
        lastName: '',
        createdAt: DateTime.now().millisecondsSinceEpoch,
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
        title: const Text('Add Customer'),
        backgroundColor: Colors.teal,
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
              decoration: const InputDecoration(labelText: 'Birthday'),
              keyboardType: TextInputType.number,
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
