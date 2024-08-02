import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';

/// A common actions menu that can be used in the app.
/// This menu will be used in the app bar of the pages.
/// The menu will have the following options:
/// - Home
/// - Add Flight
/// - Views Planes
/// - Views Customers
/// - Views Reservations
/// - Logout
/// - Instructions
class CommonActionsMenu extends StatelessWidget {
  final List<PopupMenuItem> additionalItems;

  const CommonActionsMenu({
    super.key,
    this.additionalItems = const [],
  });

  @override
  Widget build(BuildContext context) {
    EncryptedSharedPreferences esp = EncryptedSharedPreferences();

    return PopupMenuButton(itemBuilder: (BuildContext context) {
      // Common menu items
      List<PopupMenuItem> items = [
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
        ...additionalItems,
        PopupMenuItem(
          child: OutlinedButton(
            onPressed: () {
              esp.clear();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text("Logout"),
          ),
        ),
      ];
      return items;
    });
  }
}
