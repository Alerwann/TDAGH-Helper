import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/core/navigation/app_navigator.dart';
import 'package:tdahelpe/pages/ProfilsPages/profil.dart';
import 'package:tdahelpe/pages/SuiviScores/accueil_score.dart';
import 'package:tdahelpe/pages/home_page.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/services/notifications/notification_service.dart';

/// Shell principal de l'application avec bottom navigation
/// 
/// Gère :
/// - La navigation entre les 3 pages principales
/// - La programmation des alarmes au démarrage
/// - L'initialisation de la navigation pour les notifications
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell>
    with WidgetsBindingObserver, MethodChannelMixin {
  int _currentIndex = 0;

  // Les 3 pages principales
  final List<Widget> _pages = [
    HomeGlobalPage(),
    AccueilScore(),
    ProfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    
    // Observer le cycle de vie
    WidgetsBinding.instance.addObserver(this);
    
    // Configuration du MethodChannel pour Android
    setupMethodChannel();

    // Initialisation post-frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  /// Initialise tout ce qui nécessite un context
  Future<void> _initialize() async {
    // Initialiser la navigation pour les notifications
    await AppNavigator.initialize();
    
    // Programmer les alarmes
    await _scheduleAlarmsOnStartup();
  }

  /// Programme toutes les alarmes au démarrage
  Future<void> _scheduleAlarmsOnStartup() async {
    try {
      final profil = Provider.of<HeureProfilProvider>(
        context,
        listen: false,
      );

      // Attendre que le provider soit chargé
      if (profil.isLoading) {
        await Future.doWhile(() async {
          await Future.delayed(Duration(milliseconds: 100));
          return profil.isLoading;
        });
      }

      if (kDebugMode) {
        print('🔔 Programmation automatique des alarmes...');
      }

      await NotificationService.scheduleAllNotifications(
        reveilHour: profil.reveilHours,
        midiHour: profil.midiHours,
        soirHour: profil.soirHours,
        coucheHour: profil.coucheHours,
      );
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur programmation alarmes: $e');
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AppNavigator.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print('📱 App revenue au premier plan');
      }
      // Revérifier les notifications en attente
      AppNavigator.initialize();
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

/// Mixin pour gérer le MethodChannel Android
mixin MethodChannelMixin {
  static const platform = MethodChannel('alarm_channel');

  void setupMethodChannel() {
    platform.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == 'onNotificationTapped') {
      if (kDebugMode) {
        print('🔔 Notification tapée détectée depuis Kotlin !');
      }
      await AppNavigator.initialize();
    }
  }
}
