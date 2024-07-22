import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/staff-dao.dart';
import 'package:i_can_fly/db/database.dart';

/// for the staff to
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  late StaffDao staffDao;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    // $FloorAppDatabase.databaseBuilder("app_database.db").build().then((db) {
    //   print(db.database);
    //   staffDao = db.staffDao;
    // });
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Admin Login", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const Text("Username"),
            const SizedBox(height: 10),
            TextField( controller: usernameController, ),
            const SizedBox(height: 20),
            const Text("Password"),
            const SizedBox(height: 10),
            TextField(controller: passwordController, obscureText: true,),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // login
                // staffDao.findStaffById()
                Navigator.pushNamed(context, "/flights");

              },
              child: const Text("Login"),
            )
          ],
        ),
      )),
    );
  }
}
