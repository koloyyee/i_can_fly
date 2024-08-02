import 'package:flutter/material.dart';
import 'package:i_can_fly/main.dart';
import 'package:i_can_fly/utils/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.translate('welcome_title') ??
            'Welcome'),
        backgroundColor: Colors.teal,
      ),
      endDrawer: Drawer(
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('welcome_message') ??
                    'Welcome to your flight App!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)?.translate('choose_preference') ??
                    'Choose your preference',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin-login');
                },
                child: Text(AppLocalizations.of(context)?.translate('admin') ??
                    'Admin'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/customer-login');
                },
                child: Text(
                    AppLocalizations.of(context)?.translate('customer') ??
                        'Customer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
