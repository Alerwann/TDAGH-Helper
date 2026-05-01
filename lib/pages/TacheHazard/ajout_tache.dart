// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:tdahelpe/data/schema/taches_shema.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class AjoutTache extends StatefulWidget {
  const AjoutTache({super.key});

  @override
  State<AjoutTache> createState() => _AjoutTacheState();
}

class _AjoutTacheState extends State<AjoutTache> {
  final TextEditingController _TextController = TextEditingController();
  TacheDuration? dureeSelectionnee;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomHeightApBcar.customApp(
         AppLocalizations.of(context)!.addTache,
          context,
          'parametre',
          true,
          Icon(Icons.arrow_back_rounded),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
              child: Consumer2<TachesProvider, ScoreProvider>(
                builder: (context, tache, scoreP, chid) {
                  return Form(
                    child: Column(
                      spacing: 15,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText.center(
                          AppLocalizations.of(context)!.newTaskName,
                          Theme.of(context).textTheme.headlineMedium,
                        ),

                        TextFormField(
                          controller: _TextController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.activityName,
                            prefixIcon: Icon(Icons.person),
                            labelText: AppLocalizations.of(context)!.activityName,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        CustomText.center(
                          AppLocalizations.of(context)!.estimationDuree,
                          Theme.of(context).textTheme.headlineMedium,
                        ),

                        SizedBox(
                          height: 150,
                          child: Card(
                            child: RadioGroup(
                              groupValue: dureeSelectionnee,
                              onChanged: (TacheDuration? value) {
                                setState(() {
                                  dureeSelectionnee = value;
                                });
                              },

                              child: GridView.count(
                                controller: ScrollController(
                                  keepScrollOffset: false,
                                ),
                                crossAxisCount: 2,
                                childAspectRatio: 3,

                                children: [
                                  SizedBox(
                                    child: RadioListTile<TacheDuration>(
                                      title: Text(
                                        AppLocalizations.of(context)!.court,
                                      ),
                                      value: TacheDuration.court,
                                    ),
                                  ),

                                  SizedBox(
                                    child: RadioListTile<TacheDuration>(
                                      title: Text(
                                        AppLocalizations.of(context)!.moyen,
                                      ),
                                      value: TacheDuration.moyen,
                                    ),
                                  ),

                                  RadioListTile<TacheDuration>(
                                    title: Text(
                                      AppLocalizations.of(context)!.long,
                                    ),
                                    value: TacheDuration.long,
                                  ),

                                  RadioListTile<TacheDuration>(
                                    title: Text(
                                      AppLocalizations.of(context)!.tresLong,
                                    ),
                                    value: TacheDuration.tresLong,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        ElevatedButton(
                          onPressed: () {
                            if (_TextController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                   AppLocalizations.of(context)!.saisiNomAct,
                                  ),
                                ),
                              );
                              return;
                            }

                            if (dureeSelectionnee == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!.dureeAct,
                                  ),
                                ),
                              );
                              return;
                            }

                            TachesSchema tacheNew = TachesSchema(
                              tacheName: _TextController.text.trim(),
                              tacheDuration: dureeSelectionnee!,
                              isCustom: true,
                            );

                            tache.ajouterTache(tacheNew);

                            _TextController.clear();
                            setState(() {
                              dureeSelectionnee = null;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!.succesAjoutAct,
                                ),
                              ),
                            );
                            tache.reinitTache();
                            scoreP.resetCheckboxesWithLength(1);

                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.valider),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
