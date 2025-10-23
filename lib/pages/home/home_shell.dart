import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:tdahelpe/core/startup/alarm_scheduler.dart';
import 'package:tdahelpe/core/startup/notification_handler.dart';
import 'package:tdahelpe/pages/ProfilsPages/profil.dart';
import 'package:tdahelpe/pages/SuiviScores/accueil_score.dart';
import 'package:tdahelpe/pages/home_page.dart';

/// Shell principal avec la navigation bottom bar
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> with WidgetsBindingObserver {
  int _currentIndex = 0;
  static const _methodChannel = MethodChannel('alarm_channel');

  final List<Widget> _pages = [HomeGlobalPage(), AccueilScore(), ProfilPage()];

  @override
  void initState() {
    super.initState();

    // Observer le cycle de vie
    WidgetsBinding.instance.addObserver(this);

    // Configuration du canal Android
    _methodChannel.setMethodCallHandler(_handleMethodCall);

    // Initialisation post-frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  /// Initialise les services au démarrage
  Future<void> _initialize() async {
    await NotificationHandler.initialize();
    await AlarmScheduler.scheduleOnStartup(context);
  }

  /// Gère les appels depuis le code natif (Android)
  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == 'onNotificationTapped') {
      if (kDebugMode) {
        print('🔔 Notification tapée (depuis Kotlin)');
      }
      await NotificationHandler.initialize();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    NotificationHandler.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print('📱 App revenue au premier plan');
      }
      NotificationHandler.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.purple,
        color: Colors.white,
        activeColor: Colors.white,
        initialActiveIndex: _currentIndex,
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
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
