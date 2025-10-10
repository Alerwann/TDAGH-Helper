import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdahelpe/pages/ProfilsPages/profil.dart';
import 'package:tdahelpe/pages/SuiviScores/accueil_score.dart';
import 'package:tdahelpe/pages/home_page.dart';
import 'package:tdahelpe/providers/bonus_level_provider.dart';
import 'package:tdahelpe/providers/defoule_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/sound_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:tdahelpe/services/notification_service.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/pages/Bingo/general_bingo_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await NotificationService.initialize();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
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
            soundProvider.initialize();
            return soundProvider;
          },
        ),
        ChangeNotifierProvider(create: (context) => TachesProvider()),
        ChangeNotifierProvider(create: (contex) => DefouleProvider()),
        ChangeNotifierProvider(create: (contex) => BonusLevelProvider()),
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
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _hasCheckedNotification = false;

  setCurrentIndex(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNotificationLaunch();
      _scheduleAlarmsOnStartup();
    });
  }

  Future<void> _scheduleAlarmsOnStartup() async {
    try {
      final profil = Provider.of<HeureProfilProvider>(context, listen: false);

      int retries = 0;
      while (profil.midiHours == 12 && retries < 10) {
        await Future.delayed(Duration(milliseconds: 200));
        retries++;
      }

      if (kDebugMode) {
        print('🔔 Programmation automatique des alarmes au démarrage...');
      }
      if (kDebugMode) {
        print('   Provider chargé après ${retries * 200}ms');
      }

      await NotificationService.scheduleAllNotifications(
        reveilHour: profil.reveilHours,
        midiHour: profil.midiHours,
        soirHour: profil.soirhours,
        coucheHour: profil.coucheHours,
      );

      if (kDebugMode) {
        if (kDebugMode) {}
        print('✅ Alarmes programmées automatiquement au démarrage');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur programmation alarmes au démarrage: $e');
      }
    }
  }

  Future<void> _checkNotificationLaunch() async {
    if (_hasCheckedNotification) {
      print('ℹ️ Notification déjà vérifiée, skip');
      return;
    }
    await Future.delayed(Duration(milliseconds: 500));

    final notificationData = await NotificationService.getNotificationData();

    if (notificationData != null && notificationData['openBingo'] == true) {
      final String moment = notificationData['moment'];

      print('🚀 Navigation demandée vers Bingo: $moment');

      // ✅ AJOUTE : Vérifier si on peut accéder à ce moment
      final profil = Provider.of<HeureProfilProvider>(context, listen: false);

      if (_isMomentAccessible(moment, profil)) {
        print('✅ Accès autorisé');
        _hasCheckedNotification = true;
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => BingoGamePreview(titleMoment: moment),
          ),
        );
      } else {
        print('⚠️ Accès refusé (hors horaire)');
        // Optionnel : Afficher un message à l'utilisateur
        Future.delayed(Duration(milliseconds: 1000), () {
          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text('⏰ La période $moment n\'est plus accessible'),
              backgroundColor: Colors.orange,
            ),
          );
        });
      }
    } else {
      _hasCheckedNotification = true;
    }
  }

  bool _isMomentAccessible(String moment, HeureProfilProvider profil) {
    final now = DateTime.now();

    switch (moment) {
      case 'Matin':
        return now.hour <= profil.midiHours + 1 &&
            now.hour >= profil.reveilHours - 1;
      case 'Midi':
        return now.hour <= profil.soirhours + 1 &&
            now.hour >= profil.midiHours - 1;
      case 'Soir':
        return now.hour <= profil.coucheHours + 1 &&
            now.hour >= profil.soirhours - 1;
      case 'Couché':
        return now.hour >= profil.coucheHours - 1 &&
            now.hour <= profil.reveilHours + 1;
      default:
        return false;
    }
  }

 
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
          height: 65,
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
              title: 'Scores',
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
