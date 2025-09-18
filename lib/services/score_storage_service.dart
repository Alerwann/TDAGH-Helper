import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ScoreStorageService {
  static const String _morningScoreKey = 'morning_score';
  static const String _midiScoreKey = 'midi_score';
  static const String _afternoonScoreKey = 'afternoon_score';
  static const String _eveningScoreKey = 'evening_score';
  static const String _cardsStateKey = 'cards_state';
  static const String _tacheScoreKey = 'taches_score';
  static const String _tacheStateKey = 'taches_state';
  static const String _lastResetDateKey = 'last_reset_date';

  // Sauvegarder les scores
  static Future<void> saveScore(String moment, int score) async {
    final prefs = await SharedPreferences.getInstance();
    String key;

    switch (moment.toLowerCase()) {
      case 'matin':
        key = _morningScoreKey;
        break;
      case 'midi':
        key = _midiScoreKey;
        break;
      case 'soir':
        key = _afternoonScoreKey;
        break;
      case 'couché':
        key = _eveningScoreKey;
        break;
      case 'taches':
        key = _tacheScoreKey;
        break;
      default:
        return;
    }

    await prefs.setInt(key, score);
  }

  // Récupérer un score
  static Future<int> getScore(String moment) async {
    final prefs = await SharedPreferences.getInstance();
    String key;

    switch (moment.toLowerCase()) {
      case 'matin':
        key = _morningScoreKey;
        break;
      case 'midi':
        key = _midiScoreKey;
        break;
      case 'soir':
        key = _afternoonScoreKey;
        break;
      case 'couché':
        key = _eveningScoreKey;
        break;
      case 'taches':
        key = _tacheScoreKey;
        break;
      default:
        return 0;
    }

    return prefs.getInt(key) ?? 0;
  }

  static Future<void> saveCardsState(
    String moment,
    List<bool> cardsState,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_cardsStateKey}_${moment.toLowerCase()}';

    final jsonString = json.encode(cardsState);
    await prefs.setString(key, jsonString);
  }

  static Future<List<bool>> getCardsState(
    String moment,
    int defaultLength,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_cardsStateKey}_${moment.toLowerCase()}';

    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final List<dynamic> decoded = json.decode(jsonString);

      return decoded.map((item) => item as bool).toList();
    }

    return List.generate(defaultLength, (index) => false);
  }

  static Future<void> resetAllCardsState() async {
    final prefs = await SharedPreferences.getInstance();
    final moments = ['matin', 'midi', 'soir', 'couché'];

    for (String moment in moments) {
      final key = '${_cardsStateKey}_$moment';
      await prefs.remove(key);
    }
  }

  static Future<void> saveLastResetDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastResetDateKey, date.toIso8601String());
  }

  static Future<DateTime?> getLastResetDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString(_lastResetDateKey);

    if (dateString != null) {
      return DateTime.parse(dateString);
    }
    return null;
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<List<bool>> getTacheState({int defaultLength = 3}) async {
    final List<bool> defaultList = List.generate(3, (index) => false);
    final prefs = await SharedPreferences.getInstance();
    final key = _tacheStateKey;

    final jsonString = prefs.getString(key);

    if (jsonString != null) {
      final List<dynamic> decoded = json.decode(jsonString);

      return decoded.map((item) => item as bool).toList();
    }

    return defaultList;
  }

  static Future<void> saveTacheState(List<bool> tacheState) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _tacheStateKey;

    final jsonString = json.encode(tacheState);

    await prefs.setString(key, jsonString);
  }

  static Future<void> resetTachesState(List<bool> tacheStates) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _tacheStateKey;
    final List<bool> resetTacheState = List.generate(
      tacheStates.length,
      (index) => false,
    );
    final jsonString = jsonEncode(resetTacheState);
    await prefs.setString(key, jsonString);
  }
}
