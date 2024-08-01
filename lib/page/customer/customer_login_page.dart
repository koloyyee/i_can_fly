import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/customer_dao.dart';
import '../../db/database.dart';

/// A StatefulWidget that represents the customer login page.
/// Instance of [EncryptedSharedPreferences] for securely storing and retrieving data.
class CustomerLoginPage extends StatefulWidget {
  const CustomerLoginPage({super.key});

  @override
  State<CustomerLoginPage> createState() => _CustomerLoginPageState();
}

/// The state for the [CustomerLoginPage] widget.
class _CustomerLoginPageState extends State<CustomerLoginPage> {
  late CustomerDao customerDao;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  EncryptedSharedPreferences esp = EncryptedSharedPreferences();

  /// A global key that uniquely identifies the Form widget and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    AppDatabase.getInstance().then((db) => customerDao = db.customerDao);
    esp.getString("email").then((value) {
      _emailController.text = value ?? "";
    });
    esp.getString("password").then((value) {
      _passwordController.text = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Login", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "e.g: abc@def.com",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      }
                      String pattern =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text("Password"),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.value.text.toLowerCase();
                        String password = _passwordController.value.text;
                        // login
                        customerDao
                            .findCustomerByEmailAndPassword(email, password)
                            .then((user) {
                          if (user != null) {
                            esp.setString("email", user.email);
                            esp.setString("password", user.password);
                            Navigator.pushNamed(context, "/customers");
                          } else {
                            // some error message
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: const Text("Invalid email or password"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("OK"))
                                    ],
                                  );
                                });
                          }
                        });
                      }
                    },
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/customer-register");
                      },
                      child: const Text("Register")),
                ],
              ),
            ),
          )),
    );
  }
}