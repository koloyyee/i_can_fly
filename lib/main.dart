import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i_can_fly/common/language_drawer.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/dao/reservation_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/db/database_initializer.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/entity/reservation.dart';
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
import 'package:i_can_fly/page/reservation/reservation_list.dart';
import 'package:i_can_fly/page/welcome.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import 'package:i_can_fly/utils/helpers.dart';

import 'package:i_can_fly/utils/theme_color.dart';

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
    AppDatabase.getInstance().then((db) => print(db.database));
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
          initialRoute: "/",
          routes: {
            // "/welcome": (context) => const WelcomePage(),
            "/": (context) => const HomePage(),
            "/customer-home": (context) {
              final customer = ModalRoute.of(context)?.settings.arguments as Customer?;
              return CustomerHomePage(customer: customer!);
            },
            "/flights": (context) => const FlightsPage(),
            // "/admin-login": (context) => const AdminLoginPage(),
            // "/admin-register": (context) => const AdminRegisterPage(),
            "/add-flight": (context) => const AddFlightPage(),
            "/customer-login": (context) => CustomerLoginPage(database: database),
            "/customer-register": (context) => const CustomerRegisterPage(),
            "/airplanes": (context) => const AirplanePage(),
            "/customers": (context) => CustomerListPage(database: database),
            "/edit-customer": (context) {
              final customer = ModalRoute.of(context)?.settings.arguments as Customer?;
              return EditCustomerPage(customer: customer!);
            },
            "/reservations": (context) => ReservationListPage()


              //final reservationdao = ModalRoute.of(context)?.settings.arguments as ReservationDao;
              //return ReservationListPage(reservationdao: reservationdao);
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


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(lookupTranslate(context, "welcome_to")),
        backgroundColor: Color(CTColor.Teal.colorValue),
      ),
      endDrawer: const LanguageDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(70.0),
        children: [
          _buildButton(
            title: lookupTranslate(context, "flights_list"),
            imagePath: 'images/flights.jpg',
            //image credits: https://pikbest.com/backgrounds/airport-departure-board-arrival-and-information-at-in-3d_9626000.html
            context: context,
            routeName: '/flights',
          ),
          _buildButton(
            title: lookupTranslate(context, "airplanes_list"),
            imagePath: 'images/airplane.jpg',
            //image credits: https://wallpapercave.com/w/wp2478615
            context: context,
            routeName: '/airplanes',
          ),
          // _buildButton(
          //   title: lookupTranslate(context, "airline_list"),
          //   imagePath: 'images/airline.jpg',
          //   context: context,
          //   routeName: '/airlines',
          // ),
          _buildButton(
            title: lookupTranslate(context, "customer_list"),
            imagePath: 'images/Customers.jpg',
            //image credits: https://www.samsic.aero/check-boarding?origin=6&type=taxonomy_term
            context: context,
            routeName: '/customers',
          ),
          _buildButton(
            title: lookupTranslate(context, "reservations_list"),
            imagePath: 'images/Reservation.jpeg',
            //image credits: https://pvtistes.net/en/air-transat-extra-23kg-luggage-allowance-canada/
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
    const double imageHeight = 275.0; // Image height
    const double opacity = 0.50; // Image opacity 0.0-1.0

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        height: imageHeight,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: opacity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Color(CTColor.BlackTeal.colorValue),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
