import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/app.dart';
import 'package:tdahelpe/pages/onboarding/onbording_page.dart';
import 'package:tdahelpe/providers/bonus_level_provider.dart';
import 'package:tdahelpe/providers/defoule_provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/sound_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:tdahelpe/services/notifications/notification_service.dart';

void main() async {
  print("🤙 main lancement gouzi");
  WidgetsFlutterBinding.ensureInitialized();

  // Configuration orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final prefs = await SharedPreferences.getInstance();
  final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;
  // Initialisation notifications
  try {
    await NotificationService.initialize();
    
  } catch (e) {
    if (kDebugMode) print('⚠️ Erreur init notifications: $e');
  }

  // Lancement app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScoreProvider()),
        ChangeNotifierProvider(create: (_) => HeureProfilProvider()),
        ChangeNotifierProvider(create: (_) => ProfilProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final soundProvider = SoundProvider();
            soundProvider.initialize();
            return soundProvider;
          },
        ),
        ChangeNotifierProvider(create: (_) => TachesProvider()),
        ChangeNotifierProvider(create: (_) => DefouleProvider()),
        ChangeNotifierProvider(create: (_) => BonusLevelProvider()),
      ],
      child: MaterialApp(
        home: onboardingCompleted ? TDAHelpeApp() : OnboardingPage(),
        routes: {'/home': (context) => TDAHelpeApp()},
      ),
    ),
  );
}
