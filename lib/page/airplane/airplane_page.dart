import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/airplane/manage_airplane.dart';
import 'package:i_can_fly/page/airplane/orientation_widget.dart';
import 'package:i_can_fly/utils/theme_color.dart';
import '../../common/common_actions_menu.dart';
import '../../entity/airplane.dart';
import '../../utils/app_localizations.dart';

class AirplanePage extends StatefulWidget {
  const AirplanePage({super.key});

  @override
  _AirplanePageState createState() => _AirplanePageState();
}

class _AirplanePageState extends State<AirplanePage> {
  late Future<List<Airplane>> _airplanes;
  Airplane? selectedAirplane;

  @override
  void initState() {
    super.initState();
    _loadAirplanes();
  }

  Future<void> _loadAirplanes() async {
    final database = await AppDatabase.getInstance();
    final airplanes = await database.airplaneDao.findAllAirplanes();
    setState(() {
      _airplanes = Future.value(airplanes);
    });
  }

  void _navigateToManagePage(BuildContext context, [Airplane? airplane]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageAirplanePage(
          airplane: airplane,
          isEditMode: airplane != null,
        ),
      ),
    ).then((_) {
      // Reset selected airplane and reload airplanes
      setState(() {
        selectedAirplane = null;
      });
      _loadAirplanes(); // Refresh the list
    });
  }

  void _deleteAirplane(BuildContext context, Airplane airplane) async {
    final database = await AppDatabase.getInstance();
    await database.airplaneDao.deleteAirplane(airplane);
    final appLocalizations = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(appLocalizations.translate('airplane_deleted')),
      ),
    );

    // Refresh the list after deletion
    setState(() {
      _loadAirplanes(); // Refresh the list
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        selectedAirplane = null; // Reset selection in landscape mode
      }
    });
  }

  void _showInstructions(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.translate('instructions')),
        content: Text(
          '${appLocalizations.translate('instructions_step_1')}\n'
              '    ${appLocalizations.translate('instructions_step_1a')}\n'
              '    ${appLocalizations.translate('instructions_step_1b')}\n'
              '${appLocalizations.translate('instructions_step_2')}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(appLocalizations.translate('ok')),
          ),
        ],
      ),
    );
  }


  Widget _buildAirplaneList() {
    final appLocalizations = AppLocalizations.of(context)!;

    return FutureBuilder<List<Airplane>>(
      future: _airplanes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(appLocalizations.translate('no_airplanes_found')));
        } else {
          final airplanes = snapshot.data!;
          return ListView.builder(
            itemCount: airplanes.length,
            itemBuilder: (context, index) {
              final airplane = airplanes[index];
              return GestureDetector(
                onTap: () {
                  if (MediaQuery.of(context).orientation == Orientation.landscape) {
                    setState(() {
                      selectedAirplane = airplane;
                    });
                  } else {
                    _navigateToManagePage(context, airplane);
                  }
                },
                onLongPress: () => _deleteAirplane(context, airplane),
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Color(CTColor.LightTeal.colorValue), // Set card color here
                  child: ListTile(
                    leading: Icon(Icons.airplane_ticket, color: Color(CTColor.Teal.colorValue)), // Add icon here
                    title: Text(airplane.type),
                    subtitle: Text('${AppLocalizations.of(context)!.translate('capacity')}: ${airplane.capacity}'),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return OrientationWidget(
      portraitChild: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.translate('airplanes')),
          backgroundColor: Color(CTColor.Teal.colorValue),
          actions: [
            CommonActionsMenu(
              additionalItems: [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () => _showInstructions(context),
                    child: Text(appLocalizations.translate('instructions')),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: _buildAirplaneList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToManagePage(context),
          backgroundColor: Color(CTColor.LightTeal.colorValue),
          child: const Icon(Icons.add),
        ),
      ),
      landscapeChild: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.translate('airplanes')),
          backgroundColor: Color(CTColor.Teal.colorValue),
          actions: [
            CommonActionsMenu(
              additionalItems: [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () => _showInstructions(context),
                    child: Text(appLocalizations.translate('instructions')),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildAirplaneList(),
            ),
            if (selectedAirplane != null)
              Expanded(
                flex: 3,
                child: ManageAirplanePage(
                  airplane: selectedAirplane,
                  isEditMode: true,
                ),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToManagePage(context),
          backgroundColor: Color(CTColor.LightTeal.colorValue),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
