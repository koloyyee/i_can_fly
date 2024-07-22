import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight-dao.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/utils/theme-color.dart';
import 'package:intl/intl.dart';

class ViewFlightsList extends StatefulWidget {
  const ViewFlightsList({
    super.key,
  });

  @override
  State<ViewFlightsList> createState() => _ViewFlightsListState();
}

class _ViewFlightsListState extends State<ViewFlightsList> {
  List<Flight> flights = [];

  late FlightDao flightDao;

  @override
  void initState() {
    super.initState();
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) {
      flightDao = db.flightDao;
      flightDao.findAllFlights().then((flights) {
        setState(() {
          this.flights = flights;
        });
      });
    });
  }

  // Future<void> deleteFlight(Flight flight) async {
  //   await flightDao.deleteFlight(flight);
  //   flightDao.findAllFlights().then((flights) {
  //     setState(() {
  //       this.flights = flights;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('yy-mm-dd – kk:mm');

    return flights.isEmpty
        ? Center(
            child: Column(
            children: [
              Image.asset(
                "images/shrink_kitty.png",
                width: 360,
                height: 360,
              ),
              const Text(
                "No flights found :(",
                style: TextStyle(fontSize: 36),
              ),
            ],
          ))
        : ListView(
            children: [
              Image.asset(
                "images/gliding_kitty.png",
                width: 120,
                height: 120,
              ),
              for (var flight in flights)
                GestureDetector(
                  onLongPress: () {
                    showBottomSheet(context: context, builder: (BuildContext context) {
                      return SizedBox(
                        height: 500,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Departure City: ${flight.departureCity}"),
                            ),
                            ListTile(
                              title: Text("Arrival City: ${flight.arrivalCity}"),
                            ),
                            ListTile(
                              title: Text("Departure Date: ${formatter.format(flight.departureDateTime)}"),
                            ),
                            ListTile(
                              title: Text("Arrival Date: ${formatter.format(flight.arrivalDateTime)}"),
                            ),
                            ElevatedButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditFlightPage(flight: flight)));
                            }, child: const Text("Edit Flight"),)
                          ],
                        ),
                      );
                    });
                  },
                  child: ListTile(
                    title: Text(
                        "🛫${flight.departureCity} ➡️ 🛬${flight.arrivalCity}"),
                    subtitle: Text(
                        "${formatter.format(flight.departureDateTime)} ➡️ ${formatter.format(flight.arrivalDateTime)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete Flight"),
                                content: Text(
                                    "Are you sure you want to delete the flight from ${flight.departureCity} to ${flight.arrivalCity}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      flightDao.deleteFlight(flight);
                                      flightDao
                                          .findAllFlights()
                                          .then((flights) {
                                        setState(() {
                                          this.flights = flights;
                                        });
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                )
            ],
          );
  }
}
class EditFlightPage extends StatefulWidget {
  Flight flight;
  EditFlightPage({super.key, required this.flight});

  @override
  State<EditFlightPage> createState() => _EditFlightPageState();
}


class _EditFlightPageState extends State<EditFlightPage> {

  late FlightDao flightDao;

  late TextEditingController departureCityController;
  late DateTime? departureDate;
  late TimeOfDay? departureTime;

  late TextEditingController arrivalCityController;
  late DateTime? arrivalDate;
  late TimeOfDay? arrivalTime;

  String airplaneType = "";

  List<String> airplaneTypes = [];

  @override
  void initState() {
    super.initState();

    departureCityController = TextEditingController();
    arrivalCityController = TextEditingController();
    departureDate = widget.flight.departureDateTime;
    departureTime = TimeOfDay.fromDateTime(widget.flight.departureDateTime);
    arrivalDate = widget.flight.arrivalDateTime;
    arrivalTime = TimeOfDay.fromDateTime(widget.flight.arrivalDateTime);

    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((db) {
      flightDao = db.flightDao;
      flightDao.findAllAirplaneTypes().then((value) {
        setState(() {
          print(value);
          airplaneTypes = value;
        });
      });
    });
  }
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    departureCityController.dispose();
    arrivalCityController.dispose();
    super.dispose();
  }
  Future<void> _selectDepartureTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: departureTime ?? TimeOfDay.now(),
      errorInvalidText:
          departureTime != null ? null : "Please select a valid time",
    );
    if (picked != null) {
      setState(() {
        print("Departure Time: ${picked.format(context)}");
        departureTime = picked;
      });
    }
  }

  Future<void> _selectArrivalTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: arrivalTime ?? TimeOfDay.now(),
      errorInvalidText:
          arrivalTime != null ? null : "Please select a valid time",
    );
    if (picked != null) {
      setState(() {
        print("Arrival Time: ${picked.format(context)}");
        arrivalTime = picked;
      });
    }
  }

  Future<void> _selectDepartureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add( const Duration(days: 365)),
      initialDate: departureDate ?? DateTime.now(),
      // selectableDayPredicate: (day) => day.isAfter(DateTime.now()),
    );
    if (picked != null) {
      setState(() {
        departureDate = picked;
      });
    }
  }

  Future<void> _selectArrivalDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: arrivalDate ?? DateTime.now(),
      // selectableDayPredicate: (day) =>
      //     day.isAfter(departureDate ?? DateTime.now()),
    );
    if (picked != null) {
      setState(() {
        arrivalDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a New Trip!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(CTColor.Teal.colorValue),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    "images/gliding_kitty.png",
                    width: 120,
                    height: 120,
                  ),
                  TextFormField(
                    controller: departureCityController,
                    decoration: const InputDecoration(
                      labelText: "Departure City",
                    ),
                    // initialValue: widget.flight.departureCity,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid city";
                      }
                      return null;
                    },
                  ),
                  OutlinedButton(
                      onPressed: () => _selectDepartureDate(context),
                      child: Text(departureDate == null
                          ? "Select Date"
                          : "Departure Date: ${DateFormat.yMd().format(departureDate!)}")),
                  OutlinedButton(
                    onPressed: () => _selectDepartureTime(context),
                    child: Text(departureTime == null
                        ? "Select Arrival Time"
                        : "Departure Time: ${departureTime!.format(context)}"),
                  ),
                  TextFormField(
                    controller: arrivalCityController,
                    decoration: const InputDecoration(
                      labelText: "Departure City",
                    ),
                    // initialValue: widget.flight.arrivalCity,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid city";
                      }
                      return null;
                    },
                  ),
                  OutlinedButton(
                      onPressed: () => _selectArrivalDate(context),
                      child: Text(arrivalDate == null
                          ? "Select Date"
                          : "Arrival Date: ${DateFormat.yMd().format(arrivalDate!)}")),
                  OutlinedButton(
                    onPressed: () => _selectArrivalTime(context),
                    child: Text(arrivalTime == null
                        ? "Select Arrival Time"
                        : "Arrival Time: ${arrivalTime!.format(context)}"),
                  ),
                  DropdownButtonFormField(
                      hint: const Text("Select Airplane Type"),
                      validator: (value) => value == null
                          ? "Please select a valid airplane type"
                          : null,
                      items: airplaneTypes
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => airplaneType = value.toString()),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      setState(() {
                        if (departureTime != null && arrivalTime != null) {
                          DateTime deptTime = DateTime(
                              departureDate!.year,
                              departureDate!.month,
                              departureDate!.day,
                              departureTime!.hour,
                              departureTime!.minute);
                          DateTime arrTime = DateTime(
                              arrivalDate!.year,
                              arrivalDate!.month,
                              arrivalDate!.day,
                              arrivalTime!.hour,
                              arrivalTime!.minute);

                          flightDao
                              .createFlight(Flight(
                                  id: Flight.ID++,
                                  airplaneType: airplaneType,
                                  departureCity: departureCityController.text,
                                  arrivalCity: arrivalCityController.text,
                                  departureDateTime: deptTime,
                                  arrivalDateTime: arrTime))
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('New Flight Added!')),
                            );
                          });
                        }

                        // add flight to database
                        // print("Departure City: ${departureCityController.text}");
                        // print("Arrival City: ${arrivalCityController.text}");
                        // print("Departure Time: ${departureTime!.format(context)}");
                        // print("Arrival Time: ${arrivalTime!.format(context)}");

                        // print("Departure Field Valid: $departureFieldValid");
                        // print("Departure Field Valid: $arrivalFieldValid");

                        //     Navigator.pop(context);
                        // }
                        // });
                      });
                    }
                  },
                  child: const Text("Add New Flight"))
            ],
          ),
        ),
      ),
    );
  }
}