import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/flight-page.dart';
import 'package:i_can_fly/page/flight/add-flight.dart';
import 'package:i_can_fly/utils/theme-color.dart';
// import 'airplane_list_page.dart';

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
        // home: HomePage(),
        routes: {
          "/": (context) => const HomePage(),
          "/flights": (context) => const FlightsPage(),
          "/add-flight": (context) => AddFlightPage(),
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) {
      print(db.database);
    });
  }

  @override
  Widget build(BuildContext context) {
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) {
      print(db.database);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to I Can Fly"),
        backgroundColor: Color(CTColor.Teal.colorValue),
        // backgroundColor: const Color(0x45ADA8),
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // actions: [],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/flights");
                },
                child: const Text("Flights List")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/airplanes");
                },
                child: const Text("Airplanes List")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/airlines");
                },
                child: const Text("Airlines List")),
          ],
        ),
      ),
    );
  }
}
