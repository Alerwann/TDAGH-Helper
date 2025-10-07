import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/main.dart';
import 'package:tdahelpe/pages/SuiviScores/bingo_score.dart';
import 'package:tdahelpe/providers/score_provider.dart';

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
        backgroundColor: Colors.purple,
        title: Text(
          "Avancement des quêtes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.amber,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          icon: Icon(
            Icons.home,
            color: const Color.fromARGB(255, 230, 177, 2),
            size: 45,
          ),
        ),
      ),
      body: Center(
        child: Consumer<ScoreProvider>(
          builder: (context, scoreP, child) {
            return Column(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Niveau : ${scoreP.niveauPersonnal}",
                  style: TextStyle(fontSize: 20),
                ),

                Text(
                  "Nombre d'XP actuel = ${scoreP.xpByLevel} / 140",
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: StepProgressIndicator(
                    padding: 0,
                    size: 16,
                    totalSteps: 140,
                    currentStep: scoreP.xpByLevel,
                    selectedColor: const Color.fromARGB(255, 69, 225, 16),
                    unselectedColor: const Color.fromARGB(255, 217, 5, 241),
                  ),
                ),

                Text(
                  "Aujourd'hui l'XP acquis : ${scoreP.globalScore}",
                  style: TextStyle(fontSize: 20),
                ),

                Text("Accès aux détails", style: TextStyle(fontSize: 20)),

                SizedBox(
                  height: 60,
                  width: 200,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BingoScore()),
                      );
                    },
                    child: Text(
                      "Bingo",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 200,

                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Tâches",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 200,

                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Points bonus",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 60,
                  width: 200,

                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Fonctionnement",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
