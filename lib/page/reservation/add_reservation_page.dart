import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/reservation_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/entity/reservation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddReservationPage extends StatefulWidget {
  @override
  _AddReservationPageState createState() => _AddReservationPageState();
}

class _AddReservationPageState extends State<AddReservationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reservationNameController = TextEditingController();
  late ReservationDao reservationDao;

  List<Customer> customers = [];
  List<Flight> flights = [];
  Customer? selectedCustomer;
  Flight? selectedFlight;
  DateTime? departureDate;
  DateTime? arrivalDate;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = await AppDatabase.getInstance();
    reservationDao = db.reservationDao;
    customers = await db.customerDao.findAllCustomers();
    flights = await db.flightDao.findAllFlights();
    setState(() {});
  }

  @override
  void dispose() {
    _reservationNameController.dispose();
    super.dispose();
  }

  void _addReservation() async {
    if (_formKey.currentState!.validate()) {
      if (selectedCustomer == null || selectedFlight == null) {
        Fluttertoast.showToast(
            msg: "Please ensure both a customer and a flight are selected.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }

      Reservation newReservation = Reservation(
        customerId: selectedCustomer!.id,
        flightId: selectedFlight!.id,
        customerName: selectedCustomer!.name,
        departureCity: selectedFlight!.departureCity,
        arrivalCity: selectedFlight!.arrivalCity,
        departureDateTime: selectedFlight!.departureDateTime,
        arrivalDateTime: selectedFlight!.arrivalDateTime,
        reservationName: _reservationNameController.text,
      );

      await reservationDao.createReservation(newReservation);
      Fluttertoast.showToast(msg: 'Reservation added successfully');
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Reservation"),
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            DropdownButtonFormField<Customer>(
              value: selectedCustomer,
              onChanged: (Customer? newValue) {
                setState(() {
                  selectedCustomer = newValue;
                });
              },
              items: customers.map<DropdownMenuItem<Customer>>((Customer customer) {
                return DropdownMenuItem<Customer>(
                  value: customer,
                  child: Text(customer.name),
                );
              }).toList(),
              validator: (value) => value == null ? 'Please select a customer' : null,
              decoration: InputDecoration(labelText: 'Select Customer'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<Flight>(
              value: selectedFlight,
              onChanged: (Flight? newValue) {
                setState(() {
                  selectedFlight = newValue;
                });
              },
              items: flights.map<DropdownMenuItem<Flight>>((Flight flight) {
                return DropdownMenuItem<Flight>(
                  value: flight,
                  child: Text("${flight.departureCity} to ${flight.arrivalCity}"),
                );
              }).toList(),
              validator: (value) => value == null ? 'Please select a flight' : null,
              decoration: InputDecoration(labelText: 'Select Flight'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _reservationNameController,
              decoration: InputDecoration(labelText: 'Reservation Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a reservation name';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addReservation,
              child: Text('Add Reservation'),
            ),
          ],
        ),
      ),
    );
  }
}
