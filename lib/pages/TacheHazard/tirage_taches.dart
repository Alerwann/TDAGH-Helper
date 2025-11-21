import 'package:flutter/material.dart';
import 'package:tdahelpe/pages/TacheHazard/animation_tirage.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/utils/alerdialog.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:tdahelpe/widget/utils/loader_widget.dart';

class Quetesfinales extends StatefulWidget {
  const Quetesfinales({super.key});

  @override
  State<Quetesfinales> createState() => _QuetesfinalesState();
}

class _QuetesfinalesState extends State<Quetesfinales> {
  bool afficheButton = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer2<TachesProvider, ScoreProvider>(
        builder: (context, tacheP, scoreP, child) {
          final itemCount = tacheP.choixTaches.length;
          var afficheButton =
              tacheP.choixTaches.isEmpty || tacheP.choixTaches[0] == "0";

          if (scoreP.isLoading || tacheP.isLoading) {
            return LoaderWidget();
          }

          return Container(
            margin: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 25,
              children: [
                CustomText.center(
                  "Liste des tâches",
                  Theme.of(context).textTheme.titleMedium,
                ),

                !afficheButton
                    ? Expanded(
                        child: Column(
                          spacing: 15,
                          children: [
                            SizedBox(
                              width: 300,

                              child: LinearProgressBar(
                                maxSteps: tacheP.choixTaches.length,
                                progressType:
                                    LinearProgressBar.progressTypeLinear,
                                currentStep: scoreP.currentStep,
                                backgroundColor: Theme.of(context).primaryColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.secondary,
                                ),
                                semanticsLabel: "Label",
                                semanticsValue: "Value",
                                minHeight: 20,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Expanded(
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
                                        child: CustomText.left(
                                          tacheP.choixTaches[index],
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Tu peux refaire le tirage"),
                                IconButton(
                                  onPressed: () => PersoAlertDialog.showInfoDialog(
                                    context,
                                    'Règle de tirage',
                                    "⚠️ Si tu as déjà un tirage quotidien en cours, en modifiant la liste celui-ci sera annulé.\n Si tu as déjà tes points tu n'auras pas plus d'XP",
                                  ),
                                  icon: Icon(Icons.warning_amber_rounded),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                tacheP.reinitTache();
                                scoreP.resetCheckboxesWithLength(1);
                                scoreP.decrementglobal('taches');
                                afficheButton = true;
                              },
                              child: Text("Reset"),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 200,
                        child: Column(
                          spacing: 10,
                          children: [
                            CustomText.center(
                              "En attente d'un tirage",
                              TextTheme.of(context).bodyLarge,
                            ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
