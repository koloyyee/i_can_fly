

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i_can_fly/utils/app_localizations.dart';
import 'package:i_can_fly/utils/helpers.dart';
import 'package:flutter/material.dart';

void main() {
  group("translation lookup from for ES", () {
    testWidgets("should get 'Please enter password'", (WidgetTester tester) async {
      // Define a key to identify the widget
      final testKey = GlobalKey();
      // Pump a widget into the widget tree
      await tester.pumpWidget(
        MaterialApp(
           locale:const Locale('en'),
          localizationsDelegates: GlobalMaterialLocalizations.delegates + [
            AppLocalizations.delegate, // Adjust based on your localization setup
            // GlobalMaterialLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('es', ''), // Spanish
          ],
          home: Scaffold(
            body: Builder(
              key: testKey,
              builder: (BuildContext context) {
                // Perform the test
                expect(lookupTranslate(context, 'please_enter_password'), 'Por favor ingrese la contraseña');
                expect(lookupTranslate(context, 'email'), 'Correo electrónico');
                return Container();
              },
            ),
          ),
        ),
      );
    });
  });
}