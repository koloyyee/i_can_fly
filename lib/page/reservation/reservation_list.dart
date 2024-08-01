import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/page/reservation/reservation_details.dart';
import 'package:i_can_fly/page/reservation/add_reservation.dart';

/// A StatefulWidget that displays a list of flight reservations.
///
/// This widget interacts with a FlightDao to fetch and display flight details.
class ReservationListPage extends StatefulWidget {
  /// The FlightDao instance for performing database operations.
  // final FlightDao flightDao;

  /// Creates an instance of ReservationListPage.
  ///
  /// The [flightDao] parameter is required.
  // const ReservationListPage({super.key, required this.flightDao});
  const ReservationListPage({super.key});

  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  late FlightDao _flightDao;
  late Future<List<Flight>> _flights;

  @override
  void initState() {
    super.initState();
    AppDatabase.getInstance().then((db) {
      _flightDao = db.flightDao;
      _flights = _flightDao.findAllFlights();
    });
    // _flights = widget.flightDao.findAllFlights(); // Assuming this method fetches all flights
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flight Reservations"),
      ),
      body: FutureBuilder<List<Flight>>(
        future: _flights,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Flight flight = snapshot.data![index];
                return ListTile(
                  title: Text(
                      "Flight to ${flight.arrivalCity} from ${flight.departureCity}"),
                  subtitle: Text("Departure at ${flight.departureDateTime}"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReservationDetailsPage(flight: flight),
                        ));
                  },
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddReservationPage(
                    flightDao:
                        _flightDao), // Adjust according to how you handle flight creation
              ));
        },
        tooltip: 'Add New Flight',
        child: const Icon(Icons.add),
      ),
    );
  }
}
