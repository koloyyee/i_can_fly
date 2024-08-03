import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import '../../entity/airplane.dart';
import '../../utils/app_localizations.dart';

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
    final appLocalizations = AppLocalizations.of(context)!;
    if (_typeController.text.isEmpty ||
        _capacityController.text.isEmpty ||
        _maxSpeedController.text.isEmpty ||
        _maxRangeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.translate('fill_all_fields'))),
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
          SnackBar(content: Text(AppLocalizations.of(context)!.translate('airplane_updated'))),
        );
      } else {
        await dao.createAirplane(airplane);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.translate('airplane_created'))),
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
        title: Text(AppLocalizations.of(context)!.translate('confirm_delete')),
        content: Text(AppLocalizations.of(context)!.translate('confirm_delete_message')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.translate('yes')),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.translate('no')),
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
          SnackBar(content: Text(AppLocalizations.of(context)!.translate('airplane_deleted'))),
        );

        Navigator.popUntil(context, ModalRoute.withName('/airplanes')); // Go back to the airplane page
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.translate('error_deleting_airplane')}: $e')),
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
              widget.isEditMode ? AppLocalizations.of(context)!.translate('edit_airplane') : AppLocalizations.of(context)!.translate('add_airplane'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.translate('airplane_type'),
              ),
            ),
            TextField(
              controller: _capacityController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.translate('passenger_capacity'),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxSpeedController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.translate('max_speed'),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _maxRangeController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.translate('max_range'),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _save,
                  child: Text(widget.isEditMode
                      ? AppLocalizations.of(context)!.translate('update')
                      : AppLocalizations.of(context)!.translate('save')),
                ),
                if (widget.isEditMode)
                  ElevatedButton(
                    onPressed: _delete,
                    child: Text(AppLocalizations.of(context)!.translate('delete')),
                  ),
                ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/airplanes')),
                  child: Text(AppLocalizations.of(context)!.translate('cancel')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}