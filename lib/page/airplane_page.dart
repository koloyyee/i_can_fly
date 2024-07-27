import 'package:flutter/material.dart';
import 'airplane/view_airplanes_list.dart';
import 'package:i_can_fly/utils/theme-color.dart';

import '../entity/airplane.dart';

/**
 * AirplanePage is a stateful widget that displays a list of airplanes.
 * Users can view the list of airplanes, and add or edit airplane details.
 */
class AirplanePage extends StatefulWidget {
  const AirplanePage({super.key});

  @override
  State<AirplanesPage> createState() => _AirplanesPageState();
}

class _AirplanePageState extends State<AirplanePage> {
  late Future<List<Airplane>> _airplanes; // Future that will hold the list of airplanes

  @override
  void initState() {
    super.initState();
    _airplanes = _loadAirplanes(); // Load airplanes when the widget initializes
  }

  /**
   * Loads the list of airplanes from the database.
   *
   * @return A Future that resolves to a list of Airplane objects.
   */
  Future<List<Airplane>> _loadAirplanes() async {
    try {
      final database = await AppDatabase.getInstance();
      final dao = database.airplaneDao;
      return await dao.findAllAirplanes(); // Retrieve all airplanes from the DAO
    } catch (e) {
      // Print or log the error for debugging
      print("Error loading airplanes: $e");
      return []; // Return an empty list in case of an error
    }
  }

  /**
   * Navigates to the ManageAirplanePage to add or edit an airplane.
   *
   * @param context The build context.
   * @param airplane The airplane to be edited (null if adding a new airplane).
   */
  void _navigateToManagePage(BuildContext context, [Airplane? airplane]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageAirplanePage(
          airplane: airplane,
          isEditMode: airplane != null, // Determine if the page is in edit mode
        ),
      ),
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
        backgroundColor: Color(CTColor.Teal.colorValue), // Set the AppBar color
      ),
      body: FutureBuilder<List<Airplane>>(
        future: _airplanes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator while waiting
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error message if an error occurs
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No airplanes found.')); // Show message if no airplanes are found
          } else {
            final airplanes = snapshot.data!;
            return ListView.builder(
              itemCount: airplanes.length,
              itemBuilder: (context, index) {
                final airplane = airplanes[index];
                return GestureDetector(
                  onTap: () => _navigateToManagePage(context, airplane), // Navigate to edit airplane on tap
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
                            '${airplane.type}    ${airplane.capacity} Passengers', // Display airplane type and capacity
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
        onPressed: () => _navigateToManagePage(context), // Navigate to add airplane on button press
        child: const Icon(Icons.add),
        backgroundColor: Color(CTColor.Teal.colorValue), // Set the FAB color
      ),
    );
  }
}
