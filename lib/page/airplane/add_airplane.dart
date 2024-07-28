import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/airplane.dart';

class AddAirplanePage extends StatefulWidget {
  const AddAirplanePage({super.key});

  @override
  _AddAirplanePageState createState() => _AddAirplanePageState();
}

class _AddAirplanePageState extends State<AddAirplanePage> {
  final _typeController = TextEditingController();
  final _capacityController = TextEditingController();
  final _maxSpeedController = TextEditingController();
  final _maxRangeController = TextEditingController();
  final _manufacturerController = TextEditingController();

  Future<void> _addAirplane() async {
    final type = _typeController.text;
    final capacity = int.tryParse(_capacityController.text) ?? 0;
    final maxSpeed = int.tryParse(_maxSpeedController.text) ?? 0;
    final maxRange = int.tryParse(_maxRangeController.text) ?? 0;
    final manufacturer = _manufacturerController.text;

    if (type.isEmpty || manufacturer.isEmpty || capacity <= 0 || maxSpeed <= 0 || maxRange <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields correctly.')),
      );
      return;
    }

    final db = await AppDatabase.getInstance();
    final airplane = Airplane(
      type: type,
      capacity: capacity,
      maxSpeed: maxSpeed,
      maxRange: maxRange,
      manufacturer: manufacturer,
    );
    await db.airplaneDao.createAirplane(airplane);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Airplane')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: _capacityController,
              decoration: const InputDecoration(labelText: 'Capacity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxSpeedController,
              decoration: const InputDecoration(labelText: 'Max Speed'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxRangeController,
              decoration: const InputDecoration(labelText: 'Max Range'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _manufacturerController,
              decoration: const InputDecoration(labelText: 'Manufacturer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addAirplane,
              child: const Text('Add Airplane'),
            ),
          ],
        ),
      ),
    );
  }
}
