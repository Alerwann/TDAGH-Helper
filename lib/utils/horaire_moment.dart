import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';

class HoraireMoment {
  static bool isMomentAccessible(String moment, BuildContext context) {
    final now = DateTime.now();
    final profil = Provider.of<HeureProfilProvider>(context, listen: false);

    switch (moment.toLowerCase()) {
      case 'matin':
        return now.hour <= profil.midiHours + 1 &&
            now.hour >= profil.reveilHours - 1;
      case 'mid':
        return now.hour <= profil.soirHours + 1 &&
            now.hour >= profil.midiHours - 1;
      case 'soir':
        return now.hour <= profil.coucherHours + 1 &&
            now.hour >= profil.soirHours - 1;
      case 'coucher':
        int heureDebut = profil.coucherHours - 1;
        int dureeAcces = 4;

        if (heureDebut + dureeAcces >= 24) {
          int heureFin = (heureDebut + dureeAcces) - 24;
          return (now.hour >= heureDebut) || (now.hour <= heureFin);
        } else {
          return now.hour >= heureDebut &&
              now.hour <= (heureDebut + dureeAcces);
        }

      default:
        return false;
    }
  }

  static List<int> momentPhrase(String moment, BuildContext context) {
    final profil = Provider.of<HeureProfilProvider>(context, listen: false);

    switch (moment.toLowerCase()) {
      case 'matin':
        return [profil.reveilHours - 1, profil.midiHours + 1];
      case 'midi':
        return [profil.midiHours - 1, profil.soirHours + 1];
      case 'soir':
        return [profil.soirHours - 1, profil.coucherHours + 1];
      case 'coucher':
        if (profil.coucherHours + 4 >= 24) {
          return [profil.coucherHours - 1, profil.coucherHours + 4 - 24];
        } else {
          return [profil.coucherHours - 1, profil.coucherHours + 4];
        }
      default:
        return [25, 25];
    }
  }

  static int convertMomentName(String moment, HeureProfilProvider profil) {
    switch (moment.toLowerCase()) {
      case 'reveil':
        return profil.reveilHours;

      case 'repas de midi':
        return profil.midiHours;

      case 'repas du soir':
        return profil.soirHours;

      case 'coucher':
        return profil.coucherHours;

      case 'réinitialisation':
        return profil.reinitHours;
      default:
        return 12;
    }
  }
}
