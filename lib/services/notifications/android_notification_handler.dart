import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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
      // print('🤖 Android - Planification notification #$id');
      // print('   Heure demandée : $hour:$minute');
    }
    if (hour < 0 || hour > 23) {
      throw ArgumentError('Heure invalide: $hour');
    }
    if (minute < 0 || minute > 59) {
      throw ArgumentError('Minute invalide: $minute');
    }

    try {
      await platform.invokeMethod('scheduleAlarm', {
        'id': id,
        'title': title,
        'body': body,
        'hour': hour,
        'minute': minute,
      });

      // if (kDebugMode) {
      //   print('🤖 Android - ✅ Notification planifiée');
      // }
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
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur annulation toutes notifications Android: $e');
      }
      rethrow;
    }
  }

  /// Vérifie si toutes les permissions nécessaires sont accordées
  static Future<bool> checkPermissions() async {
    // print("🤖❓ entree dans chekpermission");
    try {
      final bool? canSchedule = await platform.invokeMethod('checkPermissions');
      // print("🤖❓ canschedule : $canSchedule");

      if (canSchedule == false) {
        return false;
      }

      if (kDebugMode) {
        print('✅ Toutes les permissions Android accordées');
      }
      return canSchedule ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Demande les permissions nécessaires pour les notifications
  static Future<bool> requestPermissions() async {
    // print("🤖❓ entree dans requestPermission");

    if (!Platform.isAndroid) {
      return true;
    }

    try {
      final bool? granted = await platform.invokeMethod('requestPermissions');

      // print("🤖 granted?? : $granted");

      return granted ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Ouvre les paramètres système pour configurer les permissions
  static Future<void> openSettingsAndroid() async {
    if (!Platform.isAndroid) {
      return;
    }

    try {
      await platform.invokeMethod('openSettings');
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
      print("🪶 opened bool : $opened");

      return opened;
    } catch (e) {
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
