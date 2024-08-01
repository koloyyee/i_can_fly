import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/admin/admin_login.dart';
import 'package:i_can_fly/page/admin/admin_reg.dart';
import 'package:i_can_fly/page/airplane/airplane_page.dart';
import 'package:i_can_fly/page/airplane/manage_airplane.dart';
import 'package:i_can_fly/page/customer/customer_list.dart';
import 'package:i_can_fly/page/customer/customer_login_page.dart';
import 'package:i_can_fly/page/customer/customer_register_page.dart';
import 'package:i_can_fly/page/flight/flight_page.dart';
import 'package:i_can_fly/page/flight/add_flight.dart';
import 'package:i_can_fly/page/welcome.dart';
import 'package:i_can_fly/utils/theme-color.dart';
import 'package:i_can_fly/page/reservation/reservation_list.dart';

void main() {
  runApp(const MyApp());
}

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
        "/manage-airplane": (context) => const ManageAirplanePage(isEditMode: false),
        "/customers": (context) => const CustomerListPage(),
        "/reservations": (context) => const ReservationListPage(),
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
      body: ListView(
        padding: const EdgeInsets.all(70.0),
        children: [
          _buildButton(
            title: 'Flights List',
            imagePath: 'images/flights.jpg',
            context: context,
            routeName: '/admin-login',
          ),
          _buildButton(
            title: 'Airplanes List',
            imagePath: 'images/airplane.jpg',
            context: context,
            routeName: '/airplanes',
          ),
          _buildButton(
            title: 'Airlines List',
            imagePath: 'images/airline.jpg',
            context: context,
            routeName: '/airlines',
          ),
          _buildButton(
            title: 'Customer List',
            imagePath: 'images/Customers.jpg',
            context: context,
            routeName: '/customers',
          ),
          _buildButton(
            title: 'Reservation Page',
            imagePath: 'images/Reservation.jpeg',
            context: context,
            routeName: '/reservations',
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required String imagePath,
    required BuildContext context,
    required String routeName,
  }) {
    const double imageHeight = 275.0; // Define height here
    const double opacity = 0.50; // Set desired opacity (0.0 to 1.0)

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        height: imageHeight, // Set the defined height
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: opacity, // Adjust opacity here
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Color(CTColor.BlackTeal.colorValue), // Text color set to DarkTeal
                  fontSize: 35, // Change font size here
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat', // Apply Montserrat font
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
