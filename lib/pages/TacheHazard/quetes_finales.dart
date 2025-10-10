import 'package:flutter/material.dart';
import 'package:tdahelpe/pages/TacheHazard/tirage_final.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';

class Quetesfinales extends StatefulWidget {
  const Quetesfinales({super.key});

  @override
  State<Quetesfinales> createState() => _QuetesfinalesState();
}

class _QuetesfinalesState extends State<Quetesfinales> {
  bool afficheButton = false;
  bool isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   final ScoreP = Provider.of<ScoreProvider>(context, listen: false);
   
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer2<TachesProvider, ScoreProvider>(
        builder: (context, tacheP, scoreP, child) {
          if (scoreP.isLoading || tacheP.isLoading) {
            return CircularProgressIndicator();
          }
          final itemCount = tacheP.choixTaches.length;
          var afficheButton =
              tacheP.choixTaches.isEmpty || tacheP.choixTaches[0] == "0";
           print("👀 Score aprè init ${scoreP.currentStep}");
          return Container(
            margin: EdgeInsets.all(40),
            child: Column(
              children: [
                Text(
                  "Liste finale:",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Text(
                  'Fais toutes les taches pour ajouter 1 point à ton score quotidien',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  width: 300,
                  child: LinearProgressBar(
                    maxSteps: tacheP.choixTaches.length,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: scoreP.currentStep,
                    progressColor: const Color.fromARGB(255, 255, 1, 242),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 255, 1, 242),
                    ),
                    semanticsLabel: "Label",
                    semanticsValue: "Value",
                    minHeight: 30,
                    borderRadius: BorderRadius.circular(10), //  NEW
                  ),
                ),

                !afficheButton
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: scoreP.isChecked[index],
                                  onChanged: (bool? value) {
                                    scoreP.updateTacheCheck(
                                      index,
                                      value ?? false,
                                    );
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    tacheP.choixTaches[index],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Text('Il faut faire le Tirage'),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TirageFinal(),
                                  ),
                                );

                                final tacheProvider =
                                    Provider.of<TachesProvider>(
                                      context,
                                      listen: false,
                                    );
                                final scoreProvider =
                                    Provider.of<ScoreProvider>(
                                      context,
                                      listen: false,
                                    );

                                if (scoreProvider.isChecked.length !=
                                    tacheProvider.choixTaches.length) {
                                  await scoreProvider.resetCheckboxesWithLength(
                                    tacheProvider.choixTaches.length,
                                  );
                                }

                                setState(() {
                                  afficheButton = false;
                                });
                              },
                              child: Text('Faire le tirage'),
                            ),
                          ],
                        ),
                      ),

                ElevatedButton(
                  onPressed: () {
                    tacheP.reinitTAche();
                    scoreP.resetCheckboxesWithLength(1);
                    scoreP.decrementglobal('taches');
                    afficheButton = true;
                  },
                  child: Text("Reset"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
