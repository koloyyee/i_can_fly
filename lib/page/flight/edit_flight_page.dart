import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import 'package:i_can_fly/utils/theme_color.dart';
import 'package:intl/intl.dart';

/// A StatefulWidget that represents the edit flight page.
/// Instance of [FlightDao] for accessing the flight table.
/// A list of [Flight] objects to store the flights.
/// A method to update a flight in the database.
/// A method to delete a flight from the database.
class EditFlightPage extends StatefulWidget {
  Flight flight;
  List<Flight> flights;
  EditFlightPage({super.key, required this.flight, required this.flights});

  @override
  State<EditFlightPage> createState() => _EditFlightPageState();
}

class _EditFlightPageState extends State<EditFlightPage> {
  late FlightDao flightDao;

  TextEditingController departureCityController = TextEditingController();
  late DateTime? departureDate;
  late TimeOfDay? departureTime;

  TextEditingController arrivalCityController = TextEditingController();
  late DateTime? arrivalDate;
  late TimeOfDay? arrivalTime;

  String airplaneType = "";

  List<String> airplaneTypes = [];

  @override
  void initState() {
    super.initState();
    departureCityController.value =
        TextEditingValue(text: widget.flight.departureCity);
    arrivalCityController.value =
        TextEditingValue(text: widget.flight.arrivalCity);
    departureDate = widget.flight.departureDateTime;
    departureTime = TimeOfDay.fromDateTime(widget.flight.departureDateTime);
    arrivalDate = widget.flight.arrivalDateTime;
    arrivalTime = TimeOfDay.fromDateTime(widget.flight.arrivalDateTime);

    AppDatabase.getInstance().then((db) {
      setState(() {
        flightDao = db.flightDao;
        flightDao.findAllAirplaneTypes().then((value) {
          setState(() {
            airplaneTypes = value;
          });
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
        arrivalTime = picked;
      });
    }
  }

  Future<void> _selectDepartureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
        title: Text(
          AppLocalizations.of(context)?.translate("update_the_flight") ??
          "Update the Flight!",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(CTColor.Teal.colorValue),
        // leading: IconButton( icon: Icon(Icons.arrow_back),
        // onPressed: () {
        //   Navigator.pushNamed(context, "/flights");
        // },),
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
                          value: widget.flight.airplaneType,
                          validator: (value) => value == null
                              ? "Please select a valid airplane type"
                              : null,
                          items: airplaneTypes
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) =>
                              airplaneType = value.toString()),
                    ],
                  ),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );

                                  setState(() {
                                    if (departureTime != null &&
                                        arrivalTime != null) {
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
                                          .updateFlight(Flight(
                                              id: widget.flight.id,
                                              airplaneType: airplaneType,
                                              departureCity:
                                                  departureCityController.text,
                                              arrivalCity:
                                                  arrivalCityController.text,
                                              departureDateTime: deptTime,
                                              arrivalDateTime: arrTime))
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('New Flight Added!')),
                                        );
                                      });
                                    }
                                  });
                                }
                              },
                              child: const Text("Update Flight")),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Delete Flight"),
                                      content: Text(
                                          "Are you sure you want to delete the flight from ${widget.flight.departureCity} to ${widget.flight.arrivalCity}?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            flightDao
                                                .deleteFlight(widget.flight);
                                            flightDao
                                                .findAllFlights()
                                                .then((flights) {
                                              setState(() {
                                                widget.flights = flights;
                                              });
                                            });
                                            Navigator.of(context).pop();
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text("Delete Flight"),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ));
  }
}
