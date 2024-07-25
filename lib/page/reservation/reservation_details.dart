import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/flight.dart';

class ReservationDetailsPage extends StatelessWidget {
  final Flight flight;

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
