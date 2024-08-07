import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/admin_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import 'package:i_can_fly/utils/helpers.dart';

// create DartDoc comments
/// A StatefulWidget that represents the admin login page.
/// Instance of [EncryptedSharedPreferences] for securely storing and retrieving data.
/// 6. Each activity must use EncryptedSharedPreferences to save something about what was typed in the EditText for use the next time the application is launched.
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
  final EncryptedSharedPreferences esp = EncryptedSharedPreferences();

  /// A global key that uniquely identifies the Form widget and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    AppDatabase.getInstance().then((db) => adminDao = db.adminDao);
    esp.getString("email").then((value) {
      _emailController.text = value;
    });
    esp.getString("password").then((value) {
      _passwordController.text = value;
    });
  }

  snakeToCapitalize(String snake_case) {
    if (!snake_case.contains("_") || snake_case.isEmpty) return snake_case;

    return snake_case.split("_").map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(" ");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( lookupTranslate(context, "admin_login"),
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
                  decoration: InputDecoration(
                    labelText: lookupTranslate(context, "email"),
                    hintText: "e.g: abc@def.com",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // return AppLocalizations.of(context)?.translate("please_enter_email");
                      return lookupTranslate(context, "please_enter_email");
                    }
                    String pattern =
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return lookupTranslate(context, "please_enter_a_valid_email_address");
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key("passwordField"),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: lookupTranslate(context, "password"),
                    hintText:lookupTranslate(context, "password"),
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return lookupTranslate(context, "please_enter_password");
                    }
                    if (value.length < 8) {
                      return lookupTranslate(context, "password_min_length");
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
                        if (user != null) {
                          if (user.password == password &&
                              user.email.toLowerCase() == email) {
                            esp.setString("email", user.email);
                            esp.setString("password", user.password);
                            Navigator.pushNamed(context, "/flights");
                          } else {
                            // some error message
                            loginFailed(context, lookupTranslate(context, "invalid_email_or_password"));
                          }
                        } else {
                          // some error message
                          loginFailed(context, lookupTranslate(context, "no_user_found"));
                        }
                      });
                    }
                  },
                  child: Text(lookupTranslate(context, "login")),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin-register");
                  },
                  child: Text(lookupTranslate(context, "Register")),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                    esp.clear();
<<<<<<< HEAD
                      _emailController.text = "";
                      _passwordController.text= "";
=======
>>>>>>> fc9023e (feat: clear esp)
                    });
                  },
                  child: Text(lookupTranslate(context, "Clear")),
                ),
              ],
            ),
          ),
        ),
      ),
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
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
