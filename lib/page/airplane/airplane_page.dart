import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/airplane/manage_airplane.dart';
import 'package:i_can_fly/utils/theme_color.dart';
import '../../common/common_actions_menu.dart';
import '../../entity/airplane.dart';
import '../../utils/app_localizations.dart';

/// Author: Kyla Pineda
/// Date: August 4, 2024
///
/// This page shows a list of airplanes and allows users to view, edit, or delete airplane records.
/// The layout adapts to both portrait and landscape orientations.

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

  /// [2]
  /// Loads the list of airplanes from the database and updates the state.
  /// Called when the state is initialized.
  Future<void> _loadAirplanes() async {
    final database = await AppDatabase.getInstance();
    final airplanes = await database.airplaneDao.findAllAirplanes();
    setState(() {
      _airplanes = Future.value(airplanes);
    });
  }

  /// [3]
  /// Navigates to the ManageAirplanePage to either add or edit an airplane.
  /// If an airplane is provided, it enters edit mode; otherwise, it enters add mode.
  /// After returning from the ManageAirplanePage, it resets the selected airplane and reloads the list.
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
      _loadAirplanes();
    });
  }

  /// [4]
  /// Deletes the selected airplane and shows a SnackBar notification.
  /// If the airplane is deleted successfully, it also refreshes the list and resets the selection in landscape mode.
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

  /// [5]
  /// Shows an AlertDialog with instructions for using the interface.
  /// The instructions are localized using AppLocalizations.
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

  /// [6]
  /// Builds the list of airplanes displayed on the page.
  /// Uses a FutureBuilder to asynchronously load and display the list.
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
              final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

              return GestureDetector(
                onTap: () {
                  if (isLandscape) {
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
                  color: Color(CTColor.LightTeal.colorValue),
                  child: ListTile(
                    leading: Icon(Icons.airplane_ticket, color: Color(CTColor.Teal.colorValue)),
                    title: Text(airplane.type),
                    subtitle: Text('${appLocalizations.translate('capacity')}: ${airplane.capacity}'),
                    trailing: isLandscape
                        ? IconButton(
                      icon: Icon(Icons.edit, color: Color(CTColor.Teal.colorValue)),
                      onPressed: () {
                        _navigateToManagePage(context, airplane);
                      },
                    )
                        : null, // Hide pencil icon in portrait mode
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  /// [7]
  /// Builds the details page for the selected airplane.
  /// If no airplane is selected, returns an empty container.
  Widget DetailsPage() {
    final appLocalizations = AppLocalizations.of(context)!;
    if (selectedAirplane == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " ${selectedAirplane!.type}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text("${appLocalizations.translate('capacity')}: ${selectedAirplane!.capacity}"),
            Text("${appLocalizations.translate('max_speed')}: ${selectedAirplane!.maxSpeed}"),
            Text("${appLocalizations.translate('max_range')}: ${selectedAirplane!.maxRange}"),
            const SizedBox(height: 20), // Space between details and button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedAirplane = null; // Hide details page
                  });
                },
                child: Text(appLocalizations.translate('ok')),
              ),
            ),
          ],
        ),
      );
    }
  }

  /// [8]
  /// Builds the responsive layout for the page based on device orientation.
  /// Shows the details page beside the list in landscape mode or as a full screen in portrait mode.
  Widget responsiveLayout() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var isLandscape = width > MediaQuery.of(context).size.height;

    if (isLandscape) {
      return Row(
        children: [
          Expanded(
            flex: selectedAirplane != null ? 3 : 1,
            child: _buildAirplaneList(),
          ),
          if (selectedAirplane != null)
            Expanded(
              flex: 1,
              child: DetailsPage(),
            ),
        ],
      );
    } else {
      return _buildAirplaneList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
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
      body: responsiveLayout(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToManagePage(context),
        backgroundColor: Color(CTColor.LightTeal.colorValue),
        child: const Icon(Icons.add),
      ),
    );
  }
}
