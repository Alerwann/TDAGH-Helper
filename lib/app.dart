import 'package:flutter/material.dart';
import 'package:tdahelpe/Theme/app_theme.dart';
import 'package:tdahelpe/pages/home/home_shell.dart';

/// Widget racine de l'application TDAHelpe
///
/// Gère :
/// - La configuration du thème (light/dark)
/// - La navigation globale
/// - Le titre de l'app
class TDAHelpeApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const TDAHelpeApp({super.key});

  @override
  Widget build(BuildContext context) {
 
    return MaterialApp(
      // Configuration de la navigation
      navigatorKey: navigatorKey,

      // Configuration de base
      debugShowCheckedModeBanner: false,
      title: 'TDAHelpe',

      // Thèmes
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Page d'accueil
      home: HomeShell(),
    );
  }
}
