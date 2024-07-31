import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import '../../entity/airplane.dart';

class ManageAirplanePage extends StatefulWidget {
  final Airplane? airplane;
  final bool isEditMode;

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
    _typeController = TextEditingController(text: widget.airplane?.type ?? '');
    _capacityController = TextEditingController(text: widget.airplane?.capacity.toString() ?? '');
    _maxSpeedController = TextEditingController(text: widget.airplane?.maxSpeed.toString() ?? '');
    _maxRangeController = TextEditingController(text: widget.airplane?.maxRange.toString() ?? '');
  }

  @override
  void dispose() {
    _typeController.dispose();
    _capacityController.dispose();
    _maxSpeedController.dispose();
    _maxRangeController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_typeController.text.isEmpty ||
        _capacityController.text.isEmpty ||
        _maxSpeedController.text.isEmpty ||
        _maxRangeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all the fields')),
      );
      return;
    }

    try {
      final database = await AppDatabase.getInstance();
      final dao = database.airplaneDao;
      final airplane = Airplane(
        id: widget.airplane?.id,
        type: _typeController.text,
        capacity: int.parse(_capacityController.text),
        maxSpeed: int.parse(_maxSpeedController.text),
        maxRange: int.parse(_maxRangeController.text),
      );

      if (widget.isEditMode) {
        await dao.updateAirplane(airplane);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Airplane Updated')),
        );
      } else {
        await dao.createAirplane(airplane);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Airplane Created')),
        );
      }

      Navigator.popUntil(context, ModalRoute.withName('/airplanes')); // Go back to the airplane page
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving airplane: $e')),
      );
    }
  }

  void _delete() async {
    if (widget.airplane == null) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this airplane?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
        ],
      ),
    );

    if (shouldDelete ?? false) {
      try {
        final database = await AppDatabase.getInstance();
        final dao = database.airplaneDao;
        await dao.deleteAirplane(widget.airplane!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Airplane Deleted')),
        );

        Navigator.popUntil(context, ModalRoute.withName('/airplanes')); // Go back to the airplane page
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting airplane: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.isEditMode ? 'Edit Airplane' : 'Add Airplane',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
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
                  onPressed: _save,
                  child: Text(widget.isEditMode ? 'Update' : 'Save'),
                ),
                if (widget.isEditMode)
                  ElevatedButton(
                    onPressed: _delete,
                    child: const Text('Delete'),
                  ),
                ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/airplanes')),
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
