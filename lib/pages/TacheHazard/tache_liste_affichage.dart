import 'package:flutter/material.dart';
import 'package:tdahelpe/core/navigation/app_navigator.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/pages/TacheHazard/ajout_tache.dart';
import 'package:tdahelpe/pages/TacheHazard/modifcation_tache.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:tdahelpe/pages/TacheHazard/nombre_tirage.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/specific/change_enum_to_string.dart';
import 'package:tdahelpe/utils/alerdialog.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:tdahelpe/widget/utils/translate_key_task.dart';

class TacheListeAffichage extends StatefulWidget {
  const TacheListeAffichage({super.key});

  @override
  State<TacheListeAffichage> createState() => _TacheListeAffichageState();
}

class _TacheListeAffichageState extends State<TacheListeAffichage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TachesProvider>(
      builder: (context, tacheP, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText.center(
                  AppLocalizations.of(context)!.listeEnregistre,
                  Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                  onPressed: () => PersoAlertDialog.showInfoDialog(
                    context,
                    'Informations',
                    AppLocalizations.of(context)!.explicationCouleur,
                  ),
                  icon: Icon(Icons.info_outline_rounded),
                ),
              ],
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),

                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: tacheP.taches.length,
                    itemBuilder: (context, index) {
                      final tache = tacheP.taches[index];
                      final nameTache = translateKey(tache.tacheName, context);
                      return Card(
                        elevation: 0,
                        margin: EdgeInsets.all(2),
                        child: ListTile(
                          onTap: () async {
                            await AppNavigator.push(
                              context,
                              ModifcationTache(tacheComplete: tache),
                            );
                          },
                          title: Text(
                            nameTache,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ChangeEnumToString.changeEnumtoString(
                                tache.tacheDuration.name,
                              ),
                            ),
                          ),

                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.supprimeTache(nameTache),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: Navigator.of(context).pop,
                                        child: Text(
                                          AppLocalizations.of(context)!.non,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          tacheP.supprimerTache(
                                            nameTache,
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.oui,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 375,
              child: ElevatedButton(
                onPressed: () {
                  AppNavigator.push(context, AjoutTache());
                },
                child: Text(
                  AppLocalizations.of(context)!.ajouterTache,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 375,
              child: ElevatedButton(
                onPressed: () async {
                  await AppNavigator.push(context, Parametretirage());
                },
                child: Text(AppLocalizations.of(context)!.modifierNombreTirage),
              ),
            ),
            SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
