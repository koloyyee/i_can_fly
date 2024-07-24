import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/airplane/manage_airplane.dart';
import 'package:i_can_fly/utils/theme-color.dart';

import '../entity/airplane.dart';

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
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
      ),

        floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToManagePage(context),
        child: const Icon(Icons.add),
        backgroundColor: Color(CTColor.Teal.colorValue),
      ),
    );
  }
}
