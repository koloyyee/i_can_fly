import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/admin/admin_login.dart';
import 'package:i_can_fly/page/admin/admin_reg.dart';
import 'package:i_can_fly/page/airplane/airplane_page.dart';
import 'package:i_can_fly/page/customer/customer_list.dart';
import 'package:i_can_fly/page/customer/customer_login_page.dart';
import 'package:i_can_fly/page/customer/customer_register_page.dart';
import 'package:i_can_fly/page/flight/flight_page.dart';
import 'package:i_can_fly/page/flight/add_flight.dart';
import 'package:i_can_fly/page/welcome.dart';
import 'package:i_can_fly/utils/theme-color.dart';
import 'dart:async';
import 'package:floor/floor.dart';

import 'package:i_can_fly/page/reservation/reservation_list.dart';

void main() {
  runApp(const MyApp());
  // "2023-04-01 10:00:00"
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(CTColor.Green.colorValue)),
        useMaterial3: true,
      ),
      initialRoute: "/welcome",
      routes: {
        "/welcome": (context) => const WelcomePage(),
        "/": (context) => const HomePage(),
        "/flights": (context) => const FlightsPage(),
        "/admin-login": (context) => const AdminLoginPage(),
        "/admin-register": (context) => const AdminRegisterPage(),
        "/add-flight": (context) => const AddFlightPage(),
        "/customer-login": (context) => const CustomerLoginPage(),
        "/customer-register": (context) => const CustomerRegisterPage(),
        "/airplanes": (context) => const AirplanePage(),
        "/customers": (context) => const CustomerListPage(),
        //"/reservations": (context) => const ReservationListPage(flightDao),

      },
      restorationScopeId: "app",
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<AppDatabase> _database;

  @override
  void initState() {
    super.initState();
    _database = $FloorAppDatabase.databaseBuilder('app_database.db').build();
    print(_database.then((db)=> print(db.database)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to I Can Fly"),
        backgroundColor: Color(CTColor.Teal.colorValue),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/admin-login");
              },
              child: const Text("Flights List"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/airplanes");
              },
              child: const Text("Airplanes List"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/airlines");
              },
              child: const Text("Airlines List"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, "/customers");
              },
              child: const Text("Customer List"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, "/reservations");
              },
              child: const Text("Reservation Page"),
            ),
          ],
        ),
      ),
    );
  }
}

