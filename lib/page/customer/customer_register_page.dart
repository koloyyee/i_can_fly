import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:i_can_fly/main.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import '../../db/database.dart';
import 'package:intl/intl.dart'; // For date formatting and parsing

class CustomerRegisterPage extends StatefulWidget {
  const CustomerRegisterPage({super.key});

  @override
  _CustomerRegisterPageState createState() => _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends State<CustomerRegisterPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController addressController;
  late TextEditingController birthdayController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    addressController = TextEditingController();
    birthdayController = TextEditingController();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Please fill all fields correctly.');
      return;
    }

    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final customerDao = database.customerDao;

    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final address = addressController.text;

    // Parse the birthday
    DateTime? birthday;
    try {
      birthday = DateFormat('yyyy-MM-dd').parse(birthdayController.text);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Invalid date format. Please use yyyy-MM-dd.');
      return;
    }

    // Check if the email is already in use
    final existingCustomer = await customerDao.findCustomerByEmailAndPassword(email, password);
    if (existingCustomer != null) {
      Fluttertoast.showToast(msg: 'Email already in use');
      return;
    }

    final newCustomer = Customer(
      name: name,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      address: address,
      birthday: birthday,
      createdAt: DateTime.now(),
    );


    ///Move back to login page after registration.
    await customerDao.createCustomer(newCustomer);
    Fluttertoast.showToast(msg: 'Registration successful!');

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(AppLocalizations.of(context)?.translate('register') ?? 'Register'),
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
              title: Text(AppLocalizations.of(context)?.translate('english') ?? 'English'),
              onTap: () {
                MyApp.setLocale(context, const Locale('en', ''));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)?.translate('spanish') ?? 'Spanish'),
              onTap: () {
                MyApp.setLocale(context, const Locale('es', ''));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.translate('name') ?? 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.translate('name_required') ?? 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.translate('email') ?? 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.translate('email_required') ?? 'Email is required';
                    }
                    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                    final regExp = RegExp(emailPattern);
                    if (!regExp.hasMatch(value)) {
                      return AppLocalizations.of(context)?.translate('invalid_email') ?? 'Invalid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.translate('password') ?? 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.translate('password_required') ?? 'Password is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.translate('first_name') ?? 'First Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.translate('first_name_required') ?? 'First name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.translate('last_name') ?? 'Last Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.translate('last_name_required') ?? 'Last name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.translate('address') ?? 'Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.translate('address_required') ?? 'Address is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: birthdayController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.translate('birthday') ?? 'Birthday (yyyy-MM-dd)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)?.translate('birthday_required') ?? 'Birthday is required';
                    }
                    try {
                      DateFormat('yyyy-MM-dd').parse(value);
                    } catch (e) {
                      return AppLocalizations.of(context)?.translate('invalid_date') ?? 'Invalid date format. Please use yyyy-MM-dd.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: Text(AppLocalizations.of(context)?.translate('register') ?? 'Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

