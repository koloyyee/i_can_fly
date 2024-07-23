import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/airplane.dart';

class EditAirplanePage extends StatefulWidget {
  final Airplane airplane;

  EditAirplanePage({required this.airplane});

  @override
  _EditAirplanePageState createState() => _EditAirplanePageState();
}

class _EditAirplanePageState extends State<EditAirplanePage> {
  final _typeController = TextEditingController();
  final _capacityController = TextEditingController();
  final _maxSpeedController = TextEditingController();
  final _maxRangeController = TextEditingController();
  final _manufacturerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typeController.text = widget.airplane.type;
    _capacityController.text = widget.airplane.capacity.toString();
    _maxSpeedController.text = widget.airplane.maxSpeed.toString();
    _maxRangeController.text = widget.airplane.maxRange.toString();
    _manufacturerController.text = widget.airplane.manufacturer;
  }

  Future<void> _updateAirplane() async {
    final db = await AppDatabase.getInstance();
    final updatedAirplane = Airplane(
      id: widget.airplane.id,
      type: _typeController.text,
      capacity: int.parse(_capacityController.text),
      maxSpeed: int.parse(_maxSpeedController.text),
      maxRange: int.parse(_maxRangeController.text),
      manufacturer: _manufacturerController.text,
    );
    await db.airplaneDao.updateAirplane(updatedAirplane);

    Navigator.of(context).pop();
  }

  Future<void> _deleteAirplane() async {
    final db = await AppDatabase.getInstance();
    await db.airplaneDao.deleteAirplane(widget.airplane);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Airplane')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: _capacityController,
              decoration: InputDecoration(labelText: 'Capacity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxSpeedController,
              decoration: InputDecoration(labelText: 'Max Speed'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxRangeController,
              decoration: InputDecoration(labelText: 'Max Range'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _manufacturerController,
              decoration: InputDecoration(labelText: 'Manufacturer'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _updateAirplane,
                  child: Text('Update Airplane'),
                ),
                ElevatedButton(
                  onPressed: _deleteAirplane,
                  child: Text('Delete Airplane'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Updated styling
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
