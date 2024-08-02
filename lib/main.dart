import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';

import 'package:i_can_fly/page/admin/admin_login.dart';
import 'package:i_can_fly/page/admin/admin_reg.dart';
import 'package:i_can_fly/page/airplane/airplane_page.dart';
import 'package:i_can_fly/page/airplane/manage_airplane.dart';

import 'package:i_can_fly/db/database_initializer.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/page/admin/admin_login.dart';
import 'package:i_can_fly/page/admin/admin_reg.dart';
import 'package:i_can_fly/page/airplane/airplane_page.dart';
import 'package:i_can_fly/page/customer/customer_home.dart';

import 'package:i_can_fly/page/customer/customer_list.dart';
import 'package:i_can_fly/page/customer/customer_login_page.dart';
import 'package:i_can_fly/page/customer/customer_register_page.dart';
import 'package:i_can_fly/page/customer/edit_customer_page.dart';
import 'package:i_can_fly/page/flight/flight_page.dart';
import 'package:i_can_fly/page/flight/add_flight.dart';
import 'package:i_can_fly/page/welcome.dart';
import 'package:i_can_fly/utils/app_localizations.dart';

import 'dart:async';


import 'package:i_can_fly/page/reservation/reservation_list.dart';
import 'package:i_can_fly/utils/theme_color.dart';

///these comments are just to push to git. adding just to make push command work
///
void main() {
  runApp(const MyApp());
}




/// The main application widget.
///
/// This widget sets up the MaterialApp with routes and theme.

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  /// This method is intended to be used when changing the language
  /// dynamically, such as through user input.
  /// The source for this was the last week material.
  static void setLocale(BuildContext context, Locale newLocale) async {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLanguage(newLocale);
  }
}

class _MyAppState extends State<MyApp> {

  /// This updates the internal state with the new locale.
  /// [locale] - The new locale to be set for the application.
  Locale _locale = const Locale('en', '');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // AppDatabase.getInstance().then((db) => print(db.database));
    return DatabaseInitializer(
      builder: (database) {
        return MaterialApp(
          title: 'Welcome!',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color(CTColor.Green.colorValue)),
            useMaterial3: true,
            // Define the default font family here if you want it applied throughout the app
            fontFamily: 'Montserrat',
          ),

          ///This code section is responsible for making translations possible.
          locale: _locale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: "/",
          routes: {
            "/welcome": (context) => const WelcomePage(),
            "/": (context) => HomePage(),
            "/flights": (context) => const FlightsPage(),
            "/admin-login": (context) => const AdminLoginPage(),
            "/admin-register": (context) => const AdminRegisterPage(),
            "/add-flight": (context) => const AddFlightPage(),

            /// Route for the Customer Login page.
            /// This route initializes the AppDatabase and passes it to the CustomerLoginPage.
            "/customer-login": (context) =>
                CustomerLoginPage(database: database),
            "/customer-register": (context) => const CustomerRegisterPage(),
            "/airplanes": (context) => const AirplanePage(),

            /// Route for the Customer List page.
            /// This route initializes the AppDatabase and passes it to the CustomerListPage.
            "/customers": (context) => CustomerListPage(database: database),
            "/edit-customer": (context) {
              final customer = ModalRoute
                  .of(context)
                  ?.settings
                  .arguments as Customer?;
              return EditCustomerPage(customer: customer!);
            },
            "/customer-register": (context) => const CustomerRegisterPage(),
            "/airplanes": (context) => const AirplanePage(),
            "/manage-airplane": (context) =>
            const ManageAirplanePage(isEditMode: false),


            /// Route for the Reservations page.
            /// Requires a FlightDao object as an argument.
            "/reservations": (context) {
              // final flightDao = ModalRoute.of(context)!.settings.arguments as FlightDao;
              // print(flightDao);
              return FutureBuilder<AppDatabase>(
                future: AppDatabase.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ReservationListPage(
                        flightDao: snapshot.data!.flightDao);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            },
          },
          onGenerateRoute: (settings) {
            if (settings.name == "/edit-customer") {
              final customer = settings.arguments as Customer?;
              return MaterialPageRoute(
                builder: (context) => EditCustomerPage(customer: customer!),
              );
            }
            return null;
          },
          restorationScopeId: "app",
        );
      },
    );
  }
}


class HomePage extends StatefulWidget {

  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, "/airplanes");
            //   },
            //   child: const Text("Airplanes List"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, "/airlines");
            //   },
            //   child: const Text("Airlines List"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(
            //         context, "/customers");
            //   },
            //   child: const Text("Customer List"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(
            //         context, "/reservations");
            //   },
            //   child: const Text("Reservation Page"),
            //
            // ),
            ),
          ],
        ),
      ),
    );
  }
}
