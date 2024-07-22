import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight-dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:intl/intl.dart';

class ViewFlightsList extends StatefulWidget {

  ViewFlightsList({
    super.key,
  });

  @override
  State<ViewFlightsList> createState() => _ViewFlightsListState();
}

class _ViewFlightsListState extends State<ViewFlightsList> {
  List<Flight> flights = [];

  late FlightDao flightDao;

  @override
  void initState() {
    super.initState();
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) {
      flightDao = db.flightDao;
      flightDao.findAllFlights().then((flights) {
        setState(() {
          this.flights = flights;
        });
      });
    });
  }

  // Future<void> deleteFlight(Flight flight) async {
  //   await flightDao.deleteFlight(flight);
  //   flightDao.findAllFlights().then((flights) {
  //     setState(() {
  //       this.flights = flights;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter =  DateFormat('yy-mm-dd – kk:mm');

    return flights.isEmpty ? Center(child: Column(children: [
        Image.asset(
          "images/shrink_kitty.png",
          width: 360,
          height: 360,
        ),
       const Text("No flights found :(", style: TextStyle(fontSize: 36),),
    ],)) :
    
     ListView(
      children: [
        Image.asset(
          "images/gliding_kitty.png",
          width: 120,
          height: 120,
        ),
        for (var flight in flights)
          ListTile(
            title: Text("🛫${flight.departureCity} ➡️ 🛬${flight.arrivalCity}" ),
            subtitle: Text("${ formatter.format(flight.departureDateTime) } ➡️ ${ formatter.format(flight.arrivalDateTime) }"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Delete Flight"),
                    content: Text("Are you sure you want to delete the flight from ${flight.departureCity} to ${flight.arrivalCity}?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          flightDao.deleteFlight(flight);
                          flightDao.findAllFlights().then((flights) {
                            setState(() {
                              this.flights = flights;
                            });
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                });
              },
            ),),
      ],
    );
  }
}
