import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/utils/helpers.dart';
import 'package:i_can_fly/utils/theme_color.dart';
import 'package:intl/intl.dart';

/// Page for adding a new flight to the database.
/// Conform with [Flight] and use [FlightDao] to interact with the database.
/// This page will allow the user to input the following information:
/// - Departure City
/// - Departure Date
/// - Departure Time
/// - Arrival City
/// - Arrival Date
/// - Arrival Time
/// - Airplane Type
///  
class AddFlightPage extends StatefulWidget {
  const AddFlightPage({super.key});

  @override
  State<AddFlightPage> createState() => _AddFlightPageState();
}

class _AddFlightPageState extends State<AddFlightPage> {
  late FlightDao flightDao;

  late TextEditingController departureCityController;
  DateTime? departureDate;
  TimeOfDay? departureTime;

  late TextEditingController arrivalCityController;
  DateTime? arrivalDate;
  TimeOfDay? arrivalTime;

  String airplaneType = "";

  List<String> _airplaneTypes = [];

  @override
  void initState() {
    super.initState();

    departureCityController = TextEditingController();
    arrivalCityController = TextEditingController();

    AppDatabase.getInstance().then((db) {
      flightDao = db.flightDao;
      flightDao.findAllAirplaneTypes().then((types) => setState(()=> _airplaneTypes = types));
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
      initialTime: TimeOfDay.now(),
      errorInvalidText:
          departureTime != null ? null : lookupTranslate(context, "please_select_a_valid_time") ,

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
      initialTime: TimeOfDay.now(),
      errorInvalidText:
          arrivalTime != null ? null : lookupTranslate(context, "please_select_a_valid_time"),
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
      initialDate: DateTime.now(),
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
      initialDate: DateTime.now(),
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
            lookupTranslate(context, "create_new_flight") ,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(CTColor.Teal.colorValue),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
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
                          key: const Key("departureCityField"),
                          controller: departureCityController,
                          decoration: InputDecoration(
                            labelText: lookupTranslate(context, "departure_city"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return lookupTranslate(context, "please_enter_a_valid_city");
                            }
                            return null;
                          },
                        ),
                        OutlinedButton(
                            key: const Key("departureDateButton"),
                            onPressed: () => _selectDepartureDate(context),
                            child: Text(departureDate == null
                                ? lookupTranslate(context, "select_date")
                                : "${lookupTranslate(context, "departure_date")}: ${DateFormat.yMd().format(departureDate!)}")),
                        OutlinedButton(
                          key: const Key("departureTimeButton"),
                          onPressed: () => _selectDepartureTime(context),
                          child: Text(departureTime == null
                              ? lookupTranslate(context, "select_departure_time")
                              : "${lookupTranslate(context, "departure_time")}: ${departureTime!.format(context)}"),

                        ),
                        TextFormField(
                          key: const Key("arrivalCityField"),
                          controller: arrivalCityController,
                          decoration: InputDecoration(
                            labelText: lookupTranslate(context, "arrival_city"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return lookupTranslate(context, "please_enter_a_valid_city");
                            }
                            return null;
                          },
                        ),
                        OutlinedButton(
                          key: const Key("arrivalDateButton"),
                            onPressed: () => _selectArrivalDate(context),
                            child: Text(arrivalDate == null
                                ? "Select Date"
                                : "Arrival Date: ${DateFormat.yMd().format(arrivalDate!)}")),
                        OutlinedButton(
                          key: const Key("arrivalTimeButton"),
                          onPressed: () => _selectArrivalTime(context),
                          child: Text(arrivalTime == null
                              ? lookupTranslate(context, "select_arrival_time") 
                              : "${lookupTranslate(context, "arrival_time")}: ${arrivalTime!.format(context)}"),
                        ),
                        DropdownButtonFormField(
                            key: const Key("airplaneTypeDropdown"),
                            hint: Text(lookupTranslate(context, "select_airplane_type")),
                            validator: (value) => value == null
                                ? lookupTranslate(context, "please_select_airplane_type") 
                                : null,
                            items: _airplaneTypes
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (value) =>
                                airplaneType = value.toString()),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1) ,
                                content: Text(lookupTranslate(context, "processing_data"))),
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
                                    .createFlight(Flight(
                                        id: null,
                                        airplaneType: airplaneType,
                                        departureCity:
                                            departureCityController.text,
                                        arrivalCity: arrivalCityController.text,
                                        departureDateTime: deptTime,
                                        arrivalDateTime: arrTime))
                                    .then((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                        SnackBar(
                                            duration: const Duration(seconds: 2),
                                            content: Text(lookupTranslate(context, "new_flight_added"))),
                                      )
                                      .closed
                                      .then((reason) {
                                          Navigator.pushNamed(context, "/flights");
                                    // Navigator.pop(context);
                                  });
                                });
                              }
                            });
                          }
                        },
                        child: Text(lookupTranslate(context, "add_new_flight"))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
