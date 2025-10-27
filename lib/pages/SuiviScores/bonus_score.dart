import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/core/navigation/app_navigator.dart';
import 'package:tdahelpe/pages/DefouleToi/defoule_toi.dart';
import 'package:tdahelpe/pages/TimerTooth/home_timer_tooth.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class BonusScore extends StatefulWidget {
  const BonusScore({super.key});

  @override
  State<BonusScore> createState() => _BonusScoreState();
}

class _BonusScoreState extends State<BonusScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        "Suivi des points bonus",
        context,
        'accueil',
        true,
        Icon(Icons.arrow_back_rounded),
      ),
      body: Consumer2<ScoreProvider, ProfilProvider>(
        builder: (context, scoreP, profilP, child) {
          final int nbCleantooth = (scoreP.toothScore / 5).floor();
          final int nbRecord = (scoreP.defouleScore / 5).floor();
          return Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText.center(
                    "Score de lavage de dents : ${scoreP.toothScore}",
                    Theme.of(context).textTheme.headlineMedium,
                  ),

                  SizedBox(
                    width: 300,
                    child: StepProgressIndicator(
                      totalSteps: 3,
                      currentStep: nbCleantooth,
                      padding: 6.0,
                      size: 12,
                      progressDirection: TextDirection.ltr,
                      selectedColor: Colors.green,
                      unselectedColor: Colors.black12,
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.yellowAccent,
                          const Color.fromARGB(255, 49, 236, 7),
                        ],
                      ),
                      unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color.fromARGB(255, 228, 112, 4),
                          const Color.fromARGB(255, 246, 6, 6),
                        ],
                      ),
                    ),
                  ),

                  nbCleantooth != 3
                      ? CustomText.center(
                          "Lave toi encore ${3 - nbCleantooth} les dents pour avoir l'Xp maximal!",
                          Theme.of(context).textTheme.headlineSmall,
                        )
                      : CustomText.center(
                          "Tu t'es lavé le nombre recommandé de fois! Bravo",
                          Theme.of(context).textTheme.headlineSmall,
                        ),

                  OutlinedButton(
                    onPressed: () {
                      AppNavigator.replaceTo(context, HomeTimertooth());
                    },
                    child: Text("Aller vers le lavage de dent"),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: CustomText.center(
                      "Score de record de tappe défoule ${scoreP.defouleScore}",
                      Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: StepProgressIndicator(
                      totalSteps: 4,
                      currentStep: nbRecord,
                      padding: 6.0,
                      size: 12,
                      progressDirection: TextDirection.ltr,
                      selectedColor: Colors.green,
                      unselectedColor: Colors.black12,
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.yellowAccent,
                          const Color.fromARGB(255, 49, 236, 7),
                        ],
                      ),
                      unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color.fromARGB(255, 228, 112, 4),
                          const Color.fromARGB(255, 246, 6, 6),
                        ],
                      ),
                    ),
                  ),

                  nbRecord < 4
                      ? CustomText.center(
                          "Il te reste ${4 - nbRecord} records à battre pour aujourd'hui",
                          Theme.of(context).textTheme.headlineSmall,
                        )
                      : CustomText.center(
                          "Bravo tu as battu 4 records aujourdhui. \n Tu as gagné l'XP maximal pour ce bonus",
                          Theme.of(context).textTheme.headlineSmall,
                        ),
                  OutlinedButton(
                    onPressed: () {
                      AppNavigator.replaceTo(context, HomeDefouleToi());
                    },
                    child: Text("Va battre des records"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
