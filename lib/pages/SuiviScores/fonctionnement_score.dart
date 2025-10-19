import 'package:flutter/material.dart';
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
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  CustomText.center(
                    "L'heure de la remise à 0 est configurable dans les paramètres de l'application 🤓",
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomText.center(
                    "Remplis le bingo des taches. \n 4 tâches remplis = 5 points d'Xp 🏆",
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomText.center(
                    "Pioche des tâches au hasard et réalise les pour gagner 5 points 🏆.",
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomText.center(
                    "En plus tu peux choisir ton nombre de tâche dans les paramètre suivant ta forme. 😜",
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomText.center(
                    "Pour finir fait les tâches bonus (Lavage de Dents et les record) 🦷",
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomText.center(
                    "Tu auras 5 points par réalisation de tâches bonus 🏆 ",
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomText.center(
                    "Tous les 140 d'Xp tu prends un niveau et débloque des grades spectaculaires !!!",
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
