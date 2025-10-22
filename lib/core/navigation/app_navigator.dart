import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdahelpe/pages/Bingo/homepage.dart';
import 'package:tdahelpe/services/notifications/notification_service.dart';

/// Gestionnaire centralisé de la navigation de l'application
///
/// Responsabilités :
/// - Gérer la clé de navigation globale
/// - Gérer les notifications et la navigation associée
/// - Éviter les navigations multiples
class AppNavigator {
  // Clé de navigation globale
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Subscription aux notifications
  static StreamSubscription<String>? _notificationSubscription;

  // Flag pour éviter les navigations multiples
  static bool _isNavigating = false;

  /// Initialise l'écoute des notifications
  ///
  /// À appeler dans initState() du widget principal
  static Future<void> initialize() async {
    await _setupNotificationListener();
    await _checkLaunchNotification();
  }

  /// Nettoie les ressources
  ///
  /// À appeler dans dispose() du widget principal
  static void dispose() {
    _notificationSubscription?.cancel();
    _notificationSubscription = null;
  }

  /// Configure l'écoute du stream de notifications
  static Future<void> _setupNotificationListener() async {
    if (kDebugMode) {
      print('👂 Configuration de l\'écoute des notifications...');
    }

    _notificationSubscription = NotificationService.notificationStream.listen(
      (moment) {
        if (kDebugMode) {
          print('🎯 Notification reçue pour le moment: $moment');
        }
        navigateToBingo(source: 'stream', moment: moment);
      },
      onError: (error) {
        if (kDebugMode) {
          print('❌ Erreur stream notification: $error');
        }
      },
      cancelOnError: false,
    );
  }

  /// Vérifie si l'app a été lancée depuis une notification
  static Future<void> _checkLaunchNotification() async {
    // Attendre que l'UI soit prête
    await Future.delayed(Duration(milliseconds: 500));

    final isFromNotification =
        await NotificationService.isOpenedFromNotification();

    if (kDebugMode) {
      print('❓ Lancée depuis notification ? $isFromNotification');
    }

    if (isFromNotification) {
      navigateToBingo(source: 'lancement');
    } else {
      if (kDebugMode) {
        print('ℹ️ Ouverture normale de l\'app');
      }
    }
  }

  /// Navigue vers la page Bingo
  ///
  /// [source] : Source de la navigation (pour le debug)
  /// [moment] : Moment de la journée (optionnel)
  static Future<void> navigateToBingo({
    required String source,
    String? moment,
  }) async {
    // Éviter les navigations multiples
    if (_isNavigating) {
      if (kDebugMode) {
        print('⚠️ Navigation déjà en cours, annulation');
      }
      return;
    }

    _isNavigating = true;

    try {
      if (kDebugMode) {
        print('🚀 Navigation vers Bingo');
        print('   Source: $source');
        if (moment != null) print('   Moment: $moment');
      }

      // Attendre que le navigator soit prêt
      await Future.delayed(Duration(milliseconds: 100));

      final navigator = navigatorKey.currentState;
      if (navigator != null) {
        await navigator.push(
          MaterialPageRoute(builder: (context) => HomeBingoPage()),
        );
      } else {
        if (kDebugMode) {
          print('❌ Navigator non disponible');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur navigation: $e');
      }
    } finally {
      // Réinitialiser après un délai
      Future.delayed(Duration(milliseconds: 500), () {
        _isNavigating = false;
      });
    }
  }

  /// Navigue vers n'importe quelle page
  ///
  /// Méthode générique pour la navigation
  static Future<T?> navigateTo<T>(Widget page) async {
    final navigator = navigatorKey.currentState;
    if (navigator != null) {
      return navigator.push<T>(MaterialPageRoute(builder: (context) => page));
    }
    return null;
  }

  /// Remplace la page actuelle
  static Future<T?> replaceTo<T>(Widget page) async {
    final navigator = navigatorKey.currentState;
    if (navigator != null) {
      return navigator.pushReplacement<T, void>(
        MaterialPageRoute(builder: (context) => page),
      );
    }
    return null;
  }

  /// Remplace toute la pile de navigation
  static Future<T?> replaceAll<T>(Widget page) async {
    final navigator = navigatorKey.currentState;
    if (navigator != null) {
      return navigator.pushAndRemoveUntil<T>(
        MaterialPageRoute(builder: (context) => page),
        (route) => false,
      );
    }
    return null;
  }

  /// Retour à la page précédente
  static void goBack<T>([T? result]) {
    final navigator = navigatorKey.currentState;
    if (navigator != null && navigator.canPop()) {
      navigator.pop(result);
    }
  }

  /// Retour à la racine (équivalent de pushAndRemoveUntil)
  static void goToRoot() {
    final navigator = navigatorKey.currentState;
    if (navigator != null) {
      navigator.popUntil((route) => route.isFirst);
    }
  }

  /// Vérifie si on peut revenir en arrière
  static bool canGoBack() {
    final navigator = navigatorKey.currentState;
    return navigator?.canPop() ?? false;
  }

  /// Retour avec résultat optionnel
  static void goBackWithResult<T>(T result) {
    final navigator = navigatorKey.currentState;
    if (navigator != null && navigator.canPop()) {
      navigator.pop(result);
    }
  }
}
