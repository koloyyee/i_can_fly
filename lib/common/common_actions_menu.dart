import 'package:flutter/material.dart';

/// A common actions menu that can be used in the app.
/// This menu will be used in the app bar of the pages.
/// The menu will have the following options:
/// - Home
/// - Add Flight
/// - Views Planes
/// - Views Customers
/// - Views Reservations
class CommonActionsMenu extends StatelessWidget {
  const CommonActionsMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            child: const Text("Home"),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/add-flight");
            },
            child: const Text("Add Flight"),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/airplanes");
            },
            child: const Text("Views Planes"),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/customers");
            },
            child: const Text("Views Customers"),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/reservations");
            },
            child: const Text("Views Reservations"),
          ),
        ),
      ];
    });
  }
}
