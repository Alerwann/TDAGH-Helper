import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';
import 'package:tdahelpe/services/notifications/ios_notification_handler.dart';
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
        title: Text(AppLocalizations.of(context)!.permissionMiss),
        content: isAndroidOther
            ? Text(
                AppLocalizations.of(context)!.instructionsAndroidNotifications,
              )
            : Text(
               AppLocalizations.of(context)!.instructionsIOSNotifications,
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
              } else if (Platform.isIOS) {
                print("👻 iphone");
                IosNotificationHandler.openSettingsIos();
              }
            },
            child: Text(AppLocalizations.of(context)!.ouvrirParam),
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
            Text(AppLocalizations.of(context)!.notifications),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.decriptionNotif,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildBulletPoint(AppLocalizations.of(context)!.rappelTask),
            _buildBulletPoint(AppLocalizations.of(context)!.routineHelp),
            Text(AppLocalizations.of(context)!.nombreNotif),
            Text(AppLocalizations.of(context)!.notifChoix),
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
            Text(AppLocalizations.of(context)!.notifications),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.decriptionNotif,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildBulletPoint(AppLocalizations.of(context)!.rappelTask),
            _buildBulletPoint(AppLocalizations.of(context)!.routineHelp),
            Text(AppLocalizations.of(context)!.nombreNotif),
            Text(AppLocalizations.of(context)!.modifNotifChoix),
            SizedBox(height: 15),
            Text(
              AppLocalizations.of(context)!.refusNotif,
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
            child: Text(AppLocalizations.of(context)!.notNow),
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
              } else if (Platform.isIOS) {
                IosNotificationHandler.openSettingsIos();
              }
              _markDialogShown();
            },
            child: Text(AppLocalizations.of(context)!.autorise),
          ),
        ],
      ),
    );
  }
}
