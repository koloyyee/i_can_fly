import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/airplane/add_airplane.dart';
import 'package:i_can_fly/page/airplane/view_airplanes_list.dart';
import 'package:i_can_fly/page/flight-page.dart';
import 'package:i_can_fly/page/flight/add-flight.dart';
import 'package:i_can_fly/utils/theme-color.dart';

void main() {
  runApp(const MyApp());
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
      routes: {
        "/": (context) => const HomePage(),
        "/flights": (context) => const FlightsPage(),
        "/admin-login": (context) => const FlightsPage(),
        "/add-flight": (context) => const AddFlightPage(),
        "/airplanes": (context) => const AirplaneListPage(),  // Add route for AirplaneListPage
        "/add-airplane": (context) => AddAirplanePage(),  // Add route for AddAirplanePage
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
          ],
        ),
      ),
    );
  }
}
