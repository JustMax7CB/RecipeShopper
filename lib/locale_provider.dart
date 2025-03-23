import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('en', 'US');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
    }
  }
}
