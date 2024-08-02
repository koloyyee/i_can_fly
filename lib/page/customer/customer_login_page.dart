import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/customer_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/main.dart';
import 'package:i_can_fly/page/customer/customer_home.dart';
import 'package:i_can_fly/page/reservation/reservation_list.dart';

import 'package:i_can_fly/utils/app_localizations.dart';


/// A StatefulWidget that represents the customer login page.
class CustomerLoginPage extends StatefulWidget {
  final AppDatabase database;
  const CustomerLoginPage({super.key, required this.database});

  @override
  State<CustomerLoginPage> createState() => _CustomerLoginPageState();
}

class _CustomerLoginPageState extends State<CustomerLoginPage> {
  late CustomerDao customerDao;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final EncryptedSharedPreferences esp = EncryptedSharedPreferences();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    customerDao = widget.database.customerDao;

    esp.getString("email").then((value) {
      _emailController.text = value ?? "";
    });
    esp.getString("password").then((value) {
      _passwordController.text = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    // Ensure appLocalizations is not null
    if (appLocalizations == null) {
      return const Scaffold(
        body: Center(child: Text('Localizations not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.translate('login')),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(appLocalizations.translate('spanish')),
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.translate('email'),
                    hintText: appLocalizations.translate('email') + ' ' + appLocalizations.translate('e.g_example'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return appLocalizations.translate('email_required');
                    }
                    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return appLocalizations.translate('invalid_email');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.translate('password'),
                    hintText: appLocalizations.translate('password'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return appLocalizations.translate('password_required');
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          String email = _emailController.text.toLowerCase();
                          String password = _passwordController.text;

                          customerDao.findCustomerByEmailAndPassword(email, password).then((user) {
                            if (user != null) {
                              esp.setString("email", user.email);
                              esp.setString("password", user.password);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerHomePage(customer: user),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(appLocalizations.translate('error')),
                                    content: Text(appLocalizations.translate('invalid_credentials')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(appLocalizations.translate('ok')),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        }
                      },
                      child: Text(appLocalizations.translate('login')),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/customer-register");
                      },
                      child: Text(appLocalizations.translate('register')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
