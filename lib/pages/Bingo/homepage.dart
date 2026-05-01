// Accueil du bingo
// Donne accès à la validation des activités suivant le moment de la journée
// A chaque fois il est affiché le nom de la période le score et son horaire d'ouverture ou fermeture

import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/specific/moment_button.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';

class HomeBingoPage extends StatefulWidget {
  const HomeBingoPage({super.key});

  @override
  State<HomeBingoPage> createState() => _HomeBingoPageState();
}

class _HomeBingoPageState extends State<HomeBingoPage> {
  var choiceBingo = 0;
  bool showBanner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        AppLocalizations.of(context)!.bingoQuot,
        context,
        "accueil",
        true,
        Icon(Icons.home),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Consumer<HeureProfilProvider>(
            builder: (context, heureP, child) {
              return Column(
                spacing: 30,

                children: [
                
                  MomentButton(
                    moment: 'Matin',
                    afficheMoment: AppLocalizations.of(context)!.matin,
                    icon: HugeIconsSolid.sun02,
                    iconColor: Color.fromARGB(255, 53, 252, 252),
                  ),

                  MomentButton(
                    moment: 'Midi',
                    afficheMoment: AppLocalizations.of(context)!.midi,
                    icon: HugeIconsSolid.apple01,
                    iconColor: Color.fromARGB(255, 255, 0, 0),
                  ),

                  MomentButton(
                    moment: 'Soir',
                    afficheMoment: AppLocalizations.of(context)!.soir,
                    icon: HugeIconsSolid.moon02,
                    iconColor: Color.fromARGB(255, 255, 226, 63),
                  ),

                  MomentButton(
                    moment: 'Coucher',
                    afficheMoment: AppLocalizations.of(context)!.coucher,
                    icon: HugeIconsSolid.star,
                    iconColor: Color.fromARGB(255, 255, 255, 0),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
