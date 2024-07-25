import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight-dao.dart';
import 'package:i_can_fly/entity/flight.dart';

class EditReservationPage extends StatefulWidget {
  final Flight flight;
  final FlightDao flightDao;

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
