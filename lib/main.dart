import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/page/admin/admin_login.dart';
import 'package:i_can_fly/page/admin/admin_reg.dart';
import 'package:i_can_fly/page/airplane/airplane_page.dart';
import 'package:i_can_fly/page/customer/customer_list.dart';
import 'package:i_can_fly/page/customer/customer_login_page.dart';
import 'package:i_can_fly/page/customer/customer_register_page.dart';
import 'package:i_can_fly/page/customer/edit_customer_page.dart';
import 'package:i_can_fly/page/flight/flight_page.dart';
import 'package:i_can_fly/page/flight/add_flight.dart';
import 'package:i_can_fly/page/welcome.dart';
import 'package:i_can_fly/utils/theme-color.dart';
import 'dart:async';

import 'package:i_can_fly/page/reservation/reservation_list.dart';

void main() {
  runApp(const MyApp());
  // "2023-04-01 10:00:00"
}

/// The main application widget.
///
/// This widget sets up the MaterialApp with routes and theme.
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

        /// Route for the Customer Home page, requires a Customer object as an argument.
        "/customer-home": (context) {
          final customer = ModalRoute.of(context)!.settings.arguments as Customer;
          return CustomerHomePage(customer: customer);
        },
        "/flights": (context) => const FlightsPage(),
        "/admin-login": (context) => const AdminLoginPage(),
        "/admin-register": (context) => const AdminRegisterPage(),
        "/add-flight": (context) => const AddFlightPage(),

        /// Route for the Customer Login page.
        /// This route initializes the AppDatabase and passes it to the CustomerLoginPage.
        "/customer-login": (context) {
          final databaseFuture = $FloorAppDatabase.databaseBuilder('app_database.db').build();
          return FutureBuilder<AppDatabase>(
            future: databaseFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CustomerLoginPage(database: snapshot.data!);
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        },
        "/customer-register": (context) => const CustomerRegisterPage(),
        "/airplanes": (context) => const AirplanePage(),
        "/customers": (context) => const CustomerListPage(),

        /// Route for editing a customer profile.
        /// Requires a Customer object as an argument.
        "/edit-customer": (context) {
          final customer = ModalRoute.of(context)!.settings.arguments as Customer;
          return EditCustomerPage(customer: customer);
        },

        /// Route for the Reservations page.
        /// Requires a FlightDao object as an argument.
        "/reservations": (context) {
          final flightDao = ModalRoute.of(context)!.settings.arguments as FlightDao;
          return ReservationListPage(flightDao: flightDao);
        },
      },

      /// Function to handle dynamic route generation.
      /// For the /edit-customer route, this method is used to create a MaterialPageRoute.
      onGenerateRoute: (settings) {
        if (settings.name == "/edit-customer") {
          final customer = settings.arguments as Customer;
          return MaterialPageRoute(
            builder: (context) {
              return EditCustomerPage(customer: customer);
            },
          );
        }
        return null;
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
