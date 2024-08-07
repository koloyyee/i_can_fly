import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import '../../entity/airplane.dart';
import '../../utils/app_localizations.dart';

/// This page allows users to manage Airplane Information
///
/// This page allows users to manage (add or edit) airplane details.
/// It includes text fields for entering airplane attributes and buttons to save, delete, or cancel.
/// If editing an existing airplane, the page will pre-fill the fields with the airplane's data.
///
/// Author: Kyla Pineda
/// Date: August 4, 2024

class ManageAirplanePage extends StatefulWidget {
  final Airplane? airplane;
  final bool isEditMode;

  const ManageAirplanePage({
    Key? key,
    required this.airplane,
    required this.isEditMode,
  }) : super(key: key);

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
    _loadFromPreferences();
  }

  @override
  void dispose() {
    _saveToPreferences();
    _typeController.dispose();
    _capacityController.dispose();
    _maxSpeedController.dispose();
    _maxRangeController.dispose();
    super.dispose();
  }

  /// Saves the current airplane type to encrypted shared preferences.
  ///
  /// This method uses the `EncryptedSharedPreferences` to securely store
  /// the value of the airplane type entered in the `_typeController` text field.
  /// The value is stored with the key 'airplane_type' asynchronously.
  void _saveToPreferences() async {
    final prefs = EncryptedSharedPreferences();
    await prefs.setString('airplane_type', _typeController.text);
  }

  /// Loads the airplane type from encrypted shared preferences and updates the text field.
  ///
  /// This method retrieves the value of 'airplane_type' from the `EncryptedSharedPreferences`.
  /// If a value is found, it updates the `_typeController` text field with the retrieved value.
  /// The value is loaded and set asynchronously.
  void _loadFromPreferences() async {
    final prefs = EncryptedSharedPreferences();
    final airplaneType = await prefs.getString('airplane_type');
      setState(() {
        _typeController.text = airplaneType;
      });
  }

  /// Saves the airplane details to the database.
  /// Shows a SnackBar notification on success or failure.
  /// If editing an existing airplane, updates it; otherwise, creates a new record.
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
          SnackBar(content: Text(appLocalizations.translate('airplane_updated'))),
        );
      } else {
        await dao.createAirplane(airplane);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.translate('airplane_created'))),
        );
      }

      Navigator.popUntil(context, ModalRoute.withName('/airplanes')); // Go back to airplane list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving airplane: $e')),
      );
    }
  }

  /// Deletes the current airplane and shows a confirmation dialog.
  /// If the user confirms, the airplane is deleted, and the user is navigated back to the airplane page.
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

        Navigator.popUntil(context, ModalRoute.withName('/airplanes')); // Go back to airplane list
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.translate('error_deleting_airplane')}: $e')),
        );
      }
    }
  }

  /// Builds the UI for managing airplane details.
  /// Displays text fields for airplane attributes and buttons for save, delete (if editing), and cancel.
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
