import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/TacheHazard/tirage_final.dart';
import 'package:flutter_application_1/providers/taches_provider.dart';
import 'package:provider/provider.dart';

class Parametretirage extends StatefulWidget {
  const Parametretirage({super.key});

  @override
  State<Parametretirage> createState() => _ParametretirageState();
}

class _ParametretirageState extends State<Parametretirage> {
  int choiceConvient = 0;
  List value = [0, 1];
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

  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();

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
      body: Center(
        child: Consumer<TachesProvider>(
          builder: (context, tachesTime, child) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 5),
                  child: Column(
                    children: [
                      Text(
                        "Étape 2 :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Valide le nombre de tache qui va être tiré",
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
                SizedBox(height: 50),
                Text(
                  "Actuellement je vais piocher ${tachesTime.nombreT} tâches.",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Text(
                  "Cela te convient?",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),

                SizedBox(
                  height: 200,
                  width: 200,
                  child: RadioGroup(
                    groupValue: choiceConvient,
                    onChanged: (index) {
                      setState(() {
                        choiceConvient = value[index!];
                      });
                    },

                    child: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Card(
                            child: RadioListTile(title: Text('OUI'), value: 0),
                          ),
                          SizedBox(height: 20),

                          Card(
                            child: RadioListTile(title: Text('NON'), value: 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (choiceConvient == 0)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TirageFinal(),
                        ),
                      );
                    },
                    child: Text("Tirer au sort"),
                  ),
                if (choiceConvient == 1)
                  Column(
                    children: [
                      Text("Combien de carte tu veux piocher?"),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
                              child: TextFormField(
                                controller: _numberController,

                                keyboardType: TextInputType.numberWithOptions(),
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Seulement des chiffres
                                ],
                                decoration: InputDecoration(
                                  hint: Text("Nombre"),
                                  label: Text("Nombre de pioches"),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un nombre';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Veuillez entrer un nombre valide';
                                  }
                                  if (int.tryParse(value)! >
                                      tachesTime.taches.length) {
                                    return "Nombre de tache maximal => ${tachesTime.taches.length}";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final nbTaches = int.parse(
                                    _numberController.text,
                                  );

                                  setState(() {
                                    tachesTime.modifierNombreTahce(nbTaches);
                                    _numberController.clear();
                                    choiceConvient = 0;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TirageFinal(),
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Text("Valider"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }
}
