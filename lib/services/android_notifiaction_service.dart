import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AndroidNotifiactionService {
  static const platform = MethodChannel('alarm_channel');

  static Future<bool> isOpenedFromNotificationAndroid() async {
    try {
      final result = await platform.invokeMethod('getNotificationData');
      return result != null;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur Android: $e');
      }
      return false;
    }
  }

  static Future<bool> hasAllPermissions() async {
    if (Platform.isAndroid) {
      try {
        final bool? canSchedule = await platform.invokeMethod(
          'checkPermissions',
        );

        if (canSchedule == false) {
          if (kDebugMode) {
            print('❌ Permission SCHEDULE_EXACT_ALARM manquante');
          }
          return false;
        }

        if (kDebugMode) {
          print('✅ Toutes les permissions Android accordées');
        }
        return true;
      } catch (e) {
        if (kDebugMode) {
          print('⚠️ Erreur vérification permissions: $e');
        }
        return false;
      }
    }

    return true;
  }


  

}
