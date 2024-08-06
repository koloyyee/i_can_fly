import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/reservation.dart';
import 'package:intl/intl.dart'; // Import DateFormat

class ReservationDetailsPage extends StatelessWidget {
  final Reservation reservation;
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd HH:mm'); // For formatting dates

   ReservationDetailsPage({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView( // Changed to ListView for better scrolling
          children: <Widget>[
            Card( // Wrap in Card for better UI
              child: ListTile(
                leading: Icon(Icons.account_circle, size: 56), // Example icon
                title: Text('Customer Name: ${reservation.customerName}', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Reservation Name: ${reservation.reservationName}'),
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.flight_takeoff, size: 56),
                title: Text('Departure City: ${reservation.departureCity}'),
                subtitle: Text('Departure Date and Time: ${dateFormatter.format(reservation.departureDateTime)}'),
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.flight_land, size: 56),
                title: Text('Arrival City: ${reservation.arrivalCity}'),
                subtitle: Text('Arrival Date and Time: ${dateFormatter.format(reservation.arrivalDateTime)}'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back to List'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
