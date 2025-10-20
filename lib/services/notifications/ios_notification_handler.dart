import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tdahelpe/services/notifications/notification_constants.dart';
import 'package:timezone/timezone.dart' as tz;

class IosNotificationHandler {
  /// Planifie une notification iOS
  static Future<void> scheduleNotification({
    required FlutterLocalNotificationsPlugin plugin,
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    if (kDebugMode) {
      print('📱 iOS - Planification notification #$id');
      print('   Heure demandée : $hour:$minute');
    }

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

    if (kDebugMode) {
      print('📱 iOS - ✅ Notification planifiée avec payload: $moment');
    }
  }

  static Future<String?> checkLaunchNotification({
    required FlutterLocalNotificationsPlugin plugin,
  }) async {
    if (kDebugMode) {
      print('📱 iOS: Vérification notification de lancement...');
    }

    final NotificationAppLaunchDetails? launchDetails = await plugin
        .getNotificationAppLaunchDetails();

    if (kDebugMode) {
      print('📱 iOS: launchDetails = $launchDetails');
      print('📱 iOS: launchDetails != null ? ${launchDetails != null}');
    }

    if (launchDetails != null) {
      if (kDebugMode) {
        print(
          '📱 iOS: didNotificationLaunchApp = ${launchDetails.didNotificationLaunchApp}',
        );
        print(
          '📱 iOS: notificationResponse = ${launchDetails.notificationResponse}',
        );
      }

      if (launchDetails.notificationResponse != null) {
        if (kDebugMode) {
          print(
            '📱 iOS: response.id = ${launchDetails.notificationResponse!.id}',
          );
          print(
            '📱 iOS: response.payload = ${launchDetails.notificationResponse!.payload}',
          );
        }
      }

      // Si l'app a été lancée depuis une notification
      if (launchDetails.didNotificationLaunchApp) {
        if (kDebugMode) {
          print('📱 iOS: App lancée depuis une notification !');
        }

        final NotificationResponse? response =
            launchDetails.notificationResponse;

        if (response != null && response.payload != null) {
          if (kDebugMode) {
            print('📱 iOS: Payload de lancement = ${response.payload}');
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
    if (kDebugMode) {
      print('📱 iOS - ❌ Notification #$id annulée');
    }
  }

  /// Annule toutes les notifications iOS
  static Future<void> cancelAllNotifications({
    required FlutterLocalNotificationsPlugin plugin,
  }) async {
    await plugin.cancelAll();
    if (kDebugMode) {
      print('📱 iOS - ❌ Toutes les notifications annulées');
    }
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

  /// Demande les permissions iOS
  static Future<bool> requestPermissions({
    required FlutterLocalNotificationsPlugin plugin,
  }) async {
    if (kDebugMode) {
      print('📱 iOS: Demande des permissions...');
    }

    final bool? result = await plugin
        .resolvePlatformSpecificImplementation
            <IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
          critical: false,
        );

    if (kDebugMode) {
      print('📱 iOS: Permissions accordées ? $result');
    }

    return result ?? false;
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

    if (kDebugMode) {
      print('⏰ Maintenant : $now');
      print('⏰ Notification prévue : $scheduledDate');
    }

    return scheduledDate;
  }
}