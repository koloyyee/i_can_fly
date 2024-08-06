import 'package:flutter/material.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/entity/reservation.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddReservationPage extends StatefulWidget {
  const AddReservationPage({super.key});

  @override
  _AddReservationPageState createState() => _AddReservationPageState();
}

class _AddReservationPageState extends State<AddReservationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reservationNameController = TextEditingController();

  List<Customer> customers = [];
  List<Flight> flights = [];
  List<Reservation> reservations =[];
  Customer? selectedCustomer;
  Flight? selectedFlight;
  Reservation? selectedReservation;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = await AppDatabase.getInstance();
    customers = await db.customerDao.findAllCustomers();
    flights = await db.flightDao.findAllFlights();
    reservations = await db.reservationDao.findAllReservations();
    setState(() {});
  }

  @override
  void dispose() {
    _reservationNameController.dispose();
    super.dispose();
  }

  void _addReservation() async {
    if (_formKey.currentState!.validate()) {
      Reservation newReservation = Reservation(
        customerName: selectedReservation!.customerName!,
        departureCity: selectedReservation!.departureCity,
        arrivalCity: selectedReservation!.arrivalCity,
        departureDateTime: selectedReservation!.departureDateTime,
        arrivalDateTime: selectedReservation!.arrivalDateTime,
        reservationName: _reservationNameController.text,
        customerId: selectedReservation!.customerId!,
        flightId: selectedReservation!.flightId!,
      );

      final db = await AppDatabase.getInstance();
      await db.reservationDao.createReservation(newReservation);
      Fluttertoast.showToast(msg: 'Reservation added successfully');
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Reservation"),
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            DropdownButtonFormField<Reservation>(
              value: selectedReservation,
              onChanged: (Reservation? newValue) {
                setState(() {
                  selectedReservation = newValue;
                });
              },
              items: reservations.map<DropdownMenuItem<Reservation>>((Reservation reservation) {
                return DropdownMenuItem<Reservation>(
                  value: reservation,
                  child: Text("${reservation.customerName}"),
                );
              }).toList(),
              validator: (value) => value == null ? 'Please select a customer' : null,
              decoration: const InputDecoration(labelText: 'Select Customer'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<Reservation>(
              value: selectedReservation,
              onChanged: (Reservation? newValue) {
                setState(() {
                  selectedReservation = newValue;
                });
              },
              items: reservations.map<DropdownMenuItem<Reservation>>((Reservation reservation) {
                return DropdownMenuItem<Reservation>(
                  value: reservation,
                  child: Text("${reservation.departureCity} to ${reservation.arrivalCity}"),
                );
              }).toList(),
              validator: (value) => value == null ? 'Please select a flight' : null,
              decoration: const InputDecoration(labelText: 'Select Flight'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _reservationNameController,
              decoration: const InputDecoration(labelText: 'Reservation Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a reservation name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addReservation,
              child: const Text('Add Reservation'),
            ),
          ],
        ),
      ),
    );
  }
}