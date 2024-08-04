import 'package:flutter/material.dart';
import 'package:i_can_fly/main.dart';
import 'package:i_can_fly/utils/app_localizations.dart';

class LanguageDrawer extends StatelessWidget {
  const LanguageDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)?.translate('english') ??
                'English'),
            onTap: () {
              MyApp.setLocale(context, const Locale('en', ''));
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)?.translate('spanish') ??
                'Spanish'),
            onTap: () {
              MyApp.setLocale(context, const Locale('es', ''));
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
