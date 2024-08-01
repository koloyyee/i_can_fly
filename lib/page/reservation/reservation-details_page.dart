import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/reservation.dart';

class ReservationDetailsPage extends StatelessWidget {
  final Reservation reservation;

  const ReservationDetailsPage({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Customer Name: ${reservation.customerName}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Departure City: ${reservation.departureCity}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Arrival City: ${reservation.destinationCity}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Departure Date and Time: ${reservation.departureTime}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Arrival Date and Time: ${reservation.arrivalTime}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Reservation Name: ${reservation.reservationName}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back to List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
