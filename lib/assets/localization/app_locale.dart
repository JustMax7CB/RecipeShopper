import 'dart:ui';

enum SupportedLanguages {
  english('en', "US"),
  hebrew('he', "IL"),
  russian('ru', "RU");

  final String LangCode;
  final String countryCode;

  const SupportedLanguages(this.LangCode,this.countryCode);
}

List<Locale> get supportedLocales =>
    SupportedLanguages.values.map((lang) => Locale(lang.LangCode, lang.countryCode)).toList();
