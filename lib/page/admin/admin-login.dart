import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/admin-dao.dart';
import 'package:i_can_fly/db/database.dart';

// we need to save the credential if the login is successful 


/// for the staff to
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  late AdminDao adminDao;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  EncryptedSharedPreferences esp = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    AppDatabase.getInstance().then((db) => adminDao = db.adminDao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Login"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Admin Login", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const Text("email"),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            const Text("Password"),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.value.text;
                print(email);
                // login
                adminDao
                    .findAdminByEmail(_emailController.value.text)
                    .then((user) {
                  if (user != null) {
                    if(user.password == _passwordController.value.text && user.email == _emailController.value.text) {
                      esp.setString("email", user.email);
                      esp.setString("password", user.password);
                      Navigator.pushNamed(context, "/flights");
                    }
                  } else {
                    // some error message
                  }
                });
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
      )),
    );
  }
}
