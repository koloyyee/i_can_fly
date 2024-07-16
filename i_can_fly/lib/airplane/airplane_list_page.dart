import 'package:flutter/material.dart';
import 'add_airplane_page.dart';
import 'database_helper.dart';
import 'airplane_detail_page.dart';


class AirplaneListPage extends StatefulWidget {
  const AirplaneListPage({super.key});

  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  List<Airplane> _airplanes = [];

  @override
  void initState() {
    super.initState();
    _loadAirplanes();
  }

  _loadAirplanes() async {
    List<Airplane> airplanes = await DatabaseHelper.instance.getAirplanes();
    setState(() {
      _airplanes = airplanes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane List'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Instructions'),
                  content: Text('Instructions for using the interface.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _airplanes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_airplanes[index].type),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AirplaneDetailPage(airplane: _airplanes[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAirplanePage()),
          ).then((value) {
            if (value != null) {
              _loadAirplanes();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
