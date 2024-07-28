import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/admin_dao.dart';
import 'package:i_can_fly/db/database.dart';

// create DartDoc comments
/// A StatefulWidget that represents the admin login page.
/// Instance of [EncryptedSharedPreferences] for securely storing and retrieving data.
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

/// The state for the [AdminLoginPage] widget.
class _AdminLoginPageState extends State<AdminLoginPage> {
  late AdminDao adminDao;
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
    AppDatabase.getInstance().then((db) => adminDao = db.adminDao);
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
        title: const Text(
          "Admin Login",
          style: TextStyle(color: Colors.white),
        ),
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
                key: const Key("emailField"),
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
                key: const Key("passwordField"),
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
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
                    adminDao.findAdminByEmail(email).then((user) {
                      print(user?.email);
                      print(user?.password);
                      if (user != null) {
                        if (user.password == password &&
                            user.email.toLowerCase() == email) {
                          esp.setString("email", user.email);
                          esp.setString("password", user.password);
                          Navigator.pushNamed(context, "/flights");

                        }  else {
                          // some error message
                          loginFailed(context, "Invalid email or password");
                        }
                      } else {
                        // some error message
                        loginFailed(context, "No user found");
                        
                      }
                    });
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin-register");
                  },
                  child: const Text("Register")),
            ],
          ),
        ),
      )),
    );
  }



  Future<dynamic> loginFailed(BuildContext context, String msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(msg),
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
}
