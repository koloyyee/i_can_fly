import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/utils/app_localizations.dart';

/// A common actions menu that can be used in the app.
/// This menu will be used in the app bar of the pages.
/// The menu will have the following options:
/// - Home
/// - Views Flights
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
      final appLocalizations = AppLocalizations.of(context)!;
      // Common menu items
      List<PopupMenuItem> items = [
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            child: Text(appLocalizations.translate("home")),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/flights");
            },
            child: Text(appLocalizations.translate("flights_list")),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/airplanes");
            },
            child: Text(appLocalizations.translate("view_planes")),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/customers");
            },
            child: Text(appLocalizations.translate("view_customers")),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/reservations");
            },
            child: Text(appLocalizations.translate("view_reservations")),
          ),
        ),
        ...additionalItems,
        PopupMenuItem(
          child: OutlinedButton(
            onPressed: () {
              esp.clear();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text(appLocalizations.translate("logout")),
          ),
        ),
      ];
      return items;
    });
  }
}
