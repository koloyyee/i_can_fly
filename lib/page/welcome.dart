import 'package:flutter/material.dart';
import 'package:i_can_fly/common/language_drawer.dart';
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
      endDrawer: LanguageDrawer(),
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
