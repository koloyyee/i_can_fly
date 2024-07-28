import 'package:flutter/material.dart';
import 'view_airplanes_list.dart';
import 'package:i_can_fly/utils/theme-color.dart';

class AirplanesPage extends StatefulWidget {
  const AirplanesPage({super.key});

  @override
  State<AirplanesPage> createState() => _AirplanesPageState();
}

class _AirplanesPageState extends State<AirplanesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "See All Your Airplanes Here!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(CTColor.Teal.colorValue),
      ),
      body: const Center(
        child: AirplaneListPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add-airplane");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateBottomSheet extends StatelessWidget {
  final List<TextField> textfields;

  const CreateBottomSheet({
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
              // add airplane
              Navigator.pop(context);
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }
}
