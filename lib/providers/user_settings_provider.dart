import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_settings.dart';

class UserSettingsProvider with ChangeNotifier {
  static const String _prefsKey = 'user_settings';
  UserSettings _userSettings = const UserSettings();
  final SharedPreferences _preferences;
  UserSettings get userSettings => _userSettings;

  UserSettingsProvider(this._preferences) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {

      final settingsJson = _preferences.getString(_prefsKey);
      
      if (settingsJson != null) {
        _userSettings = UserSettings.fromMap(
          Map<String, dynamic>.from(settingsJson as Map),
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user settings: $e');
    }
  }

  Future<void> updateSettings(UserSettings newSettings) async {
    _userSettings = newSettings;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, _userSettings.toMap().toString());
    } catch (e) {
      debugPrint('Error saving user settings: $e');
    }
  }

  // Individual update methods for better granularity
  Future<void> updateWeeklyReminders(bool value) async {
    _userSettings = _userSettings.copyWith(weeklyReminders: value);
    await updateSettings(_userSettings);
  }

  Future<void> updateAgeGroup(String value) async {
    _userSettings = _userSettings.copyWith(ageGroup: value);
    await updateSettings(_userSettings);
  }

  Future<void> updateInterests(Set<String> value) async {
    _userSettings = _userSettings.copyWith(interests: value);
    await updateSettings(_userSettings);
  }

  Future<void> updateMood(String value) async {
    _userSettings = _userSettings.copyWith(mood: value);
    await updateSettings(_userSettings);
  }

  // Get AI-friendly user profile summary
  String getUserProfileForAI() {
    return _userSettings.toAIPrompt();
  }
}
