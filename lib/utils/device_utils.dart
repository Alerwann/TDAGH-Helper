import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:tdahelpe/services/notification_global_service.dart';

class DeviceUtils {
  static bool isBatteryOptimizationNeeded() {
    if (!Platform.isAndroid) return false;

    final brand = Platform.operatingSystemVersion.toLowerCase();
    return brand.contains('xiaomi') ||
        brand.contains('huawei') ||
        brand.contains('oppo') ||
        brand.contains('vivo') ||
        brand.contains('realme') ||
        brand.contains('oneplus');
  }

  static void testAndroid(BuildContext context) async {
    if (Platform.isAndroid) {
      bool hasPermission = await NotificationService.checkPermissions();

      if (!hasPermission) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Permission requise'),
            content: Text(
              'Pour que les notifications fonctionnent, tu dois :\n\n'
              '1. Autoriser les "Alarmes et rappels"\n'
              '2. Désactiver l\'optimisation batterie\n'
              '3. Activer le démarrage automatique\n\n'
              'Clique sur "Ouvrir" pour accéder aux paramètres.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  NotificationService.openSettings();
                },
                child: Text('Ouvrir'),
              ),
            ],
          ),
        );
        return;
      }
    }
  }
}
