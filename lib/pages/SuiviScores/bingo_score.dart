import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/providers/score_provider.dart';

class BingoScore extends StatefulWidget {
  const BingoScore({super.key});

  @override
  State<BingoScore> createState() => _BingoScoreState();
}

class _BingoScoreState extends State<BingoScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bingo des Tâches",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Consumer<ScoreProvider>(
        builder: (context, scoreP, child) {
          return Column(
            spacing: 25,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  spacing: 15,
                  children: [
                    Text(
                      "Progression global pour la journée",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    StepProgressIndicator(
                      padding: 0.5,
                      size: 16,
                      totalSteps: 16,
                      currentStep: scoreP.globalBingoScore,
                      selectedColor: const Color.fromARGB(255, 69, 225, 16),
                      unselectedColor: const Color.fromARGB(255, 217, 5, 241),
                    ),
                  ],
                ),
              ),
              sousQuete("Matin", scoreP.morningScore),
              sousQuete("Midi", scoreP.midiScore),
              sousQuete("Soir", scoreP.afternoonScore),
              sousQuete("Couché", scoreP.eveningScore),
            ],
          );
        },
      ),
    );
  }

  Widget sousQuete(String moment, int step) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        spacing: 15,
        children: [
          Text(moment, style: TextStyle(fontSize: 25)),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: StepProgressIndicator(
              padding: 1,
              size: 16,
              totalSteps: 4,
              currentStep: step,
              selectedColor: const Color.fromARGB(255, 69, 225, 16),
              unselectedColor: const Color.fromARGB(255, 217, 5, 241),
            ),
          ),
        ],
      ),
    );
  }
}
