import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/airplane/manage_airplane.dart';
import 'package:i_can_fly/utils/theme-color.dart';
import '../../entity/airplane.dart';
import 'orientation_widget.dart';

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
      setState(() {
        selectedAirplane = null;
      });
      _loadAirplanes(); // Refresh the list
    });
  }

  void _deleteAirplane(BuildContext context, Airplane airplane) async {
    final database = await AppDatabase.getInstance();
    await database.airplaneDao.deleteAirplane(airplane);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Airplane deleted'),
      ),
    );

    _loadAirplanes();
  }

  void _showInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Instructions'),
        content: const Text(
          '1. Tap on an airplane to edit its details.\n'
              '2. Long press on an airplane to delete it.\n'
              '3. Use the floating action button to add a new airplane.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildAirplaneList() {
    return FutureBuilder<List<Airplane>>(
      future: _airplanes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No airplanes found.'));
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
                  child: ListTile(
                    title: Text(airplane.type),
                    subtitle: Text('Capacity: ${airplane.capacity}'),
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
    return OrientationWidget(
      portraitChild: Scaffold(
        appBar: AppBar(
          title: const Text('Airplanes'),
          backgroundColor: Color(CTColor.Teal.colorValue),
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () => _showInstructions(context),
            ),
          ],
        ),
        body: _buildAirplaneList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToManagePage(context),
          child: const Icon(Icons.add),
          backgroundColor: Color(CTColor.Teal.colorValue),
        ),
      ),
      landscapeChild: Scaffold(
        appBar: AppBar(
          title: const Text('Airplanes'),
          backgroundColor: Color(CTColor.Teal.colorValue),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 2, // Adjust the width of the list
              child: _buildAirplaneList(),
            ),
            if (selectedAirplane != null)
              Expanded(
                flex: 3, // Adjust the width of the details page
                child: ManageAirplanePage(
                  airplane: selectedAirplane,
                  isEditMode: true,
                ),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToManagePage(context),
          child: const Icon(Icons.add),
          backgroundColor: Color(CTColor.Teal.colorValue),
        ),
      ),
    );
  }
}
