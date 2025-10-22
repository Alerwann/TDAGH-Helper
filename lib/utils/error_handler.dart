import 'package:flutter/foundation.dart';

/// Gestionnaire d'erreurs global pour l'application
///
/// Utilisation :
/// ```dart
/// final score = await ErrorHandler.handleAsync(
///   () => ScoreStorageService.getScore('matin'),
///   errorMessage: 'Impossible de charger le score',
///   defaultValue: 0,
/// );
/// ```
class ErrorHandler {
  /// Gère automatiquement les erreurs pour toute opération asynchrone
  ///
  /// [operation] : La fonction asynchrone à exécuter
  /// [errorMessage] : Message à afficher dans les logs en cas d'erreur
  /// [defaultValue] : Valeur à retourner en cas d'erreur (optionnel)
  ///
  /// Retourne le résultat de l'opération ou [defaultValue] en cas d'erreur
  static Future<T?> handleAsync<T>(
    Future<T> Function() operation, {
    String errorMessage = 'Une erreur est survenue',
    T? defaultValue,
  }) async {
    try {
      return await operation();
    } catch (e, stackTrace) {
      // Afficher l'erreur uniquement en mode debug
      if (kDebugMode) {
        print('');
        print('═══════════════════════════════════════════════');
        print('❌ ERREUR CAPTURÉE PAR ErrorHandler');
        print('═══════════════════════════════════════════════');
        print('📝 Message : $errorMessage');
        print('🐛 Erreur  : $e');
        print('📍 Stack   : ');
        print(stackTrace);
        print('═══════════════════════════════════════════════');
        print('');
      }

      // Retourner la valeur par défaut
      return defaultValue;
    }
  }

  /// Version synchrone pour les opérations non-asynchrones
  ///
  /// Utilisation :
  /// ```dart
  /// final result = ErrorHandler.handleSync(
  ///   () => riskyOperation(),
  ///   errorMessage: 'Opération échouée',
  ///   defaultValue: 0,
  /// );
  /// ```
  static T? handleSync<T>(
    T Function() operation, {
    String errorMessage = 'Une erreur est survenue',
    T? defaultValue,
  }) {
    try {
      return operation();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('');
        print('═══════════════════════════════════════════════');
        print('❌ ERREUR CAPTURÉE PAR ErrorHandler (Sync)');
        print('═══════════════════════════════════════════════');
        print('📝 Message : $errorMessage');
        print('🐛 Erreur  : $e');
        print('📍 Stack   : ');
        print(stackTrace);
        print('═══════════════════════════════════════════════');
        print('');
      }

      return defaultValue;
    }
  }
}
