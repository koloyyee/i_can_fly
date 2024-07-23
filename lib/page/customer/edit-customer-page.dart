import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/customer-dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';

class EditCustomerPage extends StatefulWidget {
  final Customer customer;
  const EditCustomerPage({super.key, required this.customer});

  @override
  State<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<EditCustomerPage> {
  late CustomerDao customerDao;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.customer.name);
    emailController = TextEditingController(text: widget.customer.email);

    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) {
      customerDao = db.customerDao;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Customer"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter an email' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedCustomer = widget.customer.copyWith(
                      name: nameController.text,
                      email: emailController.text,
                    );
                    customerDao.updateCustomer(updatedCustomer).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Customer updated successfully')),
                      );
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Update Customer'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("Delete Customer"),
                      content: Text("Are you sure you want to delete ${widget.customer.name}?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            customerDao.deleteCustomer(widget.customer);
                            Navigator.pop(context, true);
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
                child: const Text('Delete Customer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
