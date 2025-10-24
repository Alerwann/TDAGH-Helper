import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';
import 'package:tdahelpe/services/notifications/ios_notification_handler.dart';
import 'package:tdahelpe/services/notifications/notification_constants.dart';
import 'package:tdahelpe/services/notifications/notification_storage.dart';
import 'package:tdahelpe/services/notifications/timezone_config.dart';

class NotificationService {
  static final StreamController<String> _notificationStream =
      StreamController<String>.broadcast();

  static Stream<String> get notificationStream => _notificationStream.stream;

  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const platform = MethodChannel('alarm_channel');

  static Future<void> initialize() async {
    await TimezoneConfig.initialize();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          requestCriticalPermission: false,
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
          notificationCategories: IosNotificationHandler.createCategories(),
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    // Initialiser
    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final String? payload = response.payload;

        if (payload != null) {
          await NotificationStorage.storeNotificationTap(payload);

          _notificationStream.add(payload);

          print('📱 CALLBACK iOS: Moment stocké et émis');
        }
      },
    );

    if (Platform.isAndroid) {
      await AndroidNotificationHandler.requestPermissions(_notifications);

      final hasPermissions =await AndroidNotificationHandler.checkPermissions();
         if (!hasPermissions) {
        // ⚠️ Stocker qu'il faut afficher un message
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('needs_permission_warning', true);
      }
    }

    if (Platform.isIOS) {
    final granted =await  IosNotificationHandler.requestPermissions(plugin: _notifications);
      final String? launchPayload =
          await IosNotificationHandler.checkLaunchNotification(
            plugin: _notifications,
          );

      if (! granted) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('needs_permission_warning', true);
      }

      if (launchPayload != null) {
        await NotificationStorage.storeNotificationTap(launchPayload);
        _notificationStream.add(launchPayload);
        print('📱 iOS: Notification de lancement traitée');
      }
    }

    print('✅ Notifications complètement initialisées');
  }

  static Future<void> scheduleAllNotifications({
    required int reveilHour,
    required int midiHour,
    required int soirHour,
    required int coucherHour,
  }) async {
    print('🔔 scheduleAllNotifications appelé avec:');

    print('🔔  Réveil: $reveilHour h');

    print('🔔   Midi: $midiHour h');

    print('🔔   Soir: $soirHour h');

    print('🔔  Coucher: $coucherHour h');

    await _scheduleNotification(
      id: NotificationConstants.morningNotificationId,
      title: NotificationConstants.getTitle(1),
      body: NotificationConstants.getBody(1),
      hour: reveilHour,
      minute: 0,
    );

    // Planifier notification du midi
    await _scheduleNotification(
      id: NotificationConstants.midiNotificationId,
      title: NotificationConstants.getTitle(2),
      body: NotificationConstants.getBody(2),
      hour: midiHour,
      // hour: DateTime.now().hour,
      minute: 00,
    );

    // Planifier notification du soir
    await _scheduleNotification(
      id: NotificationConstants.soirNotificationId,
      title: NotificationConstants.getTitle(3),
      body: NotificationConstants.getBody(3),
      hour: soirHour,
      minute: 0,
    );

    // Planifier notification du coucher
    await _scheduleNotification(
      id: NotificationConstants.coucherNotificationId,
      title: NotificationConstants.getTitle(4),
      body: NotificationConstants.getBody(4),
      hour: coucherHour,
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
      await AndroidNotificationHandler.scheduleNotification(
        id: id,
        title: title,
        body: body,
        hour: hour,
        minute: minute,
      );
    } else if (Platform.isIOS) {
      await IosNotificationHandler.scheduleNotification(
        plugin: _notifications,
        id: id,
        title: title,
        body: body,
        hour: hour,
        minute: minute,
      );
    }
  }

  static Future<void> cancelNotification(int id) async {
    if (Platform.isAndroid) {
      AndroidNotificationHandler.cancelNotification(id: id);
    } else if (Platform.isIOS) {
      IosNotificationHandler.cancelNotification(plugin: _notifications, id: id);
    }
  }

  static Future<void> cancelAllNotifications() async {
    if (Platform.isAndroid) {
      AndroidNotificationHandler.cancelAllNotifications();
    } else if (Platform.isIOS) {
      IosNotificationHandler.cancelAllNotifications(plugin: _notifications);
    }
  }

  static Future<bool> isOpenedFromNotification() async {
    if (Platform.isAndroid) {
      return isOpenedFromNotificationAndroid();
    } else if (Platform.isIOS) {
      return NotificationStorage.wasOpenedFromNotification();
    }
    return false;
  }

  static Future<bool> isOpenedFromNotificationAndroid() async {
    try {
      final result = await platform.invokeMethod('getNotificationData');
      return result != null;
    } catch (e) {
      print('❌ Erreur Android: $e');

      return false;
    }
  }
}
