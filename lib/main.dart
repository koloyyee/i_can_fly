import 'package:flutter/material.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage());
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
        // backgroundColor: const Color(0x45ADA8),
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // actions: [],
      ),
    );
  }
}
