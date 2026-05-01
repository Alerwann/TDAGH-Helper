import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/services/notifications/notification_service.dart';

/// Gère la programmation automatique des alarmes au démarrage
class AlarmScheduler {
  /// Programme toutes les alarmes en fonction des heures du profil
 static Future<void> scheduleOnStartup(BuildContext context) async {
    try {
      final profil = Provider.of<HeureProfilProvider>(context, listen: false);

      // ✅ Timeout pour éviter boucle infinie
      int attempts = 0;
      while (profil.isLoading && attempts < 50) {
        // Max 5 secondes
        await Future.delayed(Duration(milliseconds: 100));
        attempts++;
      }

      if (profil.isLoading) {
        throw TimeoutException('Profil non chargé après 5 secondes');
      }

      // if (kDebugMode) {
      //   print('🔔 Programmation des alarmes automatiques');
      //   print('   Réveil: ${profil.reveilHours}h');
      //   // ...
      // }

      await NotificationService.scheduleAllNotifications(
        reveilHour: profil.reveilHours,
        midiHour: profil.midiHours,
        soirHour: profil.soirHours,
        coucherHour: profil.coucherHours,
      );

      if (kDebugMode) {
        print('✅ Alarmes programmées avec succès');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ Erreur programmation alarmes: $e');
        print('Stack: $stackTrace');
      }
      // ✅ Optionnel : informer l'utilisateur
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.erreurMajRappel),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
