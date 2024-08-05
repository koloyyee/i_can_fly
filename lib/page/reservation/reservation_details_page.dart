import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/reservation.dart';

class ReservationDetailsPage extends StatelessWidget {
  final Reservation reservation;

  const ReservationDetailsPage({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Customer Name: ${reservation.customerName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Departure City: ${reservation.departureCity}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Arrival City: ${reservation.arrivalCity}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Departure Date and Time: ${reservation.departureDateTime}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),

            Text('Arrival Date and Time: ${reservation.arrivalDateTime}', style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 8),
            Text('Reservation Name: ${reservation.reservationName}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
