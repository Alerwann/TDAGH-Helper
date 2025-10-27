import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationStorage {
  static const String _keyMoment = 'pending_notification_moment';
  static const String _keyOpen = 'pending_notification_open';

  /// Stocke qu'une notification a été tapée
  static Future<void> storeNotificationTap(String moment) async {
    print("👀 notificaiton storage tap");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyMoment, moment);
    await prefs.setBool(_keyOpen, true);

    // Vérification
    final saved = prefs.getString(_keyMoment);

      print('💾 Vérification: moment sauvegardé = $saved');
 
  }

  /// Vérifie si l'app a été ouverte depuis une notification
  static Future<bool> wasOpenedFromNotification() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final shouldOpen = prefs.getBool(_keyOpen) ?? false;

      if (shouldOpen) {
        // Nettoyer après lecture
        await prefs.remove(_keyOpen);
        await prefs.remove(_keyMoment);
        return true;
      }

      return false;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur lecture notification: $e');
      }
      return false;
    }
  }
}
