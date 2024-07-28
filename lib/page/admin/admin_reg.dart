import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/admin_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/admin.dart';

/// A StatefulWidget that represents the admin register page.
/// Instance of [EncryptedSharedPreferences] for securely storing and retrieving data.
/// Instance of [AdminDao] for accessing the admin table.
/// A global key that uniquely identifies the Form widget and allows validation of the form.
class AdminRegisterPage extends StatefulWidget {
  const AdminRegisterPage({super.key});

  @override
  State<AdminRegisterPage> createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AdminDao adminDao;

  EncryptedSharedPreferences esp = EncryptedSharedPreferences();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    AppDatabase.getInstance().then((db) => adminDao = db.adminDao);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Register"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Admin Register"),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
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
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return "Please enter password, at least 8 characters";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Admin newAdmin = Admin(
                          email: _emailController.text.toLowerCase(),
                          password: _passwordController.text,
                          createdAt: DateTime.now());
                          adminDao.createAdmin(newAdmin);
                          esp.setString("email", newAdmin.email);
                          esp.setString("password", newAdmin.password);

                          Navigator.pushNamed(context, "/admin-login");
                    }
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
