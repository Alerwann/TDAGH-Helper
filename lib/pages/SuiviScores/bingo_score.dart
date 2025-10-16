import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/pages/Bingo%20ok/homepage.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:tdahelpe/widget/utils/text_degrade.dart';

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
        title: TextDegrade(title: "Bilan bingo", choicetype: 'parametre'),
      ),
      body: SingleChildScrollView(
        child: Consumer<ScoreProvider>(
          builder: (context, scoreP, child) {
            return Column(
              spacing: 25,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    spacing: 15,
                    children: [
                      CustomText.center(
                        "Progression global pour la journée",
                        Theme.of(context).textTheme.headlineMedium,
                      ),

                      StepProgressIndicator(
                        padding: 0.5,
                        size: 16,
                        totalSteps: 16,
                        currentStep: scoreP.globalBingoScore,
                        selectedColor: Theme.of(context).colorScheme.secondary,
                        unselectedColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
                sousQuete("Matin", scoreP.morningScore),
                sousQuete("Midi", scoreP.midiScore),
                sousQuete("Soir", scoreP.afternoonScore),
                sousQuete("Couché", scoreP.eveningScore),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeBingoPage()),
                    );
                  },
                  child: Text("Aller valider le bingo"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget sousQuete(String moment, int step) {
    return Column(
      spacing: 10,
      children: [
        CustomText.center(moment, Theme.of(context).textTheme.headlineSmall),

        Container(
          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: StepProgressIndicator(
            padding: 1,
            size: 16,
            totalSteps: 4,
            currentStep: step,
            selectedColor: Theme.of(context).colorScheme.secondary,
            unselectedColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
