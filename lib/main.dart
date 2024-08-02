import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/page/admin/admin_login.dart';
import 'package:i_can_fly/page/admin/admin_reg.dart';
import 'package:i_can_fly/page/airplane/airplane_page.dart';
import 'package:i_can_fly/page/airplane/manage_airplane.dart';
import 'package:i_can_fly/page/customer/customer_home_page.dart';
import 'package:i_can_fly/page/customer/customer_list.dart';
import 'package:i_can_fly/page/customer/customer_login_page.dart';
import 'package:i_can_fly/page/customer/customer_register_page.dart';
import 'package:i_can_fly/page/customer/edit_customer_page.dart';
import 'package:i_can_fly/page/flight/flight_page.dart';
import 'package:i_can_fly/page/flight/add_flight.dart';
import 'package:i_can_fly/page/welcome.dart';

import 'package:i_can_fly/page/reservation/reservation_list.dart';
import 'package:i_can_fly/utils/theme_color.dart';

void main() {
  runApp(const MyApp());
}

/// The main application widget.
///
/// This widget sets up the MaterialApp with routes and theme.
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // AppDatabase.getInstance().then((db) => print(db.database));
    return MaterialApp(
      title: 'Welcome!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(CTColor.Green.colorValue)),
        useMaterial3: true,
        // Define the default font family here if you want it applied throughout the app
        fontFamily: 'Montserrat',
      ),
      initialRoute: "/",
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                Navigator.pushNamed(context, "/flights");
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
                    context, "/customers"); // Navigate to CustomerListPage
              },
              child: const Text("Customer List"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, "/reservation");
              },
              child: const Text("Reservation Page"),
            ),
          ],
        ),
      ),
    );
  }
}
