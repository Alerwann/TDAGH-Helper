import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/core/startup/alarm_scheduler.dart';
import 'package:tdahelpe/core/startup/notification_handler.dart';
import 'package:tdahelpe/pages/ProfilsPages/profil.dart';
import 'package:tdahelpe/pages/SuiviScores/accueil_score.dart';
import 'package:tdahelpe/pages/home_page.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/services/notifications/notification_service.dart';
import 'package:tdahelpe/utils/permission_state.dart';
import 'package:tdahelpe/widget/specific/show_permission_explanation_dialog.dart';

/// Shell principal avec la navigation bottom bar
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> with WidgetsBindingObserver {
  int _currentIndex = 0;
  static const _methodChannel = MethodChannel('alarm_channel');

  @override
  void initState() {
    super.initState();
    print("🤯 notificaiton init home shell");
    // Observer le cycle de vie
    WidgetsBinding.instance.addObserver(this);

    // Configuration du canal Android
    _methodChannel.setMethodCallHandler(_handleMethodCall);

    // Initialisation post-frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
      _checkFirstLaunch();
    });
  }

  Future<void> _initialize() async {
    print("🤯 notificaiton init home shell fonction _initialize");

    await NotificationHandler.initialize();

    await AlarmScheduler.scheduleOnStartup(context);
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();

    final isFirstLaunch = prefs.getBool('first_launch') ?? true;

    // print("👀 isfirstlunch : $isFirstLaunch");

    if (isFirstLaunch) {
      await prefs.setBool('first_launch', false);

      // Afficher le dialog explicatif
      if (mounted) {
        ShowPermissionExplanationDialog.firstTextApparition(context);
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      print('📱 App est au premier plan - Vérification des permissions');

      final scoreP = Provider.of<ScoreProvider>(context, listen: false);

      bool resumePermission = await NotificationService.checkAllPermission();
      PermissionState.notifyPermissionChanged(!resumePermission);
      if (mounted && !resumePermission) {
        // print("👀 show permision dial");
        ShowPermissionExplanationDialog.showdial(context, mounted);
      }
      if (mounted) {
        scoreP.checkAndReset();
      }
    }
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
  Widget build(BuildContext context) {
    final List<Widget> pages = [HomeGlobalPage(), AccueilScore(), ProfilPage()];
    return Scaffold(
      body: pages[_currentIndex],
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
