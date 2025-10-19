// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:tdahelpe/data/schema/taches_shema.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appcar.dart';
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
        appBar: CustomHeightAppcar.customApp("Ajout d'activités", context, 'parametre', true),
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
                          "Nom de la nouvelle tache :",
                          Theme.of(context).textTheme.headlineMedium,
                        ),
          
                        TextFormField(
                          controller: _TextController,
                          decoration: InputDecoration(
                            hintText: "Nom de l'activité",
                            prefixIcon: Icon(Icons.person),
                            labelText: "Nom de l'activité",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
          
                        SizedBox(height: 10),
                        CustomText.center(
                          "Estimation de la durée :",
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
                                      title: Text('Court'),
                                      value: TacheDuration.court,
                                    ),
                                  ),
          
                                  SizedBox(
                                    child: RadioListTile<TacheDuration>(
                                      title: Text('Moyen'),
                                      value: TacheDuration.moyen,
                                    ),
                                  ),
          
                                  RadioListTile<TacheDuration>(
                                    title: Text('Long'),
                                    value: TacheDuration.long,
                                  ),
          
                                  RadioListTile<TacheDuration>(
                                    title: Text('Très long'),
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
                                    'Veuillez saisir un nom d\'activité',
                                  ),
                                ),
                              );
                              return;
                            }
          
                            if (dureeSelectionnee == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Veuillez sélectionner une durée'),
                                ),
                              );
                              return;
                            }
          
                            TachesSchema tacheNew = TachesSchema(
                              tacheName: _TextController.text.trim(),
                              tacheDuration: dureeSelectionnee!,
                            );
          
                            tache.ajouterTache(tacheNew);
          
                            _TextController.clear();
                            setState(() {
                              dureeSelectionnee = null;
                            });
          
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tâche ajoutée avec succès !'),
                              ),
                            );
                            tache.reinitTAche();
                            scoreP.resetCheckboxesWithLength(1);
          
                            Navigator.pop(context);
                          },
                          child: Text("Valider"),
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
