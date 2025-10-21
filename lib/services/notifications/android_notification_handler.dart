import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AndroidNotificationHandler {
  static const platform = MethodChannel('alarm_channel');

  /// Planifie une notification Android via le MethodChannel
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    if (kDebugMode) {
      print('🤖 Android - Planification notification #$id');
      print('   Heure demandée : $hour:$minute');
    }

    try {
      await platform.invokeMethod('scheduleAlarm', {
        'id': id,
        'title': title,
        'body': body,
        'hour': hour,
        'minute': minute,
      });

      if (kDebugMode) {
        print('🤖 Android - ✅ Notification planifiée');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur planification Android: $e');
      }
      rethrow; // Relancer l'erreur pour que le service parent puisse la gérer
    }
  }

  /// Annule une notification Android
  static Future<void> cancelNotification({required int id}) async {
    try {
      await platform.invokeMethod('cancelAlarm', {'id': id});
      if (kDebugMode) {
        print('🤖 Android - ❌ Notification #$id annulée');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur annulation notification Android: $e');
      }
      rethrow;
    }
  }

  /// Annule toutes les notifications Android
  static Future<void> cancelAllNotifications() async {
    try {
      await platform.invokeMethod('cancelAllAlarms');
      if (kDebugMode) {
        print('🤖 Android - ❌ Toutes les notifications annulées');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur annulation toutes notifications Android: $e');
      }
      rethrow;
    }
  }

  /// Vérifie si toutes les permissions nécessaires sont accordées
  static Future<bool> checkPermissions() async {

    try {
      final bool? canSchedule = await platform.invokeMethod('checkPermissions');

      if (canSchedule == false) {
        if (kDebugMode) {
          print('❌ Permission SCHEDULE_EXACT_ALARM manquante');
        }
        return false;
      }

      if (kDebugMode) {
        print('✅ Toutes les permissions Android accordées');
      }
      return canSchedule ?? false;
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Erreur vérification permissions: $e');
      }
      return false;
    }
  }

  /// Demande les permissions nécessaires pour les notifications
  static Future<void> requestPermissions(FlutterLocalNotificationsPlugin plugin) async {


    try {
      if (kDebugMode) {
        print('🤖 Android: Demande des permissions...');
      }

       await plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();

      if (kDebugMode) {
        print('✅ Permission notifications demandée');
      }
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Erreur demande permission: $e');
      }
    }
  }

  /// Ouvre les paramètres système pour configurer les permissions
  static Future<void> openSettings() async {
    if (!Platform.isAndroid) {
      return;
    }

    try {
      await platform.invokeMethod('openSettings');
      if (kDebugMode) {
        print('🤖 Android - Ouverture des paramètres');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur ouverture paramètres: $e');
      }
    }
  }

  /// Vérifie si l'app a été ouverte depuis une notification Android
  static Future<bool> wasOpenedFromNotification() async {
    if (!Platform.isAndroid) {
      return false;
    }

    try {
      final result = await platform.invokeMethod('getNotificationData');
      final bool opened = result != null;

      if (kDebugMode) {
        print('🤖 Android - Ouvert depuis notification: $opened');
      }

      return opened;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur vérification ouverture Android: $e');
      }
      return false;
    }
  }

    static Future<bool> hasAllPermissions() async {
    if (Platform.isAndroid) {
      try {
        final bool? canSchedule = await platform.invokeMethod(
          'checkPermissions',
        );

        if (canSchedule == false) {
          if (kDebugMode) {
            print('❌ Permission SCHEDULE_EXACT_ALARM manquante');
          }
          return false;
        }

        if (kDebugMode) {
          print('✅ Toutes les permissions Android accordées');
        }
        return true;
      } catch (e) {
        if (kDebugMode) {
          print('⚠️ Erreur vérification permissions: $e');
        }
        return false;
      }
    }

    return true;
  }
}
