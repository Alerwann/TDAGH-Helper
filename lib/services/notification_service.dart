import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static const int morningNotificationId = 1;
  static const int midiNotificationId = 2;
  static const int soirNotificationId = 3;
  static const int coucheNotificationId = 4;

  static Future<void> initialize() async {
    tz_data.initializeTimeZones();

    final String locationName = tz.local.name;

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

    // Configurer Android
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
    // Créer l'heure de la notification avec le timezone local
    final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);

    // Configurer les détails Android
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'daily_notifications', // ID du canal
          'Notifications quotidiennes', // Nom du canal
          channelDescription: 'Rappels pour valider tes tâches quotidiennes',
          importance: Importance.high,
          priority: Priority.high,
        );

    // Configurer les détails iOS
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Combiner Android + iOS
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Planifier la notification quotidienne
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}
