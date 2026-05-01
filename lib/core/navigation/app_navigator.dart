import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:tdahelpe/app.dart';

/// Gestionnaire centralisé de la navigation de l'application
///
/// Responsabilités :
/// - Gérer la clé de navigation globale
/// - Gérer les notifications et la navigation associée
/// - Éviter les navigations multiples
class AppNavigator {
  // Clé de navigation globale
  static final navigator = TDAHelpeApp.navigatorKey.currentState;

  /// Navigue vers n'importe quelle page
  ///
  /// Méthode générique pour la navigation

  static Future<T?> push<T>(BuildContext context, Widget page) {
    if (Platform.isIOS) {
      // iOS : Animation native avec swipe back automatique ✅
      return Navigator.push<T>(
        context,
        CupertinoPageRoute<T>(
          builder: (_) => page,
          // L'animation de CupertinoPageRoute ressemble déjà à ton slide !
        ),
      );
    } else {
      // Android avec animation personnalisée
      return Navigator.push<T>(
        context,
        PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: _slideTransition,
        ),
      );
    }
  }

  /// Remplace la page actuelle
  static Future<T?> replaceTo<T>(BuildContext context, Widget page) async {
   
      if (Platform.isIOS) {
        // iOS : Animation native avec swipe back automatique ✅
        return Navigator.pushReplacement<T, void>(
          context,
          CupertinoPageRoute<T>(
            builder: (_) => page,
            // L'animation de CupertinoPageRoute ressemble déjà à ton slide !
          ),
        );
      } else {
        print("⚠️ push remplacement");
        return Navigator.pushReplacement<T, void>(
          context,
          PageRouteBuilder<T>(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder: _slideTransition,
          ),
        );
      }
   
  }

  /// Retour à la page précédente
  static void goBack<T>([T? result]) {
    if (navigator != null && navigator!.canPop()) {
      navigator!.pop(result);
    }
  }

  /// Retour à la racine (équivalent de pushAndRemoveUntil)
  static void goToRoot() {
    if (navigator != null) {
      navigator!.popUntil((route) => route.isFirst);
    }
  }

  static Widget _slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(position: animation.drive(tween), child: child);
  }
}
