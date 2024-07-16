import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlightsPage extends StatefulWidget {
  const FlightsPage({super.key});

  @override
  State<FlightsPage> createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flight List"),
      ),
      body: const Center(
        child: Text("Flight List"),
      ),
    );
  }
}