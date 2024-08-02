import 'package:flutter/material.dart';
import 'package:i_can_fly/common/common_actions_menu.dart';
import 'package:i_can_fly/page/flight/view_flights_list.dart';
import 'package:i_can_fly/utils/theme_color.dart';

/// This page will simulate an airline keeping a list of flights between two cities.
/// You should be able to add new flights to your company’s list of routes, 
/// view current flights or delete flights that are no longer offered.
/// 
/// •Your application should have a button for adding a new flight. 
/// When the user presses this button, 
/// there is a page that lets the user enter the departure 
/// and destination cities, as well as the departure and arrival times.
/// You should check that all fields have a value before letting the user submit 
/// the new airplane type.
/// 
/// •Once a flight is added, they should appear in a list of all flights 
/// available to a company, as well as be inserted in a database. 
/// Selecting a flight from the list should show that flights’ details in the same page 
/// as when creating the flight. However now instead of a submit button, there should be an Update and Delete button. 
/// The update button just saves the flight’s updated information and delete removes the flight from the list and database.

class FlightsPage extends StatefulWidget {
  const FlightsPage({super.key});
  @override
  State<FlightsPage> createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("See All Your Flights Here!", style: TextStyle(color: Colors.white),),
        backgroundColor: Color(CTColor.Teal.colorValue),
      actions: const [
        CommonActionsMenu()
      ],
      ),
      body : const SafeArea(
        child: ViewFlightsList()
      
      ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
          Navigator.pushNamed(context, "/add-flight");
        // showModalBottomSheet(context: context, builder: (BuildContext context) {
        // });
      },
      child: const Icon(Icons.add),
    ),
    );
  }
}

class CreateBottomSheet extends StatelessWidget {
  
  List<TextField> textfields = []; 

  CreateBottomSheet({
    super.key,
    required this.textfields,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          for (var textfield in textfields) textfield,
          ElevatedButton(
            onPressed: () {
              // add flight
              Navigator.pop(context);
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }
}

/// This page will simulate an airline keeping a list of flights between two cities.
/// You should be able to add new flights to your company’s list of routes, 
/// view current flights or delete flights that are no longer offered.


