import 'package:flutter/foundation.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class TimezoneConfig {
  /// Configure le fuseau horaire local pour les notifications
  static Future<void> initialize() async {
    tz_data.initializeTimeZones();

    final String systemTimeZone = DateTime.now().timeZoneName;
    final String locationName = _getLocationName(systemTimeZone);

    // Essayer dans l'ordre : détecté → Europe/Paris → UTC
    await _trySetLocation(locationName) ||
        await _trySetLocation('Europe/Paris') ||
        await _trySetLocation('UTC');
  }

  /// Convertit le nom du fuseau système en nom de location timezone
  static String _getLocationName(String systemTimeZone) {
    // Map des fuseaux horaires connus
    const timezoneMap = {
      'CEST': 'Europe/Paris',
      'CET': 'Europe/Paris',
      'EST': 'America/Toronto',
      'EDT': 'America/Toronto',
      'PST': 'America/Vancouver',
      'PDT': 'America/Vancouver',
      'MST': 'America/Edmonton',
      'MDT': 'America/Edmonton',
      'CST': 'America/Winnipeg',
      'CDT': 'America/Winnipeg',
      'AST': 'America/Halifax',
      'ADT': 'America/Halifax',
    };

    // Si le fuseau est dans la map, retourner la location
    if (timezoneMap.containsKey(systemTimeZone)) {
      return timezoneMap[systemTimeZone]!;
    }

    // Si c'est déjà un nom complet (contient '/'), le retourner tel quel
    if (systemTimeZone.contains('/')) {
      return systemTimeZone;
    }

    // Sinon, retourner tel quel en espérant que ça fonctionne
    return systemTimeZone;
  }

  /// Essaie de configurer un fuseau horaire

  static Future<bool> _trySetLocation(String locationName) async {
    try {
      tz.setLocalLocation(tz.getLocation(locationName));
      if (kDebugMode) {
        print('✅ Fuseau horaire configuré : $locationName');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Échec configuration fuseau $locationName : $e');
      }
      return false;
    }
  }
}
