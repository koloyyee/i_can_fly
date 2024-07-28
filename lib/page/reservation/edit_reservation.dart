import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight-dao.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/entity/flight.dart';

/// A StatefulWidget that provides a form to edit an existing flight reservation.
///
/// This widget interacts with a FlightDao to update the flight details in the database.
class EditReservationPage extends StatefulWidget {
  /// The Flight instance that needs to be edited.
  final Flight flight;

  /// The FlightDao instance for performing database operations.
  final FlightDao flightDao;

  /// Creates an instance of EditReservationPage.
  ///
  /// The [flight] and [flightDao] parameters are required.
  EditReservationPage({Key? key, required this.flight, required this.flightDao}) : super(key: key);

  @override
  _EditReservationPageState createState() => _EditReservationPageState();
}

class _EditReservationPageState extends State<EditReservationPage> {
  late TextEditingController _departureCityController;
  late TextEditingController _arrivalCityController;
  late TextEditingController _airplaneTypeController;
  DateTime? _departureDateTime;
  DateTime? _arrivalDateTime;

  @override
  void initState() {
    super.initState();
    _departureCityController = TextEditingController(text: widget.flight.departureCity);
    _arrivalCityController = TextEditingController(text: widget.flight.arrivalCity);
    _airplaneTypeController = TextEditingController(text: widget.flight.airplaneType ?? '');
    _departureDateTime = widget.flight.departureDateTime;
    _arrivalDateTime = widget.flight.arrivalDateTime;
  }

  /// Updates the flight in the database with the new details.
  ///
  /// This method creates an updated Flight object and saves it to the database
  /// using FlightDao. After the flight is successfully updated, the current screen
  /// is popped from the navigation stack.
  void _updateFlight() async {
    Flight updatedFlight = Flight(
      id: widget.flight.id,  // Keep the original ID
      airplaneType: _airplaneTypeController.text,
      departureCity: _departureCityController.text,
      arrivalCity: _arrivalCityController.text,
      departureDateTime: _departureDateTime!,
      arrivalDateTime: _arrivalDateTime!,
    );

    await widget.flightDao.updateFlight(updatedFlight);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Flight Reservation"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _departureCityController,
              decoration: InputDecoration(labelText: 'Departure City'),
            ),
            TextField(
              controller: _arrivalCityController,
              decoration: InputDecoration(labelText: 'Arrival City'),
            ),
            TextField(
              controller: _airplaneTypeController,
              decoration: InputDecoration(labelText: 'Airplane Type'),
            ),
            // Buttons for date picking and saving
            ElevatedButton(
              onPressed: _updateFlight,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}