import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/pages/DefouleToi/defoule_toi.dart';
import 'package:tdahelpe/pages/TimerTooth/home_timer_tooth.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';

class BonusScore extends StatefulWidget {
  const BonusScore({super.key});

  @override
  State<BonusScore> createState() => _BonusScoreState();
}

class _BonusScoreState extends State<BonusScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Score Bonus",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Consumer2<ScoreProvider, ProfilProvider>(
        builder: (context, scoreP, profilP, child) {
          final int nbCleantooth = (scoreP.toothScore / 5).floor();
          final int nbRecord = (scoreP.defouleScore / 5).floor();
          return Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Score de lavage de dents : ${scoreP.toothScore}",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
            
                SizedBox(
                  width: 250,
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
                    ? Text(
                        "Lave toi encore ${3 - nbCleantooth} les dents pour avoir l'Xp maximal!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Column(
                        children: [
                          Text(
                            "Tu t'es lavé le nombre recommandé de fois! Bravo",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Tu as l'Xp maximal pour ce bonus",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                             OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeTimertooth()),
                    );
                  },
                  child: Text(
                    "Aller vers le lavage de dent",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 300,
                  child: Text(
                    "Score de record de tappe défoule ${scoreP.defouleScore}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 250,
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
                    ? Text(
                        "Il te reste ${4 - nbRecord} records à battre pour aujourd'hui",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        "Bravo tu as battu 4 records aujourdhui. \n Tu as gagné l'XP maximal pour ce bonus",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                             OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeDefouleToi()),
                    );
                  },
                  child: Text(
                    "Va battre des records",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
