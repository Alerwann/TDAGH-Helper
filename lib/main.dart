import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdahelpe/Theme/app_theme.dart';
import 'package:tdahelpe/pages/Bingo/homepage.dart';
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
import 'package:tdahelpe/services/notification_global_service.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';

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
  static const platform = MethodChannel('alarm_channel');

  void setCurrentIndex(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    platform.setMethodCallHandler(_handleMethodCall);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNotificationLaunch();
      _scheduleAlarmsOnStartup();
    });
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == 'onNotificationTapped') {
      print("🔔 Notification tapée détectée depuis Kotlin !");
      await _checkNotificationLaunch();
    }
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
    // Attendre un peu que tout soit chargé
    await Future.delayed(Duration(milliseconds: 500));

    // Vérifier si ouvert depuis notification
    final isFromNotification =
        await NotificationService.isOpenedFromNotification();

    print("❓ Ouvert depuis notification ? $isFromNotification");

    if (isFromNotification) {
      print('🚀 Navigation vers Bingo');
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => HomeBingoPage()),
      );
    } else {
      print('ℹ️ Ouverture normale de l\'app');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
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
