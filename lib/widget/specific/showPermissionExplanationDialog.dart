import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';

class ShowPermissionExplanationDialog {
  static void showdial(BuildContext context, mounted) async {
    _checkIfShouldShowDialog().then((shouldshow) {
      if (shouldshow && mounted) {
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
                    await AndroidNotificationHandler.requestPermissions(
                      FlutterLocalNotificationsPlugin(),
                    );

                    // Vérifier si accordées
                    final hasPermissions =
                        await AndroidNotificationHandler.checkPermissions();

                    if (!hasPermissions) {
                      // Proposer d'ouvrir les paramètres
                      _showOpenSettingsDialog(context);
                    }
                  }
                },
                child: Text('Autoriser'),
              ),
            ],
          ),
        );
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

  static void _showOpenSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('⚠️ Permissions manquantes'),
        content: Text(
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
              AndroidNotificationHandler.openSettings();
            },
            child: Text('Ouvrir les paramètres'),
          ),
        ],
      ),
    );
  }
}
