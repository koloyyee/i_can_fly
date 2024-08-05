import 'package:flutter/material.dart';

import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/dao/reservation_dao.dart';
import 'package:i_can_fly/dao/customer_dao.dart';


import 'package:i_can_fly/db/database.dart';


import 'package:i_can_fly/entity/reservation.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/entity/customer.dart';


import 'package:i_can_fly/page/reservation/add_reservation_page.dart';
import 'package:i_can_fly/page/reservation/reservation_details_page.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ReservationListPage extends StatefulWidget {
  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  late ReservationDao reservationDao;

  List<Reservation> reservationList = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    reservationDao = database.reservationDao;

    _fetchReservations();
  }

  Future<void> _fetchReservations() async {
    final reservations = await reservationDao.findAllReservations();
    setState(() {
      reservationList = reservations;
    });
  }

  void _navigateToAddReservationPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddReservationPage()),
    );

    if (result != null && result) {
      // Fetch the updated list
      _fetchReservations();
      Fluttertoast.showToast(msg: 'New reservation added successfully');
    }
  }

  void _navigateToEditReservationPage(Reservation reservation) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservationDetailsPage(reservation: reservation)),
    );

    if (result != null && result) {
      // Fetch the updated list
      _fetchReservations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation List'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: const Text("Add Reservation"),
              onPressed: _navigateToAddReservationPage,
            ),
          ),
          Expanded(
            child: reservationList.isEmpty
                ? const Center(child: Text("No reservations found."))
                : ListView.builder(
              itemCount: reservationList.length,
              itemBuilder: (context, index) {
                final reservation = reservationList[index];
                return ListTile(
                  //title: Text(reservation.arrivalCity) // Assuming 'name' is part of your Reservation entity
                  subtitle: Text('${reservation.departureCity} to ${reservation.arrivalCity}'), // Display more details here
                  onTap: () => _navigateToEditReservationPage(reservation),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


