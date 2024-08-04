import 'package:flutter/material.dart';
import 'package:i_can_fly/utils/app_localizations.dart';

String capitalizedWord(String word) {
  return word[0].toUpperCase() + word.substring(1);
}

/// how to use:
/// this is a helper function to convert snake_case to Capitalized Words
String snakeToCapitalize(String snake_case) {
  return snake_case.split("_").map((word) {
    if (word.isEmpty) return word;
    return capitalizedWord(word);
  }).join(" ");
}

/// how to use:
/// this is a helper function to lookup the translation of a key
///
/// [context] - The context of the widget
///
/// [translateKey] - The key to be translated in snake_case
///
/// if not found, it will return the capitalized version of the key
/// if the key is not in snake_case, it will return the capitalized version of the translation
String lookupTranslate(BuildContext context, String translateKey) {
  if (translateKey.isEmpty) return translateKey;
  String? translated =
      AppLocalizations.of(context)?.translate(translateKey.toLowerCase());
  
  return translated!.contains("not found") && translated.contains("**")? 
  translateKey.contains("_") ?  snakeToCapitalize(translateKey) : capitalizedWord(translateKey) :
  translated;
}
