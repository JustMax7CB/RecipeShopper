import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:recipeshopper/assets/localization/app_locale.dart';
import 'package:recipeshopper/core/services/shared_preferences.dart';
import 'package:recipeshopper/locale_provider.dart';

@Injectable()
class SettingsViewModel extends ChangeNotifier {
  final SharedPrefsService _sharedPrefsService;

  SettingsViewModel(this._sharedPrefsService) {
    _init();
  }

  late final String _appVersion;

  String get appVersion => _appVersion;

  bool darkModeValue = false;
  SupportedLanguages selectedLanguage = SupportedLanguages.english;
  bool autoSyncValue = false;

  Future<void> _init() async {
    darkModeValue = await _sharedPrefsService
        .getBool(SharedPrefKey.darkMode.key, def: false);
    autoSyncValue = await _sharedPrefsService
        .getBool(SharedPrefKey.autoSync.key, def: false);
    final savedLangCode = await _sharedPrefsService.getString(
        SharedPrefKey.language.key,
        def: SupportedLanguages.english.LangCode);
    selectedLanguage = SupportedLanguages.values
        .firstWhere((lang) => lang.LangCode == savedLangCode);

    final packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
  }

  void changeDarkModeValue(bool value) {
    darkModeValue = value;
    notifyListeners();

    _setDarkMode(value);
  }

  void changeLanguage(SupportedLanguages lang, LocaleProvider localeProvider) {
    selectedLanguage = lang;
    localeProvider.setLocale(Locale(lang.LangCode));
    notifyListeners();

    _setDefaultLanguage(lang);
  }

  void changeAutoSyncValue(bool value) {
    autoSyncValue = value;
    notifyListeners();

    _setAutoSync(value);
  }

  Future<void> _setDefaultLanguage(SupportedLanguages language) async {
    await _sharedPrefsService.setKey(
        SharedPrefKey.language.key, language.LangCode);
  }

  Future<void> _setDarkMode(bool darkModeEnabled) async {
    await _sharedPrefsService.setKey(
        SharedPrefKey.darkMode.key, darkModeEnabled);
  }

  Future<void> _setAutoSync(bool autoSyncEnabled) async {
    await _sharedPrefsService.setKey(
        SharedPrefKey.autoSync.key, autoSyncEnabled);
  }

  Future<void> syncData() async {}

  Future<void> clearData() async {}
}
