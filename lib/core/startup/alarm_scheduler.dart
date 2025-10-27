import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/services/notifications/notification_service.dart';

/// Gère la programmation automatique des alarmes au démarrage
class AlarmScheduler {
  /// Programme toutes les alarmes en fonction des heures du profil
  static Future<void> scheduleOnStartup(BuildContext context) async {
    try {
      final profil = Provider.of<HeureProfilProvider>(context, listen: false);

      // Attendre que le provider soit chargé
      if (profil.isLoading) {
     
          print('⏳ Attente du chargement du profil...');
      

        await Future.doWhile(() async {
          await Future.delayed(Duration(milliseconds: 100));
          return profil.isLoading;
        });
      }


        print('🔔 Programmation des alarmes automatiques');
        print('   Réveil: ${profil.reveilHours}h');
        print('   Midi: ${profil.midiHours}h');
        print('   Soir: ${profil.soirHours}h');
        print('   Coucher: ${profil.coucherHours}h');
    

      await NotificationService.scheduleAllNotifications(
        reveilHour: profil.reveilHours,
        midiHour: profil.midiHours,
        soirHour: profil.soirHours,
        coucherHour: profil.coucherHours,
      );

      if (kDebugMode) {
        // print('✅ Alarmes programmées avec succès');
      }
    } catch (e) {
      if (kDebugMode) {
        // print('❌ Erreur programmation alarmes: $e');
      }
    }
  }
}
