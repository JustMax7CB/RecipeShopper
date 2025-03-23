import 'dart:ui';

mixin AppLocale {
  static const String title = "title";
}

enum SupportedLanguages {
  english('en'),
  hebrew('he'),
  russian('ru');

  final String LangCode;

  const SupportedLanguages(this.LangCode);
}

List<Locale> get supportedLocales =>
    SupportedLanguages.values.map((lang) => Locale(lang.LangCode)).toList();
