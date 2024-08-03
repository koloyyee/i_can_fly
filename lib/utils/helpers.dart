import 'package:flutter/material.dart';
import 'package:i_can_fly/utils/app_localizations.dart';

String capitalizedWord(String word) {
  return word[0].toUpperCase() + word.substring(1);
}

String snakeToCapitalize(String snake_case) {
  return snake_case.split("_").map((word) {
    if (word.isEmpty) return word;
    return capitalizedWord(word);
  }).join(" ");
}

String lookupTranslate(BuildContext context, String translateKey) {
  if (translateKey.isEmpty) return translateKey;
  String? translated = AppLocalizations.of(context)?.translate(translateKey.toLowerCase());
  return translateKey.contains("_")
      ? translated ?? snakeToCapitalize(translateKey)
      : translated ?? capitalizedWord(translateKey);
}
