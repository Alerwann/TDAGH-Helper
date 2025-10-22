import 'package:flutter/foundation.dart';
import 'package:tdahelpe/services/notifications/notification_service.dart';

/// Gère l'initialisation de tous les services de l'application
///
/// Centralise la logique d'initialisation pour :
/// - Les notifications
/// - La base de données locale
/// - Les configurations système
class AppInitializer {
  /// Initialise tous les services nécessaires au démarrage
  ///
  /// Cette méthode doit être appelée dans `main()` avant `runApp()`
  static Future<void> initialize() async {
    if (kDebugMode) {
      print('🚀 Démarrage de l\'initialisation de l\'app...');
    }

    try {
      // Initialisation des notifications
      await _initializeNotifications();

      // Ici tu peux ajouter d'autres initialisations
      // await _initializeDatabase();
      // await _initializeAnalytics();

      if (kDebugMode) {
        print('✅ Initialisation terminée avec succès');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur lors de l\'initialisation: $e');
      }
      // Ne pas bloquer le lancement de l'app
      // mais logger l'erreur pour investigation
    }
  }

  /// Initialise le système de notifications
  static Future<void> _initializeNotifications() async {
    try {
      await NotificationService.initialize();
      if (kDebugMode) {
        print('✅ Notifications initialisées');
      }
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Erreur initialisation notifications: $e');
      }
      // Les notifications ne sont pas critiques pour l'app
      // On peut continuer sans elles
    }
  }
}
