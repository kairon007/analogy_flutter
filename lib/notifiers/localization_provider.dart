import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


const List<Locale> supportedLocales = [
  Locale('en', ''), // English
  Locale('hi', ''), // Hindi
  Locale('bn', ''), // Bengali
  Locale('ta', ''), // Tamil
  Locale('te', ''), // Telugu
  Locale('mr', ''), // Marathi
  Locale('kn', ''), // Kannada
  Locale('gu', ''), // Gujarati
];
class LocalizationProvider extends ChangeNotifier {
  final SharedPreferences _preferences;
  Locale _locale = supportedLocales[0];
  static const String _localeKey = 'selected_locale';

  Locale get locale => _locale;

  LocalizationProvider(this._preferences) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {

    final languageCode = _preferences.getString(_localeKey);
    if (languageCode != null) {
      final newLocale = supportedLocales.firstWhere(
            (locale) => locale.languageCode == languageCode,
        orElse: () => supportedLocales[0],
      );
      _locale = newLocale;
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    if (supportedLocales.contains(newLocale)) {
      _locale = newLocale;

      await _preferences.setString(_localeKey, newLocale.languageCode);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}