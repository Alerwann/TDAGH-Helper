import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdahelpe/app.dart';
import 'package:tdahelpe/pages/Bingo/homepage.dart';
import 'package:tdahelpe/services/notifications/notification_service.dart';

/// Gère l'écoute et la réponse aux notifications
class NotificationHandler {
  static StreamSubscription<String>? _subscription;
  static bool _isNavigating = false;

static Future<void> initialize() async {
    try {
      print('👂 Initialisation du gestionnaire de notifications');

      _subscription = NotificationService.notificationStream.listen(
        (moment) {
          print('🎯 Notification reçue: $moment');
          _navigateToBingo('stream', moment);
        },
        onError: (error) {
          if (kDebugMode) {
            print('❌ Erreur stream notification: $error');
          }
        },
      );

      await Future.delayed(Duration(milliseconds: 500));
      final isFromNotification =
          await NotificationService.isOpenedFromNotification();

      if (isFromNotification) {
        _navigateToBingo('lancement', null);
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ Erreur initialisation notification handler: $e');
        print('Stack: $stackTrace');
      }
    }
  }
  
  static void _navigateToBingo(String source, String? moment) {
    if (_isNavigating) return;
    _isNavigating = true;

    Future.delayed(Duration(milliseconds: 100), () {
      final navigator = TDAHelpeApp.navigatorKey.currentState;

      if (navigator != null) {
        print('🚀 Navigation vers Bingo (source: $source)');

        navigator
            .push(MaterialPageRoute(builder: (context) => HomeBingoPage()))
            .then((_) => _isNavigating = false);
      } else {
        _isNavigating = false;
      }
    });
  }

  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
