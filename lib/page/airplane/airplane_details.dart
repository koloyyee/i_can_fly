import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/airplane.dart';

class AirplaneDetailsPage extends StatefulWidget {
  final Airplane airplane;

  AirplaneDetailsPage({required this.airplane});

  @override
  _AirplaneDetailsPageState createState() => _AirplaneDetailsPageState();
}

class _AirplaneDetailsPageState extends State<AirplaneDetailsPage> {
  late Airplane _airplane;

  @override
  void initState() {
    super.initState();
    _airplane = widget.airplane;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_airplane.type)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${_airplane.type}', style: TextStyle(fontSize: 18)),
            Text('Capacity: ${_airplane.capacity}', style: TextStyle(fontSize: 18)),
            Text('Max Speed: ${_airplane.maxSpeed}', style: TextStyle(fontSize: 18)),
            Text('Max Range: ${_airplane.maxRange}', style: TextStyle(fontSize: 18)),
            Text('Manufacturer: ${_airplane.manufacturer}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
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
      ),
    );
  }

  Future<void> _updateAirplane() async {
    final db = await AppDatabase.getInstance();
    await db.airplaneDao.updateAirplane(_airplane);
    Navigator.of(context).pop();
  }

  Future<void> _deleteAirplane() async {
    final db = await AppDatabase.getInstance();
    await db.airplaneDao.deleteAirplane(_airplane);
    Navigator.of(context).pop();
  }
}
