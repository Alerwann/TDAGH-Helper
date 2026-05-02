import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/Theme/app_theme.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/l10n/l10n.dart';
import 'package:tdahelpe/pages/home/home_shell.dart';
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

  // 1. Configuration orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 2. Initialisation des préférences et du Provider de profil
  final prefs = await SharedPreferences.getInstance();
  final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

  // On crée le ProfilProvider et on attend que _loadData soit terminé
  final profilProvider = ProfilProvider();

  try {
    print("🤩 try entrer main");
    await NotificationService.initialize();
  } catch (e) {
    if (kDebugMode) print('⚠️ Erreur init notifications: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScoreProvider()),
        ChangeNotifierProvider(create: (_) => HeureProfilProvider()),
        // On utilise .value car profilProvider est déjà créé et initialisé
        ChangeNotifierProvider.value(value: profilProvider),
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
      child: MyApp(onboardingCompleted: onboardingCompleted),
    ),
  );
}

class MyApp extends StatelessWidget {

  final bool onboardingCompleted;
  const MyApp({super.key, required this.onboardingCompleted});

  @override
  Widget build(BuildContext context) {
    
    // 4. Ecouter le ProfilProvider pour la langue
    final profil = context.watch<ProfilProvider>();
    print("⚠️ ${profil.locale}");
    return MaterialApp(
      // Configuration de la langue dynamique
      locale: profil.locale,

      debugShowCheckedModeBanner: false,
      title: 'TDAHelpe',

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.locals,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      home: onboardingCompleted ? const HomeShell() : const OnboardingPage(),
      routes: {'/home': (context) => const HomeShell()},
    );
  }
}
