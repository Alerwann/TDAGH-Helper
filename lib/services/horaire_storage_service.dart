import 'package:shared_preferences/shared_preferences.dart';

class HoraireStorageService {
  static const String _reveilHours = 'reveil_hours';
  static const String _reveilMinutes = 'reveil_minutes';
  static const String _midiHours = "midi_hours";
  static const String _midiMinutes = "midi_minutes";
  static const String _soirHours = "soir_hours";
  static const String _soirMinutes = "soir_minutes";
  static const String _coucheHours = "couche_hours";
  static const String _coucheMinutes = "couche_minutes";

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

  static Future<void> saveMinutes(String moment, int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    String key;

    switch (moment.toLowerCase()) {
      case 'réveil':
        key = _reveilMinutes;
        break;
      case 'midi':
        key = _midiMinutes;
        break;
      case 'soir':
        key = _soirMinutes;
        break;
      case 'couché':
        key = _coucheMinutes;
        break;
      default:
        return;
    }

    await prefs.setInt(key, minutes);
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

  static Future<int> getMinutes(String moment) async {
    final prefs = await SharedPreferences.getInstance();
    String key;

    switch (moment.toLowerCase()) {
      case 'réveil':
        key = _reveilMinutes;
        break;
      case 'midi':
        key = _midiMinutes;
        break;
      case 'soir':
        key = _soirMinutes;
        break;
      case 'couché':
        key = _coucheMinutes;
        break;
      default:
        return 00;
    }

    return prefs.getInt(key) ?? 00;
  }
}
