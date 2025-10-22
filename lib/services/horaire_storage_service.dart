import 'package:shared_preferences/shared_preferences.dart';

class HoraireStorageService {
  static const String _timerGame = "timer_game";

  static const Map<String, String> _horaireKeys = {
    'reveil': 'reveil_hours',
    'midi': 'midi_hours',
    'soir': 'soir_hours',
    'couche': 'couche_hours', // Variante sans accent
    'reinit': 'reinit_hour',
  };

  /// Sauvegarder une heure pour un moment donné
  static Future<bool> saveHours(String moment, int hours) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _horaireKeys[moment.toLowerCase()];

      if (key == null) {
        return false; // Moment invalide
      }

      await prefs.setInt(key, hours);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Récupérer une heure pour un moment donné
  static Future<int> getHours(String moment) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _horaireKeys[moment.toLowerCase()];

      // Valeurs par défaut selon le moment
      const defaults = {
        'reveil_hours': 7,
        'midi_hours': 12,
        'soir_hours': 19,
        'couche_hours': 21,
        'reinit_hour': 4,
      };

      if (key == null) {
        return 0;
      }

      return prefs.getInt(key) ?? (defaults[key] ?? 0);
    } catch (e) {
      return 0;
    }
  }

  static Future<bool> saveTimerGame(int timerG) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_timerGame, timerG);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> getTimerGame() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_timerGame) ?? 20;
    } catch (e) {
      return 20;
    }
  }
}
