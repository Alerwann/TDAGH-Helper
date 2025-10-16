import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:shared_preferences/shared_preferences.dart';

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

    final String systemTimeZone = DateTime.now().timeZoneName;

    String locationName;
    if (systemTimeZone == 'CEST' || systemTimeZone == 'CET') {
      locationName = 'Europe/Paris';
    } else if (systemTimeZone == 'EST' || systemTimeZone == 'EDT') {
      locationName = 'America/Toronto';
    } else if (systemTimeZone == 'PST' || systemTimeZone == 'PDT') {
      locationName = 'America/Vancouver';
    } else if (systemTimeZone == 'MST' || systemTimeZone == 'MDT') {
      locationName = 'America/Edmonton';
    } else if (systemTimeZone == 'CST' || systemTimeZone == 'CDT') {
      locationName = 'America/Winnipeg';
    } else if (systemTimeZone == 'AST' || systemTimeZone == 'ADT') {
      locationName = 'America/Halifax';
    } else if (systemTimeZone.contains('/')) {
      // Si déjà un nom complet (ex: "Europe/Paris")
      locationName = systemTimeZone;
    } else {
      // Fallback : essayer quand même
      locationName = systemTimeZone;
    }

    bool success = false;

    // 1. Essayer le fuseau détecté
    try {
      tz.setLocalLocation(tz.getLocation(locationName));
      if (kDebugMode) print('✅ Fuseau horaire configuré : $locationName');
      success = true;
    } catch (e) {
      if (kDebugMode) print('⚠️ Échec avec $locationName : $e');
    }

    // 2. Si échec, essayer Europe/Paris
    if (!success) {
      try {
        tz.setLocalLocation(tz.getLocation('Europe/Paris'));
        if (kDebugMode) print('✅ Fallback sur Europe/Paris');
        success = true;
      } catch (e) {
        if (kDebugMode) print('⚠️ Échec avec Europe/Paris : $e');
      }
    }

    // 3. Si tout échoue, utiliser UTC
    if (!success) {
      try {
        tz.setLocalLocation(tz.getLocation('UTC'));
        if (kDebugMode) print('✅ Fallback ultime sur UTC');
      } catch (e) {
        if (kDebugMode)
       {   print('❌ Échec total de la configuration du fuseau horaire');}
    
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
      
          requestCriticalPermission:
              false, 
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
        );

    // Combiner
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    // Initialiser
    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (kDebugMode) {
          print('📱 CALLBACK iOS: Notification response reçue !');
        }
        if (kDebugMode) {
          if (kDebugMode) {}
          if (kDebugMode) {
            print('📱 CALLBACK iOS: ID = ${response.id}');
          }
        }
        if (kDebugMode) {
          print('📱 CALLBACK iOS: Payload = ${response.payload}');
        }
        if (kDebugMode) {
          print('📱 CALLBACK iOS: Action = ${response.actionId}');
        }

        final String? payload = response.payload;

        if (payload != null) {
          if (kDebugMode) {
            print('📱 CALLBACK iOS: Stockage du moment: $payload');
          }
          await _storeNotificationData(payload);
          if (kDebugMode) {
            print('📱 CALLBACK iOS: Moment stocké avec succès');
          }
        } else {
          if (kDebugMode) {
            print('⚠️ CALLBACK iOS: Payload est null !');
          }
        }
      },
    );

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

      try {
        final bool? canSchedule = await platform.invokeMethod(
          'checkPermissions',
        );
        if (kDebugMode) {
          if (canSchedule == true) {
            print('✅ Permission SCHEDULE_EXACT_ALARM accordée');
          } else {
            print('⚠️ Permission SCHEDULE_EXACT_ALARM manquante');
            print(
              '💡 L\'utilisateur doit l\'activer manuellement dans les paramètres',
            );
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('⚠️ Erreur vérification SCHEDULE_EXACT_ALARM: $e');
        }
      }
    }

    if (kDebugMode) {
      print('✅ Notifications complètement initialisées');
    }
  }

  static Future<bool> hasAllPermissions() async {
    if (Platform.isAndroid) {
      try {
        // Vérifier SCHEDULE_EXACT_ALARM via Kotlin
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

    // Sur iOS, pas besoin de cette permission
    return true;
  }

  static Future<void> requestMissingPermissions() async {
    if (Platform.isAndroid) {
      try {
        final bool? canSchedule = await platform.invokeMethod(
          'checkPermissions',
        );

        if (canSchedule == false) {
          // Ouvrir les paramètres pour que l'utilisateur active manuellement
          await platform.invokeMethod('openSettings');
        }
      } catch (e) {
        if (kDebugMode) {
          print('⚠️ Erreur demande permissions: $e');
        }
      }
    }
  }

  static Future<bool> checkPermissions() async {
    if (Platform.isAndroid) {
      try {
        final bool? canSchedule = await platform.invokeMethod(
          'checkPermissions',
        );
        return canSchedule ?? false;
      } catch (e) {
        if (kDebugMode) {
          print('Erreur vérification permissions: $e');
        }
        return false;
      }
    }
    return true; // iOS n'a pas besoin de cette permission
  }

  static Future<void> openSettings() async {
    if (Platform.isAndroid) {
      try {
        await platform.invokeMethod('openSettings');
      } catch (e) {
        if (kDebugMode) {
          print('Erreur ouverture paramètres: $e');
        }
      }
    }
  }

  static Future<void> scheduleAllNotifications({
    required int reveilHour,
    required int midiHour,
    required int soirHour,
    required int coucheHour,
  }) async {
    if (kDebugMode) {
      print('🔔 scheduleAllNotifications appelé avec:');
    }
    if (kDebugMode) {
      print('   Réveil: $reveilHour h');
    }
    if (kDebugMode) {
      print('   Midi: $midiHour h');
    }
    if (kDebugMode) {
      print('   Soir: $soirHour h');
    }
    if (kDebugMode) {
      print('   Couché: $coucheHour h');
    }
    await _scheduleNotification(
      id: morningNotificationId,
      title: '🌅 La journée commence !!',
      body: 'Passe une excellente journée',
      hour: reveilHour,
      minute: 0,
    );

    // Planifier notification du midi
    await _scheduleNotification(
      id: midiNotificationId,
      title: '🌅 La période du matin va finir !!',
      body: 'N\'oublie pas de valider tes tâches du matin',
      hour: midiHour,
      // hour:    DateTime.now().hour,
      minute:0,
    );

    // Planifier notification du soir
    await _scheduleNotification(
      id: soirNotificationId,
      title: '🍽️ La période du midi va finir !!',
      body: 'N\'oublie pas de valider tes tâches du midi',
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
    const platform = MethodChannel('alarm_channel');

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
    if (kDebugMode) {
      print('📱 iOS - Planification notification #$id');
    }
    if (kDebugMode) {
      print('   Heure demandée : $hour:$minute');
    }

    final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);

    String moment;
    switch (id) {
      case morningNotificationId:
        moment = 'Matin';
        break;
      case midiNotificationId:
        moment = 'Midi';
        break;
      case soirNotificationId:
        moment = 'Soir';
        break;
      case coucheNotificationId:
        moment = 'Couché';
        break;
      default:
        moment = 'Matin';
    }

    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: moment, // On garde le payload pour essayer
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
    if (kDebugMode) {
      print('⏰ Maintenant : $now');
    }
    if (kDebugMode) {
      print('⏰ Notification prévue : $scheduledDate');
    }
    return scheduledDate;
  }

  static Future<void> cancelNotification(int id) async {
    if (Platform.isAndroid) {
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

  static Future<void> _storeNotificationData(String moment) async {
    if (kDebugMode) {
      print('💾 _storeNotificationData appelé avec: $moment');
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pending_notification_moment', moment);
    await prefs.setBool('pending_notification_open', true);
    if (kDebugMode) {
      print('💾 Moment stocké: $moment');
    }

    // ✅ Vérifier immédiatement que c'est bien sauvegardé
    final saved = prefs.getString('pending_notification_moment');
    if (kDebugMode) {
      print('💾 Vérification: moment sauvegardé = $saved');
    }
  }

  // Remplace toute la section getNotificationData par ceci :

  static Future<bool> isOpenedFromNotification() async {
    if (Platform.isAndroid) {
      return _isOpenedFromNotificationAndroid();
    } else if (Platform.isIOS) {
      return _isOpenedFromNotificationIOS();
    }
    return false;
  }

  static Future<bool> _isOpenedFromNotificationAndroid() async {
    try {
      final result = await platform.invokeMethod('getNotificationData');
      return result != null;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur Android: $e');
      }
      return false;
    }
  }

  static Future<bool> _isOpenedFromNotificationIOS() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final shouldOpen = prefs.getBool('pending_notification_open') ?? false;

      if (shouldOpen) {
        // Nettoyer après lecture
        await prefs.remove('pending_notification_open');
        await prefs.remove('pending_notification_moment');
        return true;
      }

      return false;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur iOS: $e');
      }
      return false;
    }
  }
}
