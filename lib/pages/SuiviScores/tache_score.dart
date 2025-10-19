import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/pages/TacheHazard/accueil_taches.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class TacheScore extends StatefulWidget {
  const TacheScore({super.key});

  @override
  State<TacheScore> createState() => _TacheScoreState();
}

class _TacheScoreState extends State<TacheScore> {
  int numberOfTrue = 0;
  bool tacheTirer = false;
  @override
  void initState() {
    super.initState();
    final listOfTrue = Provider.of<ScoreProvider>(
      context,
      listen: false,
    ).isChecked;
    numberOfTrue = listOfTrue.where((task) => task).length;
    final tacheL = Provider.of<TachesProvider>(context, listen: false).taches;
    if (tacheL.isEmpty || tacheL[0].tacheName == "0") {
      tacheTirer = false;
    } else {
      tacheTirer = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        'Score des taches',
        context,
        'accueil',
        true,
      ),
      body: Consumer3<ScoreProvider, ProfilProvider, TachesProvider>(
        builder: (context, scoreP, profilP, tacheP, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  spacing: 25,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularStepProgressIndicator(
                      totalSteps: tacheP.nombreT,
                      currentStep: numberOfTrue,
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      unselectedColor: Theme.of(context).colorScheme.primary,
                      padding: 0,
                      height: 75,
                      width: 85,
                      child: Icon(HugeIconsSolid.assignments),
                    ),
                    CustomText.center(
                      "Progression global pour la journée",
                      Theme.of(context).textTheme.headlineMedium,
                    ),
                    CustomText.center(
                      "Actuellement tu as fais $numberOfTrue tâches.",
                      Theme.of(context).textTheme.headlineMedium,
                    ),
                    CustomText.center(
                      "Il te reste ${tacheP.nombreT - numberOfTrue} pour valider la quête.",
                      Theme.of(context).textTheme.headlineMedium,
                    ),

                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccueilTaches(),
                          ),
                        );
                      },
                      child: Text("Aller valider ses tâches"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
