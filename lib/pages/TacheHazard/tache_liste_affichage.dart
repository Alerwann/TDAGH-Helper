import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/schema/taches_shema.dart';
import 'package:flutter_application_1/widget/ajout_tache.dart';

import 'package:flutter_application_1/providers/taches_provider.dart';
import 'package:provider/provider.dart';

class TacheListeAffichage extends StatefulWidget {
  const TacheListeAffichage({super.key});

  @override
  State<TacheListeAffichage> createState() => _TacheListeAffichageState();
}

class _TacheListeAffichageState extends State<TacheListeAffichage> {
  bool modifName = false;
  bool modifDuree = false;
  TacheDuration? tacheDuration;
  TacheDuration? dureeSelectionnee;
  String? nameTache;

  final TextEditingController _tacheModifier = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TachesProvider>(
      builder: (context, tacheP, child) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 5),

              child: Column(
                children: [
                  Text(
                    "Appuie sur ce que tu veux modifier",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),

                child: ListView.builder(
                  itemCount: tacheP.taches.length,
                  itemBuilder: (context, index) {
                    final tache = tacheP.taches[index];
                    return Card(
                      margin: EdgeInsets.all(2),

                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.5,
                                padding: EdgeInsets.all(0),
                                backgroundColor: const Color.fromARGB(
                                  54,
                                  255,
                                  255,
                                  255,
                                ),
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
                                "${tache.tacheName} :",

                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 95, 1, 82),
                                ),
                              ),
                            ),

                            TextButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.5,
                                padding: EdgeInsets.all(0),
                                backgroundColor: const Color.fromARGB(
                                  54,
                                  255,
                                  255,
                                  255,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  modifDuree = true;
                                  nameTache = tache.tacheName;
                                  tacheDuration = tache.tacheDuration;
                                  dureeSelectionnee = TacheDuration.court;
                                });
                              },
                              child: changeEnumtoString(
                                tache.tacheDuration.name,
                              ),
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
                      ),
                    );
                  },
                ),
              ),
            ),

            if (modifName == true)
              Form(
                child: Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 50),
                        ),
                        onPressed: () {
                          setState(() {
                            if (modifName == true) {
                              TachesSchema newTacheCreat = TachesSchema(
                                tacheName: _tacheModifier.text,
                                tacheDuration: tacheDuration!,
                              );
                              if (nameTache != null) {
                                setState(() {
                                  tacheP.modifierTache(
                                    nameTache!,
                                    newTacheCreat,
                                  );
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
                            }
                          });
                        },
                        child: Text("Valider le nom"),
                      ),
                    ],
                  ),
                ),
              ),

            if (modifDuree == true)
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Choisi la bonne durée:',
                      style: TextStyle(fontSize: 20),
                    ),

                    Expanded(
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

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (modifDuree == true) {
                            TachesSchema newTacheCreat = TachesSchema(
                              tacheName: nameTache!,
                              tacheDuration: dureeSelectionnee!,
                            );
                            setState(() {
                              tacheP.modifierTache(nameTache!, newTacheCreat);
                              dureeSelectionnee = TacheDuration.court;
                              modifDuree = false;
                            });
                          }
                        });
                      },
                      child: Text('Valider'),
                    ),
                  ],
                ),
              ),

            Container(
              margin: EdgeInsets.all(30),
              child: Row(
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
            ),
          ],
        );
      },
    );
  }
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
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: colorAssigne,
    ),
  );
}
