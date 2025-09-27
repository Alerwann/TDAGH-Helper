import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/providers/score_provider.dart';
import 'package:flutter_application_1/providers/taches_provider.dart';
import 'package:provider/provider.dart';

class Parametretirage extends StatefulWidget {
  final VoidCallback? onNavigateToQuetes;
  const Parametretirage({super.key, this.onNavigateToQuetes});

  @override
  State<Parametretirage> createState() => _ParametretirageState();
}

class _ParametretirageState extends State<Parametretirage> {
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

  int choiceConvient = 0;
  List value = [0, 1];

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
            "Ajout d' activités",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Center(
        child: Consumer2<TachesProvider, ScoreProvider>(
          builder: (context, tachesTime, scoreP, child) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 5),
                  child: Column(
                    children: [
                      Text(
                        "Valide le nombre de tache qui va être tiré",
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
                SizedBox(height: 50),
                Text(
                  "Actuellement je vais piocher ${tachesTime.nombreT} tâches.",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Text(
                  "Combien de Tâches tu veux piocher?",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),

                Column(
                  children: [
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
                                  tachesTime.modifierNombreTache(nbTaches);
                                  _numberController.clear();
                                  choiceConvient = 0;
                                });
                                tachesTime.reinitTAche();
                                scoreP.createIsChecke(nbTaches);

                                Navigator.pop(context);
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
