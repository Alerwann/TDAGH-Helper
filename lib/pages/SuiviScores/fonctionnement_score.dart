import 'package:flutter/material.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:tdahelpe/widget/utils/text_degrade.dart';

class FonctionnementScore extends StatelessWidget {
  const FonctionnementScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextDegrade(title: "Règles de l'xp", choicetype: "parametre"),
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
                    "Tous les jours à 4h du 🌞 matin, l'Xp quotidienne se remet à 0.",
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
