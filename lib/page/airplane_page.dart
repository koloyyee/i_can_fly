import 'package:flutter/material.dart';
import 'airplane/view_airplanes_list.dart';
import 'package:i_can_fly/utils/theme-color.dart';

import '../entity/airplane.dart';

/**
 * AirplanePage displays a list of airplanes and allows navigation to the ManageAirplanePage
 * for adding or editing airplane details.
 */
class AirplanePage extends StatefulWidget {
  const AirplanePage({super.key});

  @override
  State<AirplanesPage> createState() => _AirplanesPageState();
}

class _AirplanePageState extends State<AirplanePage> {
  late Future<List<Airplane>> _airplanes;
  Airplane? _selectedAirplane;

  @override
  void initState() {
    super.initState();
    _airplanes = _loadAirplanes();
  }

  Future<List<Airplane>> _loadAirplanes() async {
    try {
      final database = await AppDatabase.getInstance();
      final dao = database.airplaneDao;
      return await dao.findAllAirplanes();
    } catch (e) {
      // Print or log the error for debugging
      print("Error loading airplanes: $e");
      return [];
    }
  }

  void _navigateToManagePage(BuildContext context, [Airplane? airplane]) {
    if (MediaQuery.of(context).orientation == Orientation.landscape &&
        MediaQuery.of(context).size.width > 720) {
      setState(() {
        _selectedAirplane = airplane;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManageAirplanePage(
            airplane: airplane,
            isEditMode: airplane != null,
          ),
        ),
      );
    }
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(flex: 1, child: _buildAirplaneList()),
        if (_selectedAirplane != null)
          Expanded(
            flex: 2,
            child: ManageAirplanePage(
              airplane: _selectedAirplane,
              isEditMode: true,
            ),
          ),
      ],
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
                onTap: () => _navigateToManagePage(context, airplane),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(CTColor.DarkTeal.colorValue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.airplane_ticket, color: Colors.white),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          '${airplane.type}    ${airplane.capacity} Passengers',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ],
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "See All Your Airplanes Here!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(CTColor.Teal.colorValue),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape &&
              MediaQuery.of(context).size.width > 720) {
            return _buildLandscapeLayout();
          } else {
            return _buildAirplaneList();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToManagePage(context),
        child: const Icon(Icons.add),
        backgroundColor: Color(CTColor.Teal.colorValue),
      ),
    );
  }
}
