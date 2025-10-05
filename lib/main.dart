import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:tdahelpe/pages/ProfilsPages/profil.dart';
import 'package:tdahelpe/pages/SuiviScores/accueil_score.dart';
import 'package:tdahelpe/pages/home_page.dart';
import 'package:tdahelpe/providers/defoule_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/sound_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:tdahelpe/services/notification_service.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await NotificationService.initialize();
  } catch (e) {
    print(e);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScoreProvider()),
        ChangeNotifierProvider(create: (context) => HeureProfilProvider()),
        ChangeNotifierProvider(create: (context) => ProfilProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final soundProvider = SoundProvider();
            soundProvider
                .initialize(); // Lance l'initialisation dès la création
            return soundProvider;
          },
        ),
        ChangeNotifierProvider(create: (context) => TachesProvider()),
        ChangeNotifierProvider(create: (contex) => DefouleProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyScoreProvider();
}

class _MyScoreProvider extends State<MyApp> {
  int _currentindex = 0;

  setCurrentIndex(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(181, 212, 149, 216),

          secondary: const Color.fromARGB(255, 6, 110, 75),
          primaryContainer: const Color.fromARGB(155, 193, 187, 187),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 10,

            iconSize: 40,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            side: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
      ),
      home: Scaffold(
        body: [HomeGlobalPage(), AccueilScore(), ProfilPage()][_currentindex],

        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          backgroundColor: Colors.purple,
          color: Colors.white,
          activeColor: Colors.white,
          initialActiveIndex: _currentindex,
          height: 75,
          items: [
            TabItem(
              icon: Icon(Icons.home, size: 25, color: Colors.white),
              title: 'Accueil',
            ),
            TabItem(
              icon: Icon(
                HugeIconsSolid.gameController02,
                size: 25,
                color: Colors.white,
              ),
              title: 'Scores', // Texte plus court
            ),

            TabItem(
              icon: Icon(
                HugeIconsSolid.settings01,
                size: 25,
                color: Colors.white,
              ),
              title: 'Paramètre',
            ),
          ],
          onTap: (int i) => setCurrentIndex(i),
        ),
      ),
    );
  }
}
