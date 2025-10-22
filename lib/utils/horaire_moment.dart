import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';


class HoraireMoment {
  static bool isMomentAccessible(String moment, BuildContext context) {
    final now = DateTime.now();
    final profil = Provider.of<HeureProfilProvider>(context, listen: false);

    switch (moment) {
      case 'Matin':
        return now.hour <= profil.midiHours + 1 &&
            now.hour >= profil.reveilHours - 1;
      case 'Midi':
        return now.hour <= profil.soirHours + 1 &&
            now.hour >= profil.midiHours - 1;
      case 'Soir':
        return now.hour <= profil.coucheHours + 1 &&
            now.hour >= profil.soirHours - 1;
      case 'Couché':
        int heureDebut = profil.coucheHours - 1;
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
        return [profil.soirHours - 1, profil.coucheHours + 1];
      case 'couché':
        if (profil.coucheHours + 4 >= 24) {
          return [profil.coucheHours - 1, profil.coucheHours + 4 - 24];
        } else {
          return [profil.coucheHours - 1, profil.coucheHours + 4];
        }
      default:
        return [25, 25];
    }
  }

  static int convertMomentName(String moment, HeureProfilProvider profil) {
    switch (moment) {
      case 'réveil':
        return profil.reveilHours;

      case 'repas de midi':
        return profil.midiHours;

      case 'repas du soir':
        return profil.soirHours;

      case 'couché':
        return profil.coucheHours;

      case 'réinitialisation':
        return profil.reinitHours;
      default:
        return 12;
    }
  }

}
