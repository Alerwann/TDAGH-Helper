import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/core/startup/notification_handler.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';
import 'package:tdahelpe/services/notifications/ios_notification_handler.dart';
import 'package:tdahelpe/services/notifications/notification_constants.dart';
import 'package:tdahelpe/services/notifications/notification_storage.dart';
import 'package:tdahelpe/services/notifications/timezone_config.dart';

class NotificationService {
  static final StreamController<String> _notificationStream =
      StreamController<String>.broadcast();

  static Stream<String> get notificationStream {
    return _notificationStream.stream;
  }

  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const platform = MethodChannel('alarm_channel');

  static Future<void> initialize() async {
    print('🔵 ===== DÉBUT INITIALISATION NOTIFICATIONS =====');
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

    // ⚠️ Vérifier le lancement AVANT initialize()
    String? launchPayload;
    if (Platform.isIOS) {
      print('🔵 iOS: Vérification du lancement AVANT initialize');
      launchPayload = await IosNotificationHandler.checkLaunchNotification(
        plugin: _notifications,
      );
      print('🔵 iOS: launchPayload récupéré = $launchPayload');
    }
   await AndroidNotificationHandler.requestPermissions();
   await checkAllPermission();

    // Initialiser avec callback
    print('🔵 Appel de _notifications.initialize()');
    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print(
          '🔥 ===== CALLBACK onDidReceiveNotificationResponse DÉCLENCHÉ =====',
        );
        print('   actionId: ${response.actionId}');
        print('   input: ${response.input}');
        print(
          '   notificationResponseType: ${response.notificationResponseType}',
        );
        print('   payload: ${response.payload}');
        print('🔥 =========================================================');

        final String? payload = response.payload;
        if (payload != null) {
          print(payload);
          await NotificationStorage.storeNotificationTap(payload);
          _notificationStream.add(payload);
        }
      },
    );
    print('🔵 _notifications.initialize() terminé');

    // // Traiter le payload de lancement
    if (Platform.isIOS && launchPayload != null) {
      print('🟢 iOS: Traitement du payload de lancement: $launchPayload');
      await NotificationHandler.initialize();
      await NotificationStorage.storeNotificationTap(launchPayload);
      _notificationStream.add(launchPayload);
    }

    print('🔵 ===== FIN INITIALISATION NOTIFICATIONS =====');
  }

  static Future<void> scheduleAllNotifications({
    required int reveilHour,
    required int midiHour,
    required int soirHour,
    required int coucherHour,
  }) async {
    print("🤖❓ schedul allnotificaiton ?");
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
      // minute: 0
      // hour: DateTime.now().hour,
      minute: 0,
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
      print("🤖 isopen from a notif??");
      return await AndroidNotificationHandler.wasOpenedFromNotification();
    }
    return false;
  }

  static Future<bool> checkAllPermission() async {
    bool permissionAuto = false;
    final prefs = await SharedPreferences.getInstance();
    if (Platform.isAndroid) {
      print("🤖 initalisation platform android notificaiton service");

      permissionAuto = await AndroidNotificationHandler.checkPermissions();

      print('🤖 hasPermissions = $permissionAuto');
    } else if (Platform.isIOS) {
      print('🔵 iOS: Demande des permissions');
      permissionAuto =
          await IosNotificationHandler.requestNotificationPermissions();
      print('🔵 iOS: Permissions accordées ? $permissionAuto');
    }
    // mise à jour des données sur les permissions
    await prefs.setBool('needs_permission_warning', !permissionAuto);

    final saved = prefs.getBool('needs_permission_warning');
    print('🤖 needs_permission_warning sauvegardé = $saved');
    return permissionAuto;
  }
}
