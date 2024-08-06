import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight_dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import 'package:i_can_fly/utils/helpers.dart';
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
  /// Instance of [FlightDao] for accessing the flight table.
  late FlightDao flightDao;
  
  /// A [TextEditingController] for the departure city.
  TextEditingController departureCityController = TextEditingController();
  /// A [TextEditingController] for the arrival city.
  late DateTime? departureDate;
  /// A [TextEditingController] for the departure time.
  late TimeOfDay? departureTime;
  
  /// A [TextEditingController] for the arrival city.
  TextEditingController arrivalCityController = TextEditingController();
  /// A [TextEditingController] for the arrival date.
  late DateTime? arrivalDate;
  /// A [TextEditingController] for the arrival time.
  late TimeOfDay? arrivalTime;

  /// A [TextEditingController] for the airplane type.
  String? airplaneType;
  
  /// A list of airplane types.
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
    airplaneType = widget.flight.airplaneType;

    AppDatabase.getInstance().then((db) {
      setState(() {
        flightDao = db.flightDao;
        flightDao.findAllAirplaneTypes().then((value) {
          setState(() {
            airplaneTypes.addAll(value);
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

  DateTime _formatDT({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, departureTime!.hour,
        departureTime!.minute);
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
      errorInvalidText: arrivalTime != null
          ? null
          : lookupTranslate(context, "please_select_a_valid_time"),
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
    );
    if (picked != null) {
      setState(() {
        arrivalDate = picked;
      });
    }
  }
  void deleteFlight(BuildContext context, Flight flight) {
    flightDao.deleteFlight(flight).then((result) {
      if (result > 0) {
        flightDao.findAllFlights().then((flights) {
          setState(() {
            widget.flights = flights;
          });
        });
        Navigator.pop(context, true);
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[50],
          content: Text(
              "Failed to delete flight: ${flight.airplaneType} from ${flight.departureCity} to ${flight.arrivalCity} is in use.",
              style: TextStyle(color: Colors.red[900])),
        ),
      );
    });
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            lookupTranslate(context, "update_the_flight"),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(CTColor.Teal.colorValue),
        ),
        body: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.height * 1.8
                    : MediaQuery.of(context).size.height * 0.8,
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
                              controller: departureCityController,
                              decoration: InputDecoration(
                                labelText:
                                    lookupTranslate(context, "departure_city"),
                              ),
                              // initialValue: widget.flight.departureCity,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return lookupTranslate(
                                      context, "please_enter_a_valid_city");
                                }
                                return null;
                              },
                            ),
                            OutlinedButton(
                                onPressed: () => _selectDepartureDate(context),
                                child: Text(departureDate == null
                                    ? lookupTranslate(context, "select_date")
                                    : "${lookupTranslate(context, "departure_date")}: ${DateFormat.yMd().format(departureDate!)}")),
                            OutlinedButton(
                              onPressed: () => _selectDepartureTime(context),
                              child: Text(departureTime == null
                                  ? lookupTranslate(
                                      context, "select_departure_time")
                                  : "${lookupTranslate(context, "departure_time")}: ${departureTime!.format(context)}"),
                            ),
                            TextFormField(
                              controller: arrivalCityController,
                              decoration: InputDecoration(
                                labelText:
                                    lookupTranslate(context, "arrival_city"),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return lookupTranslate(
                                      context, "please_enter_a_valid_city");
                                }
                                return null;
                              },
                            ),
                            OutlinedButton(
                                onPressed: () => _selectArrivalDate(context),
                                child: Text(arrivalDate == null
                                    ? lookupTranslate(
                                        context, "select_arrival_date")
                                    : "${lookupTranslate(context, "arrival_date")}: ${DateFormat.yMd().format(arrivalDate!)}")),
                            OutlinedButton(
                              onPressed: () => _selectArrivalTime(context),
                              child: Text(arrivalTime == null
                                  ? lookupTranslate(
                                      context, "select_arrival_time")
                                  : "${lookupTranslate(context, "arrival_time")}: ${arrivalTime!.format(context)}"),
                            ),
                            DropdownButtonFormField(
                                hint: Text(lookupTranslate(
                                    context, "select_airplane_type")),
                                value: airplaneType == null
                                    ? null
                                    : airplaneTypes.first,
                                validator: (value) => value == null
                                    ? "Please select a valid airplane type"
                                    : null,
                                items: airplaneTypes
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
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
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.red[100])),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          /// 7. Each person’s project must have an ActionBar with ActionItems that displays an AlertDialog with instructions for how to use the interface.
                                          return AlertDialog(
                                            title: Text(lookupTranslate(
                                                context, "delete")),
                                            content: Text(
                                                "${lookupTranslate(context, "confirm_delete")} ${widget.flight.departureCity} ${lookupTranslate(context, "to")} ${widget.flight.arrivalCity}?"),

                                            /// 7. Each person’s project must have an ActionBar with ActionItems that displays an AlertDialog with instructions for how to use the interface.
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(lookupTranslate(
                                                    context, "cancel")),
                                              ),
                                              TextButton(
                                                onPressed: () => deleteFlight(
                                                    context, widget.flight),
                                                child: Text(lookupTranslate(
                                                    context, "delete")),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child:
                                      Text(lookupTranslate(context, "delete")),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (_formKey.currentState!.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              duration:
                                                  const Duration(seconds: 1),
                                              content: Text(lookupTranslate(
                                                  context, "processing_data"))),
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
                                                        departureCityController
                                                            .text,
                                                    arrivalCity:
                                                        arrivalCityController
                                                            .text,
                                                    departureDateTime: deptTime,
                                                    arrivalDateTime: arrTime))
                                                .then((value) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                    SnackBar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                        content: Text(
                                                            "${lookupTranslate(context, "update")}!")),
                                                  )
                                                  .closed
                                                  .then((reason) {
                                                Navigator.pushNamed(
                                                    context, "/flights");
                                                // Navigator.pop(context, true);
                                              });
                                            });
                                          }
                                        });
                                      }
                                    },
                                    child: Text(
                                        lookupTranslate(context, "update"))),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
