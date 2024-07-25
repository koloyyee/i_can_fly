import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight-dao.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/page/reservation/edit_reservation.dart';
import 'package:i_can_fly/page/reservation/reservation_details.dart';
import 'package:i_can_fly/page/reservation/add_reservation.dart';
import 'package:i_can_fly/utils/theme-color.dart';

class ReservationListPage extends StatefulWidget {
  final FlightDao flightDao;

  ReservationListPage({Key? key, required this.flightDao}) : super(key: key);

  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  late Future<List<Flight>> _flights;

  @override
  void initState() {
    super.initState();
    _flights = widget.flightDao.findAllFlights(); // Assuming this method fetches all flights
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Reservations"),
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
                  title: Text("Flight to ${flight.arrivalCity} from ${flight.departureCity}"),
                  subtitle: Text("Departure at ${flight.departureDateTime}"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ReservationDetailsPage(flight: flight),
                    ));
                  },
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddReservationPage(flightDao: widget.flightDao), // Adjust according to how you handle flight creation
          ));
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Flight',
      ),
    );
  }
}
