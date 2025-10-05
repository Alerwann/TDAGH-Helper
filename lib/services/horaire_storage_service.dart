import 'package:shared_preferences/shared_preferences.dart';

class HoraireStorageService {
  static const String _reveilHours = 'reveil_hours';
  static const String _midiHours = "midi_hours";
  static const String _soirHours = "soir_hours";
  static const String _coucheHours = "couche_hours";
  static const String _timerGame = "timer_game";

  static Future<void> saveHours(String moment, int hours) async {
    final prefs = await SharedPreferences.getInstance();
    String key;

    switch (moment.toLowerCase()) {
      case 'réveil':
        key = _reveilHours;
        break;
      case 'midi':
        key = _midiHours;
        break;
      case 'soir':
        key = _soirHours;
        break;
      case 'couché':
        key = _coucheHours;
        break;
      default:
        return;
    }

    await prefs.setInt(key, hours);
  }

  static Future<int> getHours(String moment) async {
    final prefs = await SharedPreferences.getInstance();
    String key = '';

    switch (moment.toLowerCase()) {
      case 'réveil':
        return prefs.getInt(key) ?? 7;
      case 'midi':
        return prefs.getInt(key) ?? 12;
      case 'soir':
        return prefs.getInt(key) ?? 19;
      case 'couché':
        return prefs.getInt(key) ?? 21;
      default:
        return 0;
    }
  }

  static Future<void> saveTimerGame(int timerG) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _timerGame;
    await prefs.setInt(key, timerG);
  }

  static Future<int> getTimerGame() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _timerGame;
    return prefs.getInt(key) ?? 20;
  }
}
