import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';

class DeviceUtils {
  static Future<bool> isBatteryOptimizationNeeded() async {
    if (!Platform.isAndroid) return false;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    String brand = androidInfo.brand.toLowerCase();

    print("😵 la marque. : $brand");

    return brand.contains('xiaomi') ||
        brand.contains('huawei') ||
        brand.contains('oppo') ||
        brand.contains('vivo') ||
        brand.contains('realme') ||
        brand.contains('oneplus');
  }

  static void dialogAndroidOther (BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.permSup),
        content: Text(
          AppLocalizations.of(context)!.explainAndPermsup
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.annuler),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              AndroidNotificationHandler.openSettingsAndroid();
            },
            child: Text(AppLocalizations.of(context)!.ouvrir),
          ),
        ],
      ),
    );
  }
}
