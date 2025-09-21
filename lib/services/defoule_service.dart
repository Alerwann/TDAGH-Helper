import 'package:shared_preferences/shared_preferences.dart';

class DefouleService {
  static const String _scoreDefoule = 'score';

  static Future<void> saveScoreDefoule(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _scoreDefoule;
    await prefs.setInt(key, score);
  }

  static Future<void> restScoreDefoule() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _scoreDefoule;
    final score = 0;
    await prefs.setInt(key, score);
  }

  static Future<int> getScoreDefoule() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_scoreDefoule) ?? 0;
  }

  
}
