import 'package:flutter/material.dart';
import 'package:i_can_fly/common/common_actions_menu.dart';
import 'package:i_can_fly/page/flight/view_flights_list.dart';
import 'package:i_can_fly/utils/helpers.dart';
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


/// 1. You must have a ListView that lists items that were inserted by the user.
/// 2. There must be a TextField along with a button that lets the user insert items into the ListView.
/// 3. You must use a database to store items that were inserted into the ListView to repopulate the list when the application is restarted.
/// 4. Selecting items from the ListView should show details about the item that was selected. On a phone would use the whole screen to show the details but on a Tablet or Desktop screen, it would show the details beside the ListView.
/// 5. Each activity must have at least 1 Snackbar, and 1 AlertDialog to show some kind of notification.
/// 6. Each activity must use EncryptedSharedPreferences to save something about what was typed in the EditText for use the next time the application is launched.
/// 7. Each person’s project must have an ActionBar with ActionItems that displays an AlertDialog with instructions for how to use the interface.
/// 8. There must be at least 1 other language supported by your part of the project. If you are not bilingual, then you must support both British and American English (words like colour, color, neighbour, neighbor, etc). If you know a language other than English, then you can support that language in your application and don’t need to support American English.All activities must be integrated into a single working application, on a single device or emulator. You should use GitHub for merging your code by creating pull requests.
/// 9. The interfaces must look professional, with GUI elements properly laid out and aligned.
/// 10. The functions and variables you write must be
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
        automaticallyImplyLeading: false,
        title: Text(lookupTranslate(context, "flight_page_title"), style: TextStyle(color: Colors.white),),
        backgroundColor: Color(CTColor.Teal.colorValue),
      actions: const [
        CommonActionsMenu()
      ],
      ),
      body : const SafeArea(
        child: ViewFlightsList()
      
      ),
// 2.[x] There must be a TextField along with a button that lets the user insert items into the ListView.
    floatingActionButton: FloatingActionButton(
      onPressed: () {
          Navigator.pushNamed(context, "/add-flight");
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


