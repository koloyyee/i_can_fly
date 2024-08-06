import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/reservation_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/reservation.dart';
import 'package:i_can_fly/page/reservation/add_reservation_page.dart';
import 'package:i_can_fly/page/reservation/reservation_details_page.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReservationListPage extends StatefulWidget {
  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  late ReservationDao reservationDao;
  List<Reservation> reservationList = [];
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  Reservation? selectedReservation;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {

    final database = await AppDatabase.getInstance();
    reservationDao = database.reservationDao;
    _fetchReservations();

  }

  Future<void> _fetchReservations() async {

    final reservations = await reservationDao.findAllReservations();
    setState(() {
      reservationList = reservations;
    });

  }

  void _deleteReservation(Reservation reservation) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this reservation?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm) {

      await reservationDao.deleteReservation(reservation);
      _fetchReservations();
      Fluttertoast.showToast(msg: 'Reservation deleted successfully');
      if (selectedReservation == reservation) {
        setState(() {
          selectedReservation = null;
        });
      }

    }
  }

  void _navigateToAddReservationPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddReservationPage()),
    );

    if (result != null && result) {
      _fetchReservations();
      Fluttertoast.showToast(msg: 'New reservation added successfully');
    }
  }

  Widget _buildListTile(Reservation reservation) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: Icon(Icons.flight_takeoff, color: Colors.blue, size: 30),
          title: Text(
            '${reservation.reservationName} for ${reservation.customerName}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Departure: " + formatter.format(reservation.departureDateTime)),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red, size: 30),
            onPressed: () => _deleteReservation(reservation),
          ),
          onTap: () {
            if (MediaQuery.of(context).orientation == Orientation.landscape) {
              setState(() {
                selectedReservation = reservation;
              });
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationDetailsPage(reservation: reservation)));
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation List'),
        backgroundColor: Colors.teal,
      ),
      body: isLandscape
          ? Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: reservationList.length,
              itemBuilder: (context, index) => _buildListTile(reservationList[index]),
            ),
          ),
          Expanded(
            flex: 2,
            child: selectedReservation == null
                ? Center(child: Text("Select a reservation to view details."))
                : ReservationDetailsPage(reservation: selectedReservation!),
          ),
        ],
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: const Text("Add Reservation"),
              onPressed: _navigateToAddReservationPage,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reservationList.length,
              itemBuilder: (context, index) => _buildListTile(reservationList[index]),
            ),
          ),
        ],
      ),
    );
  }
}