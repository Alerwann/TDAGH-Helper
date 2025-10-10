import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/pages/TacheHazard/accueil_taches.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';

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
    if (tacheL.isEmpty || tacheL[0] == "0") {
      tacheTirer = false;
    } else {
      tacheTirer = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "T'es pas tâche",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Consumer3<ScoreProvider, ProfilProvider, TachesProvider>(
        builder: (context, scoreP, profilP, tacheP, child) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(25),
              child: Column(
                spacing: 25,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularStepProgressIndicator(
                    totalSteps: tacheP.nombreT,
                    currentStep: numberOfTrue,
                    selectedColor: const Color.fromARGB(255, 106, 243, 1),
                    unselectedColor: const Color.fromARGB(255, 237, 3, 229),
                    padding: 0,
                    height: 75,
                    width: 85,
                    child: Icon(HugeIconsSolid.assignments),
                  ),
                  Text(
                    "Actuellement tu as fais $numberOfTrue tâches.",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Il te reste ${tacheP.nombreT - numberOfTrue} pour valider la quête.",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
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
                    child: Text(
                      "Aller valider ses tâches",
                      style: TextStyle(fontSize: 25),
                    ),
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
