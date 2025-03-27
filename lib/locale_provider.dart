import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/core/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('en', 'US');

  LocaleProvider(this._locale); // Accept initial locale

  static Future<LocaleProvider> create() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = prefs.getString(SharedPrefKey.language.key) ?? 'en';

    return LocaleProvider(Locale(savedLanguageCode));
  }

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
    }
  }

  String get fontFamily {
    switch (_locale.languageCode) {
      case "en":
        return "Kalam";
      case "he":
        return "Fredoka";
      case "ru":
        return "Oswald";
      default:
        return "Kalam";
    }
  }
}
