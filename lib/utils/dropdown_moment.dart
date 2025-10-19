import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';

import 'package:tdahelpe/utils/horaire_moment.dart';

class DropdownMoment extends StatelessWidget {
  final String moment;
  final String momentsend;
  const DropdownMoment({
    super.key,
    required this.moment,
    required this.momentsend,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HeureProfilProvider>(
      builder: (context, profil, child) {
        int momentProfil = HoraireMoment.convertMomentName(moment, profil);
        return DropdownMenuFormField(
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
                print('📝 Widget: changement détecté $momentProfil → $hours');
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
        );
      },
    );
  }
}
