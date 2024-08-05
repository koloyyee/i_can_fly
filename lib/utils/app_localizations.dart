import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Provides localization support for the application by loading and managing
/// translated strings from JSON files.
///
/// This class handles the loading of localized strings based on the current locale,
/// and provides a method to retrieve the translated text for a given key. It also
/// includes a delegate class for managing the lifecycle of localization resources.
///
/// Example usage:
/// ```
/// AppLocalizations.of(context)!.translate('some_key');
/// ```
///
class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings; // Initialize late

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('assets/translations/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? '** $key not found';
  }

  String translateFallback(context, String key) {
    return _localizedStrings[key] == null ? key.contains("_") ?  _snakeToCapitalize(key) : _capitalizedWord(key): _localizedStrings[key]!;
  }
  String _snakeToCapitalize(String snake_case) {
    return snake_case.split("_").map((word) {
      if (word.isEmpty) return word;
      return _capitalizedWord(word);
    }).join(" ");
  }

 String _capitalizedWord(String word) {
    return word[0].toUpperCase() + word.substring(1);
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
