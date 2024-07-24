import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import '../../entity/airplane.dart';
import '../../utils/theme-color.dart';

/**
 * ManageAirplanePage is a stateful widget that allows users to add, edit, or delete airplane details.
 * It handles both modes: adding a new airplane and editing an existing one.
 */
class ManageAirplanePage extends StatefulWidget {
  final Airplane? airplane; // The airplane to be managed (can be null if adding a new airplane)
  final bool isEditMode; // Indicates whether the page is in edit mode

  const ManageAirplanePage({
    super.key,
    this.airplane,
    required this.isEditMode,
  });

  @override
  _ManageAirplanePageState createState() => _ManageAirplanePageState();
}

class _ManageAirplanePageState extends State<ManageAirplanePage> {
  late TextEditingController _typeController;
  late TextEditingController _capacityController;
  late TextEditingController _maxSpeedController;
  late TextEditingController _maxRangeController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing airplane data or empty values for new airplane
    _typeController = TextEditingController(text: widget.airplane?.type ?? '');
    _capacityController = TextEditingController(text: widget.airplane?.capacity.toString() ?? '');
    _maxSpeedController = TextEditingController(text: widget.airplane?.maxSpeed.toString() ?? '');
    _maxRangeController = TextEditingController(text: widget.airplane?.maxRange.toString() ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _typeController.dispose();
    _capacityController.dispose();
    _maxSpeedController.dispose();
    _maxRangeController.dispose();
    super.dispose();
  }

  /**
   * Saves the airplane details to the database.
   * If in edit mode, updates the existing airplane, otherwise creates a new airplane.
   */
  void _save() async {
    final database = await AppDatabase.getInstance();
    final dao = database.airplaneDao;
    final airplane = Airplane(
      id: widget.airplane?.id,
      type: _typeController.text,
      capacity: int.parse(_capacityController.text),
      maxSpeed: int.parse(_maxSpeedController.text),
      maxRange: int.parse(_maxRangeController.text),
      manufacturer: 'Unknown', // Adjust this as needed
    );

    if (widget.isEditMode) {
      await dao.updateAirplane(airplane);
      Navigator.pop(context, true); // Return true to indicate success
    } else {
      await dao.createAirplane(airplane);
      Navigator.pop(context, true); // Return true to indicate success
    }
  }

  /**
   * Deletes the airplane from the database after user confirmation.
   */
  void _delete() async {
    final database = await AppDatabase.getInstance();
    final dao = database.airplaneDao;
    if (widget.airplane != null) {
      final shouldDelete = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this airplane?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm delete
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel delete
              child: const Text('No'),
            ),
          ],
        ),
      );

      if (shouldDelete ?? false) {
        await dao.deleteAirplane(widget.airplane!);
        Navigator.pop(context, true); // Return true to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Airplane Deleted')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'Edit Airplane' : 'Add Airplane'),
        backgroundColor: Color(CTColor.Teal.colorValue),
        actions: widget.isEditMode
            ? [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _delete, // Show delete button in edit mode
          ),
        ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Airplane Type'),
            ),
            TextField(
              controller: _capacityController,
              decoration: const InputDecoration(labelText: 'Passenger Capacity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxSpeedController,
              decoration: const InputDecoration(labelText: 'Max Speed'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxRangeController,
              decoration: const InputDecoration(labelText: 'Max Range/Distance'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _save, // Save the airplane details
                  child: Text(widget.isEditMode ? 'Update' : 'Save'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), // Cancel and go back
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
