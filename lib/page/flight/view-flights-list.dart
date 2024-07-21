import 'package:flutter/material.dart';

class ViewFlightsList extends StatelessWidget {
  const ViewFlightsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          "images/gliding_kitty.png",
          width: 120,
          height: 120,
        ),
        ListTile(
          title: Text("Flight 1"),
          subtitle: Text("Departure: 12:00 PM"),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // delete flight
            },
          ),
        ),
        ListTile(
          title: Text("Flight 2"),
          subtitle: Text("Departure: 1:00 PM"),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // delete flight
            },
          ),
        ),
        ListTile(
          title: Text("Flight 3"),
          subtitle: Text("Departure: 2:00 PM"),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // delete flight
            },
          ),
        ),
      ],
    );
  }
}
