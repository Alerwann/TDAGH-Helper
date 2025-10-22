import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/app.dart';
import 'package:tdahelpe/core/initialization/app_initializer.dart';
import 'package:tdahelpe/providers/bonus_level_provider.dart';
import 'package:tdahelpe/providers/defoule_provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/sound_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';

void main() async {
  // 1. Initialisation Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Configuration de l'orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 3. Initialisation des services
  await AppInitializer.initialize();

  // 4. Lancement de l'app
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
      child: TDAHelpeApp(),
    ),
  );
}
