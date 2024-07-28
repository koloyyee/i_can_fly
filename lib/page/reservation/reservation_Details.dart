import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/flight.dart';

/// A StatelessWidget that displays the details of a flight reservation.
///
/// This widget shows the flight's departure and arrival cities, and the departure time.
/// It also provides a button to delete the flight reservation.
class ReservationDetailsPage extends StatelessWidget {
  /// The Flight instance whose details are displayed.
  final Flight flight;

  /// Creates an instance of ReservationDetailsPage.
  ///
  /// The [flight] parameter is required.
  ReservationDetailsPage({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Details"),
      ),
      body: Column(
        children: <Widget>[
          Text("Flight to ${flight.arrivalCity} from ${flight.departureCity}"),
          Text("Departure: ${flight.departureDateTime}"),
          ElevatedButton(
            onPressed: () {
              // Implement delete logic
            },
            child: Text('Delete Flight'),
          ),
        ],
      ),
    );
  }
}