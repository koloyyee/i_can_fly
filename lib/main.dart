import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';
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
    return DatabaseInitializer(
      builder: (database) {
        return MaterialApp(
          title: 'Welcome!',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(CTColor.Green.colorValue),
            ),
             useMaterial3: true,
          ),
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
          initialRoute: "/welcome",
          routes: {
            "/welcome": (context) => const WelcomePage(),
            "/": (context) => const HomePage(),
            "/customer-home": (context) {
              final customer = ModalRoute.of(context)?.settings.arguments as Customer?;
              return CustomerHomePage(customer: customer!);
            },
            "/flights": (context) => const FlightsPage(),
            "/admin-login": (context) => const AdminLoginPage(),
            "/admin-register": (context) => const AdminRegisterPage(),
            "/add-flight": (context) => const AddFlightPage(),
            "/customer-login": (context) => CustomerLoginPage(database: database),
            "/customer-register": (context) => const CustomerRegisterPage(),
            "/airplanes": (context) => const AirplanePage(),
            "/customers": (context) => CustomerListPage(database: database),
            "/edit-customer": (context) {
              final customer = ModalRoute.of(context)?.settings.arguments as Customer?;
              return EditCustomerPage(customer: customer!);
            },
            "/reservations": (context) {
              final flightDao = ModalRoute.of(context)?.settings.arguments as FlightDao?;
              return ReservationListPage(flightDao: flightDao!);
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
