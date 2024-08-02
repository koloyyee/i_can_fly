import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/page/reservation/reservation_list.dart';

class CustomerHomePage extends StatelessWidget {
  final Customer customer;
  const CustomerHomePage({super.key, required this.customer});
  @override
  Widget build(BuildContext context) {
    final database = $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to your home page!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose your preference',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/edit-customer",
                  arguments: customer,
                );
           },
              child: const Text("Edit Profile"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder<AppDatabase>(
                      future: database,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ReservationListPage(flightDao: snapshot.data!.flightDao);
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                );
              },
              child: const Text("Make a Reservation"),
            ),
          ],
        ),
      ),
    );
  }
}
