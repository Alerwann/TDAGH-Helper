import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class HoraireMoment {
  static bool isMomentAccessible(String moment, BuildContext context) {
    final now = DateTime.now();
    final profil = Provider.of<HeureProfilProvider>(context, listen: false);

    switch (moment) {
      case 'Matin':
        return now.hour <= profil.midiHours + 1 &&
            now.hour >= profil.reveilHours - 1;
      case 'Midi':
        return now.hour <= profil.soirhours + 1 &&
            now.hour >= profil.midiHours - 1;
      case 'Soir':
        return now.hour <= profil.coucheHours + 1 &&
            now.hour >= profil.soirhours - 1;
      case 'Couché':
        if (profil.coucheHours + 4 >= 24) {
          return now.hour >= profil.coucheHours - 1 &&
              now.hour <= profil.coucheHours - 16;
        } else {
          return now.hour >= profil.coucheHours - 1 &&
              now.hour <= profil.coucheHours + 4;
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
        return [profil.midiHours - 1, profil.soirhours + 1];
      case 'soir':
        return [profil.soirhours - 1, profil.coucheHours + 1];
      case 'couché':
        if (profil.coucheHours + 4 >= 24) {
          return [profil.coucheHours - 1, profil.coucheHours - 16];
        } else {
          return [profil.coucheHours - 1, profil.coucheHours + 4];
        }
      default:
        return [25, 25];
    }
  }

  static Widget horairesModif(
    String moment,
    String momentsend,
    BuildContext context,
  ) {
    return Column(
      spacing: 5,
      children: [
        CustomText.center(
          'Heure du $moment',
          Theme.of(context).textTheme.headlineMedium,
        ),

        Row(
          children: [
            Expanded(
              child: Consumer<HeureProfilProvider>(
                builder: (context, profil, child) {
                  int momentProfil = 12;

                  switch (moment) {
                    case 'réveil':
                      momentProfil = profil.reveilHours;
                      break;
                    case 'repas de midi':
                      momentProfil = profil.midiHours;
                      break;
                    case 'repas du soir':
                      momentProfil = profil.soirhours;
                      break;
                    case 'couché':
                      momentProfil = profil.coucheHours;
                      break;
                    case 'réinitialisation':
                      momentProfil = profil.reinitHours;
                      break;
                  }

                  return Center(
                    child: DropdownMenuFormField(
                  
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      initialSelection: momentProfil,
                      label: Text('Heures'),
                      width: 300,
                      menuHeight: 300,
                      dropdownMenuEntries: List.generate(
                        24,
                        (hours) => DropdownMenuEntry(
                          value: hours,
                          label: hours.toString().padLeft(2, '0'),
                        ),
                      ),

                      onSelected: (hours) {
                        print("on selected ${profil.reinitHours}");
                        print(
                          "🎯 onSelected appelé : hours = $hours, momentsend = $momentsend",
                        );
                        if (hours != null && hours != momentProfil) {
                          if (kDebugMode) {
                            print(
                              '📝 Widget: changement détecté $momentProfil → $hours',
                            );
                          }
                          profil.setHours(hours, momentsend);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Les alarmes sont mises à jour.'),
                              duration: Duration(milliseconds: 1000),
                            ),
                          );
                        } else {
                          if (kDebugMode) {
                            print('⏭️ Widget: même valeur ($hours), ignoré');
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
