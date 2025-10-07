import 'package:shared_preferences/shared_preferences.dart';

class DefouleService {
  static const String _scoreDefoule = 'score';
  static const String _timerDuration = 'timerDuration';

  static Future<void> saveScoreDefoule(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _scoreDefoule;
    await prefs.setInt(key, score);
  }

  static Future<void> resetScoreDefoulee() async {
    print("🔧 Service: Début reset score");
    final prefs = await SharedPreferences.getInstance();
    final key = _scoreDefoule;
    final score = 0;
    await prefs.setInt(key, score);
    print("🔧 Service: Score sauvegardé = ${prefs.getInt(key)}");
  }

  static Future<int> getScoreDefoule() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_scoreDefoule) ?? 0;
  }

  static Future<void> saveTimerDuration(int timerD) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _timerDuration;
    await prefs.setInt(key, timerD);
  }

  static Future<int> getTimerDuration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_timerDuration) ?? 20;
  }

  static Future<void> resetTimerDuration() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _timerDuration;
    final timerD = 20;
    await prefs.setInt(key, timerD);
  }
}
