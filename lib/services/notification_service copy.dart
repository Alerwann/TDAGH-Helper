import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static const platform = MethodChannel('alarm_channel');
  static const int morningNotificationId = 1;
  static const int midiNotificationId = 2;
  static const int soirNotificationId = 3;
  static const int coucheNotificationId = 4;

  static Future<void> initialize() async {
    tz_data.initializeTimeZones();

    final String locationName = tz.local.name;

    // A modifier pour le bon fuseau horaire sans erreur

    try {
      tz.setLocalLocation(tz.getLocation(locationName));
      if (kDebugMode) {
        print('✅ Fuseau horaire configuré : $locationName');
      }
    } catch (e) {
      tz.setLocalLocation(tz.getLocation('UTC'));
      if (kDebugMode) {
        print('⚠️ Erreur timezone, utilisation de UTC : $e');
      }
    }

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configurer iOS
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    // Combiner
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    // Initialiser
    await _notifications.initialize(initializationSettings);

    if (Platform.isAndroid) {
      try {
        await _notifications
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

    if (kDebugMode) {
      print('✅ Notifications complètement initialisées');
    }
  }

  //ne change pas
  static Future<void> scheduleAllNotifications({
    required int reveilHour,
    required int midiHour,
    required int soirHour,
    required int coucheHour,
  }) async {
    // Planifier notification du matin
    await _scheduleNotification(
      id: morningNotificationId,
      title: '🌅 La période du matin va finir !!',
      body: 'N\'oublie pas de valider tes tâches du matin',
      hour: reveilHour,
      minute: 0,
    );

    // Planifier notification du midi
    await _scheduleNotification(
      id: midiNotificationId,
      title: '🍽️ La période du midi va finir !!',
      body: 'N\'oublie pas de valider tes tâches du midi',
      hour: midiHour,
      minute: 0,
    );

    // Planifier notification du soir
    await _scheduleNotification(
      id: soirNotificationId,
      title: '🌆 La période du soir va finir !!',
      body: 'N\'oublie pas de valider tes tâches du soir',
      hour: soirHour,
      minute: 0,
    );

    // Planifier notification du couché
    await _scheduleNotification(
      id: coucheNotificationId,
      title: "⭐ Prêt pour dormir?",
      body: 'N\'oublie pas de valider tes tâches avant de dormir',
      hour: coucheHour,
      minute: 0,
    );
  }

  static Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    if (Platform.isAndroid) {
      await _scheduleNotificationAndroid(id, title, body, hour, minute);
    } else if (Platform.isIOS) {
      await _scheduleNotificationIOS(id, title, body, hour, minute);
    }
  }

  static Future<void> _scheduleNotificationAndroid(
    int id,
    String title,
    String body,
    int hour,
    int minute,
  ) async {
    await platform.invokeMethod('scheduleAlarm', {
      'id': id,
      'title': title,
      'body': body,
      'hour': hour,
      'minute': minute,
    });
  }

  static Future<void> _scheduleNotificationIOS(
    int id,
    String title,
    String body,
    int hour,
    int minute,
  ) async {
    final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Combiner iOS
    const NotificationDetails notificationDetails = NotificationDetails(
      iOS: iosDetails,
    );

    // Planifier la notification quotidienne
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,

      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

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

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  static Future<void> cancelNotification(int id) async {
    if (Platform.isAndroid) {
      // Appeler le Kotlin pour annuler l'alarme Android

      await platform.invokeMethod('cancelAlarm', {'id': id});
    } else if (Platform.isIOS) {
      // Utiliser flutter_local_notifications pour iOS
      await _notifications.cancel(id);
    }
  }

  static Future<void> cancelAllNotifications() async {
    if (Platform.isAndroid) {

      await platform.invokeMethod('cancelAllAlarms');
    } else if (Platform.isIOS) {
      await _notifications.cancelAll();
    }
  }
}
