import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BingoStorageService {
  static const String _morningScoreKey = 'morning_score';
  static const String _midiScoreKey = 'midi_score';
  static const String _afternoonScoreKey = 'afternoon_score';
  static const String _eveningScoreKey = 'evening_score';
  static const String _cardsStateKey = 'cards_state';
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
      default:
        return 0;
    }

    return prefs.getInt(key) ?? 0;
  }

  // Sauvegarder l'état des cartes
  static Future<void> saveCardsState(
    String moment,
    List<bool> cardsState,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_cardsStateKey}_${moment.toLowerCase()}';

    // Convertir la liste de bool en JSON string
    final jsonString = json.encode(cardsState);
    await prefs.setString(key, jsonString);
  }

  // Récupérer l'état des cartes
  static Future<List<bool>> getCardsState(
    String moment,
    int defaultLength,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_cardsStateKey}_${moment.toLowerCase()}';

    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final List<dynamic> decoded = json.decode(jsonString);
      // Convertir chaque élément en bool explicitement
      return decoded.map((item) => item as bool).toList();
    }

    // Si aucune sauvegarde, retourner une liste de false
    return List.generate(defaultLength, (index) => false);
  }

  // Reset l'état de toutes les cartes
  static Future<void> resetAllCardsState() async {
    final prefs = await SharedPreferences.getInstance();
    final moments = ['matin', 'midi', 'soir', 'couché'];

    for (String moment in moments) {
      final key = '${_cardsStateKey}_$moment';
      await prefs.remove(key);
    }
  }

  // Sauvegarder la date du dernier reset
  static Future<void> saveLastResetDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastResetDateKey, date.toIso8601String());
  }

  // Récupérer la date du dernier reset
  static Future<DateTime?> getLastResetDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString(_lastResetDateKey);

    if (dateString != null) {
      return DateTime.parse(dateString);
    }
    return null;
  }

  // Effacer toutes les données (utile pour reset complet)
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
