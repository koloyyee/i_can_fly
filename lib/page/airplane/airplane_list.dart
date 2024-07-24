import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/page/airplane/airplane_details.dart';
import 'package:i_can_fly/entity/airplane.dart';

class AirplaneListPage extends StatefulWidget {
  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  late Future<List<Airplane>> _airplanes;

  @override
  void initState() {
    super.initState();
    _airplanes = _fetchAirplanes();
  }

  Future<List<Airplane>> _fetchAirplanes() async {
    final db = await AppDatabase.getInstance();
    return await db.airplaneDao.findAllAirplanes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Airplane List')),
      body: FutureBuilder<List<Airplane>>(
        future: _airplanes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No airplanes found.'));
          }

          final airplanes = snapshot.data!;
          return ListView.builder(
            itemCount: airplanes.length,
            itemBuilder: (context, index) {
              final airplane = airplanes[index];
              return ListTile(
                title: Text(airplane.type),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AirplaneDetailsPage(airplane: airplane),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
