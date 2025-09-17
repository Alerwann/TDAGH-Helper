import 'package:flutter/material.dart';

import 'package:flutter_application_1/data/schema/taches_shema.dart';
import 'package:flutter_application_1/pages/TacheHazard/ajout_tache.dart';
import 'package:flutter_application_1/pages/TacheHazard/parametre_tirage.dart';
import 'package:flutter_application_1/providers/taches_provider.dart';
import 'package:provider/provider.dart';

class TacheListeAffichage extends StatefulWidget {
  const TacheListeAffichage({super.key});

  @override
  State<TacheListeAffichage> createState() => _TacheListeAffichageState();
}

class _TacheListeAffichageState extends State<TacheListeAffichage> {
  final gradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 237, 85, 2),
      const Color.fromARGB(255, 244, 176, 4),
      const Color.fromARGB(255, 255, 85, 59),
    ],
  );

  final textStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  bool modifName = false;
  bool modifDuree = false;
  TacheDuration? tacheDuration;
  TacheDuration? dureeSelectionnee;
  String? nameTache;

  final TextEditingController _tacheModifier = TextEditingController();

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
            "Liste d'activités",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Consumer<TachesProvider>(
        builder: (context, tacheP, child) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 5),
                child: Column(
                  children: [
                    Text(
                      "Étape 1 :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Vérifie la liste, modifie, supprime ou ajoute une activité si besoin.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 400,
                child: ListView.builder(
                  itemCount: tacheP.taches.length,
                  itemBuilder: (context, index) {
                    final tache = tacheP.taches[index];
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            'Tâche :',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),

                          TextButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(200, 20),
                              elevation: 0.5,
                              padding: EdgeInsets.all(0),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                modifDuree = false;
                                modifName = true;
                                nameTache = tache.tacheName;
                                tacheDuration = tache.tacheDuration;
                              });
                            },
                            child: Text(
                              textAlign: TextAlign.center,
                              tache.tacheName,

                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 242, 94, 3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            'Estimation de la durée :',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(80, 20),
                              elevation: 0.5,
                              padding: EdgeInsets.all(0),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                modifDuree = true;
                                nameTache = tache.tacheName;
                                tacheDuration = tache.tacheDuration;
                                dureeSelectionnee = TacheDuration.court;
                              });
                            },
                            child: changeEnumtoString(tache.tacheDuration.name),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            tacheP.supprimerTache(tache.tacheName);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              if (modifName == true)
                SizedBox(
                  height: 100,
                  width: 350,
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _tacheModifier,
                          decoration: InputDecoration(
                            hintText: nameTache,

                            labelText: nameTache,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (modifDuree == true)
                SizedBox(
                  height: 100,

                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

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
                            dureeSelectionnee = value!;
                          });
                        },

                        child: GridView.count(
                          controller: ScrollController(keepScrollOffset: false),
                          crossAxisCount: 2,
                          childAspectRatio: 4,

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
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AjoutTache()),
                      );
                    },
                    child: Text('Ajouter'),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        modifName = false;
                        modifDuree = false;
                        dureeSelectionnee = null;
                        nameTache = null;
                        tacheDuration = null;
                        _tacheModifier.clear();
                      });
                    },
                    child: Text('Annuler'),
                  ),
                ],
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (modifName == true) {
                      TachesSchema newTacheCreat = TachesSchema(
                        tacheName: _tacheModifier.text,
                        tacheDuration: tacheDuration!,
                      );
                      if (nameTache != null) {
                        setState(() {
                          tacheP.modifierTache(nameTache!, newTacheCreat);
                          _tacheModifier.clear();
                          modifName = false;
                        });
                      }
                    } else if (modifDuree == true) {
                      TachesSchema newTacheCreat = TachesSchema(
                        tacheName: nameTache!,
                        tacheDuration: dureeSelectionnee!,
                      );
                      setState(() {
                        tacheP.modifierTache(nameTache!, newTacheCreat);
                        dureeSelectionnee = TacheDuration.court;
                        modifDuree = false;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Parametretirage(),
                        ),
                      );
                    }
                  });
                },
                child: Text(
                  modifName == true
                      ? 'Valider le nom'
                      : modifDuree == true
                      ? 'Valider la durée'
                      : "Passer à l'étape 2",
                ),
              ),
              SizedBox(width: 15),
            ],
          );
        },
      ),
    );
  }

  Text changeEnumtoString(enumName) {
    String convertValue = "";
    Color colorAssigne = Colors.black;
    switch (enumName) {
      case 'court':
        convertValue = 'Court';
        colorAssigne = Colors.green;
        break;
      case 'moyen':
        convertValue = 'Moyen';
        colorAssigne = const Color.fromARGB(255, 234, 96, 4);
        break;
      case 'long':
        convertValue = 'Long';
        colorAssigne = const Color.fromARGB(255, 205, 1, 1);
        break;
      case 'tresLong':
        convertValue = 'Très long';
        colorAssigne = const Color.fromARGB(255, 139, 1, 1);
        break;
    }
    return Text(
      convertValue,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: colorAssigne,
      ),
    );
  }
}
