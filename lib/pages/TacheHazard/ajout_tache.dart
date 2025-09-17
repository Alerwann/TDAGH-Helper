// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flutter_application_1/data/schema/taches_shema.dart';
import 'package:flutter_application_1/providers/taches_provider.dart';
import 'package:provider/provider.dart';

class AjoutTache extends StatefulWidget {
  const AjoutTache({super.key});

  @override
  State<AjoutTache> createState() => _AjoutTacheState();
}

class _AjoutTacheState extends State<AjoutTache> {
  final gradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 0, 0, 0),
      const Color.fromARGB(255, 0, 135, 101),
      const Color.fromARGB(255, 2, 169, 175),
    ],
  );

  final textStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  final TextEditingController _TextController = TextEditingController();
  TacheDuration? dureeSelectionnee;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) {
            return gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          child: Text(
            "Ajout d' activités",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          height: 500,
          child: Consumer<TachesProvider>(
            builder: (context, tache, chid) {
              return Form(
                child: Column(
                  children: [
                    Text(
                      "Nom de la nouvelle tache :",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 6, 91, 82),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 20,
                        bottom: 20,
                      ),

                      child: TextFormField(
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
                    ),
                    Text(
                      "Estimation de la durée :",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 6, 91, 82),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        surfaceTintColor: const Color.fromARGB(
                          255,
                          236,
                          225,
                          126,
                        ),
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
                            childAspectRatio: 2,

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

                    SizedBox(height: 50),

                    ElevatedButton(
                      onPressed: () {
                        // Validation complète
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
    );
  }
}
