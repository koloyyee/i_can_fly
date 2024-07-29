import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/airplane/manage_airplane.dart';
import 'package:i_can_fly/utils/theme-color.dart';
import '../../entity/airplane.dart';

class AirplanePage extends StatefulWidget {
  const AirplanePage({super.key});

  @override
  _AirplanePageState createState() => _AirplanePageState();
}

class _AirplanePageState extends State<AirplanePage> {
  late Future<List<Airplane>> _airplanes;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Airplanes List",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Color(CTColor.Teal.colorValue),
      ),
      body: FutureBuilder<List<Airplane>>(
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
                  onLongPress: () => _deleteAirplane(context, airplane),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type: ${airplane.type}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('Capacity: ${airplane.capacity} seats'),
                          Text('Max Speed: ${airplane.maxSpeed} km/h'),
                          Text('Max Range: ${airplane.maxRange} km'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
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
