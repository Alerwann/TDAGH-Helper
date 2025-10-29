import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';
import 'package:tdahelpe/utils/device_utils.dart';

class ShowPermissionExplanationDialog {
  static void showdial(BuildContext context, mounted) async {
    print("❓👀 Shodial début");

    _checkIfShouldShowDialog().then((shouldshow) {
      print("😶‍🌫️ schoow et mounted?");
      if (shouldshow && mounted) {
        _dayliMessageShow(context);
      }
    });
  }

  static Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  static Future<bool> _checkIfShouldShowDialog() async {
    print("😶‍🌫️ check si on show");
    final prefs = await SharedPreferences.getInstance();
    final lastShown = prefs.getInt('last_permission_dialog_shown') ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Afficher le dialog maximum 1 fois par jour
    const oneDayInMillis = 24 * 60 * 60 * 1000;

    return (now - lastShown) > oneDayInMillis;
  }

  static Future<void> _markDialogShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      'last_permission_dialog_shown',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  static void showOpenSettingsDialog(BuildContext context) async {
    bool isAndroidOther = await DeviceUtils.isBatteryOptimizationNeeded();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('⚠️ Permissions manquantes'),
        content: 
        isAndroidOther?
        Text(   'Pour que les notifications fonctionnent, tu dois :\n\n'
              "1. Dans les paramètres de l'application, puis batterie choisir : Pas de restriction\n"
              '2. Décoché interrompre l\'activité \n'
              '3. Autoriser les notifications\n\n'
              'Clique sur "Ouvrir" pour accéder aux paramètres.')
        :Text(
          'Pour que les notifications fonctionnent, tu dois les activer dans les paramètres.\n\n'
          'Veux-tu ouvrir les paramètres maintenant ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Plus tard'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (Platform.isAndroid) {
                AndroidNotificationHandler.openSettingsAndroid();
              } else if (Platform.isIOS) {}
            },
            child: Text('Ouvrir les paramètres'),
          ),
        ],
      ),
    );
  }

  static void firstTextApparition(BuildContext context) {
    print("✅ First lunch dialogue message");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.notifications_active, color: Colors.orange),
            SizedBox(width: 10),
            Text('Notifications'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TDAHelpe utilise des notifications pour :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildBulletPoint('📅 Te rappeler tes tâches quotidiennes'),
            _buildBulletPoint('🎯 Ne rien oublier dans ta routine '),
            Text('Tu recevras au maximum 4 notifications par jour.'),
            Text(
              "L'acception ou non des notifications est disponible dans les paramètres.",
            ),

          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _markDialogShown();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  static void _dayliMessageShow(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.notifications_active, color: Colors.orange),
            SizedBox(width: 10),
            Text('Notifications'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TDAHelpe utilise des notifications pour :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildBulletPoint('📅 Te rappeler tes tâches quotidiennes'),
            _buildBulletPoint('🎯 Ne rien oublier dans ta routine'),
            Text('Tu recevras au maximum 4 notifications par jour.'),
            Text(
              "La modification de l'acception ou non des notifications est disponible dans les paramètres.",
            ),
            SizedBox(height: 15),
            Text(
              'Sans les notifications, l\'app fonctionnera, mais tu n\'auras pas de rappels automatiques.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _markDialogShown();
            },
            child: Text('Pas maintenant'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              // Demander les permissions
              if (Platform.isAndroid) {
                await AndroidNotificationHandler.requestPermissions();

                // Vérifier si accordées
                final hasPermissions =
                    await AndroidNotificationHandler.checkPermissions();

                if (!hasPermissions) {
                  // Proposer d'ouvrir les paramètres
                  showOpenSettingsDialog(context);
                }
              }
            },
            child: Text('Autoriser'),
          ),
        ],
      ),
    );
  }
}
