import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/page/airplane/orientation_widget.dart';
import 'package:i_can_fly/page/flight/edit_flight_page.dart';
import 'package:intl/intl.dart';

/// A StatefulWidget that represents the list of flights.
/// Instance of [FlightDao] for accessing the flight table.
/// A list of [Flight] objects to store the flights.
/// A method to fetch the flights from the database.
/// A method to delete a flight from the database.
class ViewFlightsList extends StatefulWidget {
  const ViewFlightsList({
    super.key,
  });

  @override
  State<ViewFlightsList> createState() => _ViewFlightsListState();
}

class _ViewFlightsListState extends State<ViewFlightsList> {
  List<Flight> flights = [];

  late FlightDao flightDao;
  Flight? selectedFlight;

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  void fetchFlights() {
    AppDatabase.getInstance().then((db) {
      flightDao = db.flightDao;
      flightDao
          .findAllFlights()
          .then((flights) => setState(() => this.flights = flights));
    });
  }

  void deleteFlight(BuildContext context, Flight flight) async {
    await flightDao.deleteFlight(flight);
    flightDao.findAllFlights().then((flights) {
      setState(() {
        this.flights = flights;
      });
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('yy-MM-dd – kk:mm');
    fetchFlights();
    return flights.isEmpty
        ? Center(
            child: Column(
            children: [
              Image.asset(
                "images/shrink_kitty.png",
                width: 360,
                height: 360,
              ),
              const Text(
                "No flights found :(",
                style: TextStyle(fontSize: 36),
              ),
            ],
          ))
        : OrientationWidget(
            portraitChild: ListView(
// 2.[x ] There must be a TextField along with a button that lets the user insert items into the ListView.
              children: [
                Image.asset(
                  "images/gliding_kitty.png",
                  width: 120,
                  height: 120,
                ),
                for (var flight in flights)
                  flightDetailGesture(context, flight, formatter)
              ],
            ),
            landscapeChild: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: flights.length,
                    itemBuilder: (context, index) {
                      final flight = flights[index];
                      return flightDetailGesture(context, flight, formatter);
                    },
                  ),
                ),
                if (selectedFlight != null)
                  Expanded(
                    child: FlightDetails(
                      flight: selectedFlight!,
                      formatter: formatter,
                      flights: flights,
                    ),
                  ),
              ],
            ),
          );
  }

  GestureDetector flightDetailGesture(
    BuildContext context,
    Flight flight,
    DateFormat formatter,
  ) {
    return GestureDetector(
      onLongPress: () {
        var isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;
        if (isPortrait) {
          flightDetailsSheet(context, flight, formatter);
        } else {
          setState(() {
            selectedFlight = flight;
          });
        }
      },
      child: ListTile(
        title: Text("🛫${flight.departureCity} ➡️ 🛬${flight.arrivalCity}"),
        subtitle: Text(
            "${formatter.format(flight.departureDateTime)} ➡️ ${formatter.format(flight.arrivalDateTime)}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeleteAlertDialog(
                      flight: flight, deleteFlight: deleteFlight);
                });
          },
        ),
      ),
    );
  }

  PersistentBottomSheetController flightDetailsSheet(
      BuildContext context, Flight flight, DateFormat formatter) {
    return showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return FlightDetails(
              flight: flight, formatter: formatter, flights: flights);
        });
  }
}

class ViewLandscapeFlightsList extends StatefulWidget {
  const ViewLandscapeFlightsList({super.key});

  @override
  State<ViewLandscapeFlightsList> createState() =>
      _ViewLandscapeFlightsListState();
}

class _ViewLandscapeFlightsListState extends State<ViewLandscapeFlightsList> {
  List<Flight> flights = [];

  late FlightDao flightDao;

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  void fetchFlights() {
    AppDatabase.getInstance().then((db) {
      flightDao = db.flightDao;
      flightDao
          .findAllFlights()
          .then((flights) => setState(() => this.flights = flights));
    });
  }

  void deleteFlight(BuildContext context, Flight flight) async {
    await flightDao.deleteFlight(flight);
    flightDao.findAllFlights().then((flights) {
      setState(() {
        this.flights = flights;
      });
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class FlightDetails extends StatelessWidget {
  const FlightDetails({
    super.key,
    required this.flight,
    required this.formatter,
    required this.flights,
  });

  final Flight flight;
  final DateFormat formatter;
  final List<Flight> flights;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          ListTile(
            title: Text("Departure City: ${flight.departureCity}"),
          ),
          ListTile(
            title: Text("Arrival City: ${flight.arrivalCity}"),
          ),
          ListTile(
            title: Text(
                "Departure Date: ${formatter.format(flight.departureDateTime)}"),
          ),
          ListTile(
            title: Text(
                "Arrival Date: ${formatter.format(flight.arrivalDateTime)}"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditFlightPage(
                            flight: flight,
                            flights: flights,
                          ))).then((_) {
                Navigator.pop(context);
              });
            },
            child: const Text("Edit Flight"),
          )
        ],
      ),
    );
  }
}

class DeleteAlertDialog extends StatelessWidget {
  DeleteAlertDialog(
      {super.key, required this.flight, required this.deleteFlight});

  final Flight flight;
  Function(BuildContext context, Flight flight) deleteFlight;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Flight"),
      content: Text(
          "Are you sure you want to delete the flight from ${flight.departureCity} to ${flight.arrivalCity}?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            deleteFlight(context, flight);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
