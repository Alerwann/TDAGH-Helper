import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/core/startup/alarm_scheduler.dart';
import 'package:tdahelpe/core/startup/notification_handler.dart';
import 'package:tdahelpe/pages/ProfilsPages/profil.dart';
import 'package:tdahelpe/pages/SuiviScores/accueil_score.dart';
import 'package:tdahelpe/pages/home_page.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';
import 'package:tdahelpe/widget/specific/showPermissionExplanationDialog.dart';

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // L'app revient au premier plan
      if (kDebugMode) {
        print('📱 App revenue au premier plan - Vérification des permissions');
      }

      // ✅ VÉRIFIE LES PERMISSIONS
      _checkPermissionsOnResume();

      // Ton code existant pour les notifications
      NotificationHandler.initialize();
    }
  }

  Future<void> _checkPermissionsOnResume() async {
    if (Platform.isAndroid) {
      final hasPermissions =
          await AndroidNotificationHandler.checkPermissions();

      if (!hasPermissions) {
        // Stocker qu'il faut afficher un warning
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('needs_permission_warning', true);

        if (kDebugMode) {
          print('⚠️ Permissions manquantes détectées');
        }

        // Afficher un dialog
        if (mounted) {}
      }
    } else if (Platform.isIOS) {
      // Pour iOS, on peut aussi vérifier
      final plugin = FlutterLocalNotificationsPlugin();
      final granted = await plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      if (granted == false) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('needs_permission_warning', true);

        if (mounted) {
          ShowPermissionExplanationDialog.showdial(context, mounted);
          
        }
      }
    }
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
