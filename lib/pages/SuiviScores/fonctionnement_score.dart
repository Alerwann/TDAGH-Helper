import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class FonctionnementScore extends StatelessWidget {
  const FonctionnementScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        "Fonctionnement",
        context,
        "parametre",
        true,
        Icon(Icons.arrow_back_rounded),
      ),
      body: Consumer2<ScoreProvider, HeureProfilProvider>(
        builder: (context, scoreP, heurP, child) {
          return Center(
            child: SizedBox(
              width: 350,
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      CustomText.center(
                        "Règle des niveaux ",
                        Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomText.center(
                        "Tous les ${scoreP.maxXpByLevel} d'Xp le niveau augmente et cela débloque des grades spectaculaires !",
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        "Règle de réinitialisation ",
                        Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomText.center(
                        "L'heure de réinitialisation des scores quotidien est ${heurP.reinitHours} H.",
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        "Elle configurable dans les paramètres de l'application 🤓",
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        "Obternir des points avec le bingo ",
                        Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomText.center(
                        "4 tâches remplis = 5 points d'Xp 🏆",
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        "Obternir des points avec le tirage des tâches ",
                        Theme.of(context).textTheme.titleSmall,
                      ),

                      CustomText.center(
                        "Réalise les tâches piochées pour gagner 5 points 🏆.",
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        "Obternir des points avec les jeux bonus ",
                        Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomText.center(
                        "L'aide au brossage de dent et le jeu pour défouler peut apporter des points bonus.",
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        "Tu auras 5 points par réalisation de tâches bonus 🏆 ",
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        "Tu peux accumuler au maximum 15 points par activité bonus et par jour. ",
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
