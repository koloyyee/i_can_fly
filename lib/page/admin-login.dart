import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/admin-dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/admin.dart';

/// for the staff to
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  late AdminDao adminDao;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    $FloorAppDatabase.databaseBuilder("app_database.db").build().then((db) {
      adminDao = db.adminDao;
    });
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
              controller: emailController,
            ),
            const SizedBox(height: 20),
            const Text("Password"),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.value.text;
                print(email);
                // login
                adminDao
                    .findAdminByEmail(emailController.value.text)
                    .then((user) {
                      print(user);
                  if (user != null) {
                    user.password == passwordController.value.text
                        ? print("Login Success")
                        : print("Login Failed");
                    Navigator.pushNamed(context, "/flights");
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
