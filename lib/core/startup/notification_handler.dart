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

  /// Initialise l'écoute des notifications
  static Future<void> initialize() async {
    if (kDebugMode) {
      print('👂 Initialisation du gestionnaire de notifications');
    }

    // Écouter les notifications futures
    _subscription = NotificationService.notificationStream.listen(
      (moment) {
        if (kDebugMode) {
          print('🎯 Notification reçue: $moment');
        }
        _navigateToBingo('stream', moment);
      },
      onError: (error) {
        if (kDebugMode) {
          print('❌ Erreur stream notification: $error');
        }
      },
      cancelOnError: false,
    );

    // Vérifier si l'app a été lancée depuis une notification
    await Future.delayed(Duration(milliseconds: 500));
    final isFromNotification =
        await NotificationService.isOpenedFromNotification();

    if (kDebugMode) {
      print('❓ Lancée depuis notification ? $isFromNotification');
    }

    if (isFromNotification) {
      _navigateToBingo('lancement', null);
    }
  }

  /// Navigue vers la page Bingo
  static void _navigateToBingo(String source, String? moment) {
    if (_isNavigating) {
      if (kDebugMode) {
        print('⚠️ Navigation déjà en cours');
      }
      return;
    }

    _isNavigating = true;

    Future.delayed(Duration(milliseconds: 100), () {
      final navigator = TDAHelpeApp.navigatorKey.currentState;

      if (navigator != null) {
        if (kDebugMode) {
          print('🚀 Navigation vers Bingo (source: $source)');
        }

        navigator
            .push(MaterialPageRoute(builder: (context) => HomeBingoPage()))
            .then((_) {
              _isNavigating = false;
            });
      } else {
        if (kDebugMode) {
          print('❌ Navigator non disponible');
        }
        _isNavigating = false;
      }
    });
  }

  /// Nettoie les ressources
  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
