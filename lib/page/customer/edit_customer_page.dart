import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';


class EditCustomerPage extends StatefulWidget {
  final Customer customer;

  const EditCustomerPage({super.key, required this.customer});

  @override
  _EditCustomerPageState createState() => _EditCustomerPageState();
}

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

    // Initialize controllers with current customer data
    nameController = TextEditingController(text: widget.customer.name);
    emailController = TextEditingController(text: widget.customer.email);
    passwordController = TextEditingController(text: widget.customer.password);
    firstNameController = TextEditingController(text: widget.customer.firstName);
    lastNameController = TextEditingController(text: widget.customer.lastName);
    addressController = TextEditingController(text: widget.customer.address);
    birthdayController = TextEditingController(text: widget.customer.birthday.toString());
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

      final updatedCustomer = Customer(
        id: widget.customer.id, // Use the existing ID to identify the customer to update
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        birthday: int.tryParse(birthdayController.text) ?? 0, // Default to 0 if parsing fails
        address: addressController.text,
        createdAt: widget.customer.createdAt, // Preserve the original createdAt timestamp
      );

      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final customerDao = database.customerDao;
      await customerDao.updateCustomer(updatedCustomer);

      Navigator.pop(context, true); // Close the page and indicate success
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

    Navigator.pop(context, true); // Close the page and indicate success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Customer deleted successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Customer'),
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
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
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
              onPressed: _updateCustomer,
              child: const Text('Update'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteCustomer,
              child: const Text('Delete'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}




