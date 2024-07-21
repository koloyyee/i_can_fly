import 'package:flutter/material.dart';
import 'package:i_can_fly/utils/theme-color.dart';

class AddFlightPage extends StatefulWidget {
  AddFlightPage({super.key});

  @override
  State<AddFlightPage> createState() => _AddFlightPageState();
}

class _AddFlightPageState extends State<AddFlightPage> {
  late TextEditingController departureCityController;
  late TextEditingController arrivalCityController;

  @override
  void initState() {
    departureCityController = TextEditingController();
    arrivalCityController = TextEditingController();
    super.initState();
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
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                  "images/gliding_kitty.png",
                  width: 120,
                  height: 120,
                ),
                Column(
                  children: [
                    TextField(
                      controller: departureCityController,
                      decoration: const InputDecoration(
                        labelText: "Departure City",
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          /// BottomSheet
                          showBottomSheet(context: context, builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(15.5),
                              child: Column(children: [],)

                            );
                          });
                        }, child: const Text("Pick Departure Time")),
                  ],
                ),
                TextField(
                  controller: arrivalCityController,
                  decoration: const InputDecoration(
                    labelText: "Arrival City",
                  ),
                ),
                ButtonBar(
                  children: [],
                )
              ],
            )),
      ),
    );
  }
}

class _DateRangePicker extends StatefulWidget {
  final String? restorationId;
  const _DateRangePicker({super.key, this.restorationId});

  @override
  State<_DateRangePicker> createState() => __DateRangePickerState();
}

class __DateRangePickerState extends State<_DateRangePicker> with RestorationMixin{
  @override
  String? get restorationId=> widget.restorationId;
  final RestorableDateTimeN _departureDate = RestorableDateTimeN(DateTime.now(),);
  final RestorableDateTimeN _arrivalDate = RestorableDateTimeN(DateTime.now(),);
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
  
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // TODO: implement restoreState
  }
}