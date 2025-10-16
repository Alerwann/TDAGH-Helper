import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/pages/SuiviScores/bingo_score.dart';
import 'package:tdahelpe/pages/SuiviScores/bonus_score.dart';
import 'package:tdahelpe/pages/SuiviScores/fonctionnement_score.dart';
import 'package:tdahelpe/pages/SuiviScores/tache_score.dart';
import 'package:tdahelpe/providers/bonus_level_provider.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:tdahelpe/widget/utils/text_degrade.dart';

class AccueilScore extends StatefulWidget {
  const AccueilScore({super.key});

  @override
  State<AccueilScore> createState() => _AccueilScoreState();
}

class _AccueilScoreState extends State<AccueilScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextDegrade(
          title: "Avancement des quêtes",
          choicetype: 'accueil',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Consumer3<ScoreProvider, BonusLevelProvider, ProfilProvider>(
            builder: (context, scoreP, bonusP, profilP, child) {
              return Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText.center(
                    "${profilP.pseudo.toUpperCase()} est : ",
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomText.center(
                    "${bonusP.getCurrentGrade(scoreP.niveauPersonnal)?.gradeName ?? 'Aucun'} de niveau ${scoreP.niveauPersonnal}",
                    Theme.of(context).textTheme.titleMedium,
                  ),

                  CustomText.center(
                    "Nombre d'XP actuel = ${scoreP.xpByLevel} / 140",
                    Theme.of(context).textTheme.bodyLarge,
                  ),

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 25,
                      vertical: 5,
                    ),
                    child: StepProgressIndicator(
                      padding: 0,
                      size: 16,
                      totalSteps: 140,
                      currentStep: scoreP.xpByLevel,
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      unselectedColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  CustomText.center(
                    "Aujourd'hui l'XP acquis : ${scoreP.globalScore}",
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomText.center(
                    "Accès aux détails",
                    Theme.of(context).textTheme.headlineMedium,
                  ),

                  SizedBox(
                    height: 60,
                    width: 250,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BingoScore()),
                        );
                      },
                      child: Text("Bingo"),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 250,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TacheScore()),
                        );
                      },
                      child: Text("Tâches"),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 250,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BonusScore()),
                        );
                      },
                      child: Text("Points bonus"),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 250,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FonctionnementScore(),
                          ),
                        );
                      },
                      child: Text(
                        "Fonctionnement",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 4, 36, 63),
                        ),
                      ),
                    ),
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
