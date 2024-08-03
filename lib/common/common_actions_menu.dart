import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import 'package:i_can_fly/utils/helpers.dart';

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
            child: Text(AppLocalizations.of(context)?.translate("home")?? "Home"),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/add-flight");
            },
            child: Text(lookupTranslate(context, "add_flight")),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/airplanes");
            },
            child: Text(lookupTranslate(context, "view_planes")),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/customers");
            },
            child: Text(lookupTranslate(context, "view_customers")),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/reservations");
            },
            child: Text(lookupTranslate(context, "view_reservations")),
          ),
        ),
        ...additionalItems,
        PopupMenuItem(
          child: OutlinedButton(
            onPressed: () {
              esp.clear();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text(lookupTranslate(context, "logout")),
          ),
        ),
      ];
      return items;
    });
  }
}
