import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/customer.dart';
import 'package:i_can_fly/main.dart';
import 'package:i_can_fly/page/customer/edit_customer_page.dart';
import 'package:i_can_fly/page/reservation/reservation_list.dart';
import 'package:i_can_fly/utils/app_localizations.dart';

// A StatefulWidget that represents the customer's home page.
class CustomerHomePage extends StatefulWidget {
  final Customer customer;

  const CustomerHomePage({super.key, required this.customer});

  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

/// The state for the [CustomerHomePage] widget.
class _CustomerHomePageState extends State<CustomerHomePage> {
  late Future<AppDatabase> databaseFuture;

  @override
  void initState() {
    super.initState();
    databaseFuture =
        $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)?.translate('home_page') ?? 'Home'),
        backgroundColor: Colors.teal,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)?.translate('english') ??
                  'English'),
              onTap: () {
                MyApp.setLocale(context, const Locale('en', ''));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)?.translate('spanish') ??
                  'Spanish'),
              onTap: () {
                MyApp.setLocale(context, const Locale('es', ''));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<AppDatabase>(
        future: databaseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final database = snapshot.data!;
            final flightDao = database.flightDao;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${widget.customer.name}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditCustomerPage(customer: widget.customer),
                        ),
                      );
                    },
                    child: const Text("Edit Profile"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReservationListPage(flightDao: flightDao),
                        ),
                      );
                    },
                    child: const Text("My Reservations"),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }


  Widget responsiveLayout(BuildContext context, FlightDao flightDao) {
    var size = MediaQuery
        .of(context)
        .size;
    var width = size.width;

    if (width > 720) {
      // Landscape or wide mode
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${widget.customer.name}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditCustomerPage(customer: widget.customer),
                        ),
                      );
                    },
                    child: const Text("Edit Profile"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReservationListPage(flightDao: flightDao),
                        ),
                      );
                    },
                    child: const Text("My Reservations"),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      // Portrait or narrow mode
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${widget.customer.name}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditCustomerPage(customer: widget.customer),
                  ),
                );
              },
              child: const Text("Edit Profile"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReservationListPage(flightDao: flightDao),
                  ),
                );
              },
              child: const Text("My Reservations"),
            ),
          ],
        ),
      );
    }
  }
}