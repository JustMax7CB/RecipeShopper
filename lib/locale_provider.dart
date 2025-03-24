import 'package:flutter/material.dart';
import 'package:recipeshopper/assets/localization/app_locale.dart';

class LocaleProvider extends ChangeNotifier {
  int _langIndex = 0; // Store language index here
  Locale _locale = Locale('en', 'US');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
    }
  }

  void cycleLanguage() {
    _langIndex = (_langIndex + 1) % SupportedLanguages.values.length;
    final newLang = SupportedLanguages.values[_langIndex];
    setLocale(Locale(newLang.LangCode, newLang.countryCode));
  }
}

