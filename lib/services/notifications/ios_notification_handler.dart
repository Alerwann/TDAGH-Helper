import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tdahelpe/services/notifications/notification_constants.dart';
import 'package:timezone/timezone.dart' as tz;

class IosNotificationHandler {
  static const platform = MethodChannel('alarm_channel');

  /// Planifie une notification iOS
  static Future<void> scheduleNotification({
    required FlutterLocalNotificationsPlugin plugin,
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);
    final String moment = NotificationConstants.getMomentFromId(id);

    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      categoryIdentifier: NotificationConstants.iosCategoryId,
      threadIdentifier: NotificationConstants.iosThreadId,
      interruptionLevel: InterruptionLevel.timeSensitive,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      iOS: iosDetails,
    );

    await plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: moment,
    );
    print('📱 iOS - ✅ Notification planifiée avec payload: $moment');
  }

  static Future<String?> checkLaunchNotification({
    required FlutterLocalNotificationsPlugin plugin,
  }) async {
    print('📱 iOS: Vérification notification de lancement...');

    final NotificationAppLaunchDetails? launchDetails = await plugin
        .getNotificationAppLaunchDetails();

    // print('📱 iOS: launchDetails = $launchDetails');
    print('📱 iOS: launchDetails != null ? ${launchDetails != null}');

    if (launchDetails != null) {
      print("🪐 launcheDétail différent de null");

  
      if (launchDetails.notificationResponse != null) {
        print(
          '📱 iOS: response.id = ${launchDetails.notificationResponse!.id}',
        );
    
        print("🪐 launcheDétail notificationTesponse différent de null");
      }

      // Si l'app a été lancée depuis une notification
      if (launchDetails.didNotificationLaunchApp) {
        print('📱 iOS: App lancée depuis une notification !');

        final NotificationResponse? response =
            launchDetails.notificationResponse;

        if (response != null && response.payload != null) {
          if (kDebugMode) {
            print('🤯📱 iOS: Payload de lancement = ${response.payload}');
          }
          return response.payload; // ✨ Retourner le payload
        }
      } else {
        if (kDebugMode) {
          print('📱 iOS: Pas de notification de lancement');
        }
      }
    }

    return null; // Pas de notification de lancement
  }

  /// Annule une notification iOS
  static Future<void> cancelNotification({
    required FlutterLocalNotificationsPlugin plugin,
    required int id,
  }) async {
    await plugin.cancel(id);
  }

  /// Annule toutes les notifications iOS
  static Future<void> cancelAllNotifications({
    required FlutterLocalNotificationsPlugin plugin,
  }) async {
    await plugin.cancelAll();
  }

  /// Crée les catégories de notifications iOS
  static List<DarwinNotificationCategory> createCategories() {
    return [
      DarwinNotificationCategory(
        NotificationConstants.iosCategoryId,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain(
            NotificationConstants.iosActionId,
            'Ouvrir',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      ),
    ];
  }




  static Future<void> openSettingsIos() async {
    try {
      // UIApplicationOpenSettingsURLString
      await platform.invokeMethod('openAppSettings');
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur ouverture réglages iOS: $e');
      }
    }
  }

  /// Calcule la prochaine occurrence d'une heure donnée
  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Si l'heure est déjà passée aujourd'hui, planifier pour demain
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  static Future<bool> requestNotificationPermissions() async {
    print("🤯 ios notification handleur request permission version courte");
    try {
      final bool? granted = await platform.invokeMethod(
        'requestNotificationPermission',
      );

      if (kDebugMode) {
        print(
          granted == true
              ? '✅ iOS - Permission accordée'
              : '❌ iOS - Permission refusée',
        );
      }

      return granted ?? false;
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Erreur demande permission iOS: $e');
      }
      return false;
    }
  }


}
