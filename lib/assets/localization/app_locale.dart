import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipeshopper/extensions.dart';

enum SupportedLanguages {
  english('en', "US"),
  hebrew('he', "IL"),
  russian('ru', "RU");

  final String LangCode;
  final String countryCode;

  const SupportedLanguages(this.LangCode, this.countryCode);

  // Method to get the localized name of the language
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case SupportedLanguages.english:
        return context.localized
            .english; // Ensure you have a translation key for 'english'
      case SupportedLanguages.hebrew:
        return context
            .localized.hebrew; // Ensure you have a translation key for 'hebrew'
      case SupportedLanguages.russian:
        return context.localized
            .russian; // Ensure you have a translation key for 'russian'
      default:
        return ''; // Return an empty string for undefined cases
    }
  }
}

List<Locale> get supportedLocales => SupportedLanguages.values
    .map((lang) => Locale(lang.LangCode, lang.countryCode))
    .toList();
