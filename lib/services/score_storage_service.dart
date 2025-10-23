import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ScoreStorageService {
  // ✅ Map pour associer les moments aux clés
  static const Map<String, String> _scoreKeys = {
    'matin': 'morning_score',
    'midi': 'midi_score',
    'soir': 'afternoon_score',
    'coucher': 'evening_score',
    'taches': 'taches_score',
    'bingoGlobal': 'global_bingo_score',
  };

  static const String _cardsStateKey = 'cards_state';
  static const String _tacheStateKey = 'taches_state';
  static const String _lastResetDateKey = 'last_reset_date';
  static const String _xpGlobalKey = 'xp_global';
  static const String _toothScoreKey = 'tooth_score';
  static const String _defouleScoreKey = 'defoule_score';

  // ========== SCORES ==========

  /// Sauvegarder un score pour un moment donné
  /// Retourne true si succès, false si échec
  static Future<bool> saveScore(String moment, int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _scoreKeys[moment.toLowerCase()];

      if (key == null) {
        return false; // Moment invalide
      }

      await prefs.setInt(key, score);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Récupérer un score pour un moment donné
  static Future<int> getScore(String moment) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _scoreKeys[moment.toLowerCase()];

      if (key == null) {
        return 0; // Moment invalide
      }

      return prefs.getInt(key) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // ========== XP GLOBAL ==========

  static Future<bool> saveXpGlobal(int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_xpGlobalKey, score);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> getXpGlobal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_xpGlobalKey) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // ========== TOOTH SCORE ==========

  static Future<bool> saveToothScore(int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_toothScoreKey, score);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> getToothScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_toothScoreKey) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // ========== DEFOULE SCORE ==========

  static Future<bool> saveDefouleScore(int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_defouleScoreKey, score);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> getDefouleScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_defouleScoreKey) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // ========== CARDS STATE ==========

  static Future<bool> saveCardsState(
    String moment,
    List<bool> cardsState,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${_cardsStateKey}_${moment.toLowerCase()}';
      final jsonString = json.encode(cardsState);
      await prefs.setString(key, jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<bool>> getCardsState(
    String moment,
    int defaultLength,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${_cardsStateKey}_${moment.toLowerCase()}';
      final jsonString = prefs.getString(key);

      if (jsonString != null) {
        final List<dynamic> decoded = json.decode(jsonString);
        return decoded.map((item) => item as bool).toList();
      }

      return List.generate(defaultLength, (index) => false);
    } catch (e) {
      return List.generate(defaultLength, (index) => false);
    }
  }

  static Future<bool> resetAllCardsState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final moments = ['matin', 'midi', 'soir', 'coucher'];

      for (String moment in moments) {
        final key = '${_cardsStateKey}_$moment';
        await prefs.remove(key);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // ========== TACHE STATE ==========

  static Future<bool> saveTacheState(List<bool> tacheState) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(tacheState);
      await prefs.setString(_tacheStateKey, jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<bool>> getTacheState({int defaultLength = 3}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_tacheStateKey);

      if (jsonString != null) {
        final List<dynamic> decoded = json.decode(jsonString);
        return decoded.map((item) => item as bool).toList();
      }

      return List.generate(defaultLength, (index) => false);
    } catch (e) {
      return List.generate(defaultLength, (index) => false);
    }
  }

  static Future<bool> resetTachesState(List<bool> tacheStates) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<bool> resetTacheState = List.generate(
        tacheStates.length,
        (index) => false,
      );
      final jsonString = jsonEncode(resetTacheState);
      await prefs.setString(_tacheStateKey, jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> resetTacheScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_scoreKeys['taches']!, 0);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ========== LAST RESET DATE ==========

  static Future<bool> saveLastResetDate(DateTime date) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastResetDateKey, date.toIso8601String());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<DateTime?> getLastResetDate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dateString = prefs.getString(_lastResetDateKey);

      if (dateString != null) {
        return DateTime.parse(dateString);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // ========== UTILITIES ==========

  static Future<bool> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}
