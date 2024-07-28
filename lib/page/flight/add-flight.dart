import 'package:flutter/material.dart';
import 'package:i_can_fly/dao/flight-dao.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/entity/flight.dart';
import 'package:i_can_fly/utils/theme-color.dart';
import 'package:intl/intl.dart';

/// •Your application should have a button for adding a new flight.
/// When the user presses this button,
/// there is a page that lets the user enter the departure
/// and destination cities, as well as the departure and arrival times.
/// You should check that all fields have a value before letting the user submit
/// the new airplane type.
///
// /// following requirements:
// 1.[ ] You must have a ListView that lists items that were inserted by the user.
// 2.[ ] There must be a TextField along with a button that lets the user insert items into the ListView.
// 3.[ ] You must use a database to store items that were inserted into the ListView to repopulate the list when the application is restarted.
// 4.[ ] Selecting items from the ListView should show details about the item that was selected. On a phone would use the whole screen to show the details but on a Tablet or Desktop screen, it would show the details beside the ListView.
// 5.[ ] Each activity must have at least 1 Snackbar, and 1 AlertDialog to show some kind of notification.
// 6.[ ] Each activity must use EncryptedSharedPreferences to save something about what was typed in the EditText for use the next time the application is launched.
// 7.[ ] Each person’s project must have an ActionBar with ActionItems that displays an AlertDialog with instructions for how to use the interface.
// 8.[ ] There must be at least 1 other language supported by your part of the project. If you are not bilingual, then you must support both British and American English (words like colour, color, neighbour, neighbor, etc). If you know a language other than English, then you can support that language in your application and don’t need to support American English.All activities must be integrated into a single working application, on a single device or emulator. You should use GitHub for merging your code by creating pull requests.
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

  List<String> airplaneTypes = [];

  @override
  void initState() {
    super.initState();

    departureCityController = TextEditingController();
    arrivalCityController = TextEditingController();

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
      initialTime: TimeOfDay.now(),
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
      initialTime: TimeOfDay.now(),
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
      initialDate: DateTime.now(),
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
      initialDate: DateTime.now(),
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
      body:  SingleChildScrollView(
        child: Padding (padding: new EdgeInsets.all(12.2),
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
                    decoration: const InputDecoration(
                      labelText: "Departure City",
                    ),
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
                                  id: null,
                                  airplaneType: airplaneType,
                                  departureCity: departureCityController.text,
                                  arrivalCity: arrivalCityController.text,
                                  departureDateTime: deptTime,
                                  arrivalDateTime: arrTime))
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('New Flight Added!')),
                            ).closed.then((reason) {
                              Navigator.pop(context);
                            });
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
        
        )

      )
      
    );
  }
}
