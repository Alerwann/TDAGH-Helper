import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefouleService {
  static const String _scoreDefoule = 'score';
  static const String _timerDuration = 'timerDuration';

  static Future<bool> saveScoreDefoule(int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_scoreDefoule, score);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("❌ Erreur sauvegarde score défoulage: $e");
      }
      return false;
    }
  }

  static Future<bool> resetScoreDefoulee() async {
    try {
      if (kDebugMode) {
        print("🔧 Service: Début reset score");
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_scoreDefoule, 0);
      if (kDebugMode) {
        print("✅ Service: Score réinitialisé");
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("❌ Erreur reset score: $e");
      }
      return false;
    }
  }

  static Future<int> getScoreDefoule() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_scoreDefoule) ?? 0;
    } catch (e) {
      if (kDebugMode) {
        print("❌ Erreur lecture score: $e");
      }
      return 0;
    }
  }

  static Future<bool> saveTimerDuration(int timerD) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_timerDuration, timerD);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("❌ Erreur sauvegarde timer: $e");
      }
      return false;
    }
  }

  static Future<int> getTimerDuration() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_timerDuration) ?? 20;
    } catch (e) {
      if (kDebugMode) {
        print("❌ Erreur lecture timer: $e");
      }
      return 20;
    }
  }

  static Future<bool> resetTimerDuration() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_timerDuration, 20);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("❌ Erreur reset timer: $e");
      }
      return false;
    }
  }
}
