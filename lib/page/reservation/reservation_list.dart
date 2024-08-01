import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/reservation-dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/reservation.dart';
import 'package:i_can_fly/page/customer/add_customer_page.dart';
import 'package:i_can_fly/page/customer/edit_customer_page.dart';
import 'package:i_can_fly/page/reservation/reservation-details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'add_reservation_page.dart';

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
    _fetchReservation();
  }

  Future<void> _fetchReservation() async {
    final reservations = await reservationDao.findAllReservation();
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
      _fetchReservation();
      Fluttertoast.showToast(msg: 'New reservastion added with success');
    }
  }

  void _navigateToReservationDetailsPage(Reservation reservation) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservationDetailsPage(reservation: reservation)),
    );

    if (result != null && result) {
      // Fetch the updated list
      _fetchReservation();
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
                  title: Text(reservation.reservationName),
                  onTap: () => _navigateToReservationDetailsPage(reservation),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

