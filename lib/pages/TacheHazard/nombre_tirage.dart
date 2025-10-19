import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appcar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class Parametretirage extends StatefulWidget {
  final VoidCallback? onNavigateToQuetes;
  const Parametretirage({super.key, this.onNavigateToQuetes});

  @override
  State<Parametretirage> createState() => _ParametretirageState();
}

class _ParametretirageState extends State<Parametretirage> {
  int choiceConvient = 0;
  List value = [0, 1];

  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },

      child: Scaffold(
        appBar: CustomHeightAppcar.customApp('Nombre de tirage', context, "parametre", true),
        body: Center(
          child: Consumer2<TachesProvider, ScoreProvider>(
            builder: (context, tachesTime, scoreP, child) {
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 15,
                  children: [
                    CustomText.center(
                      'Actuellement ${tachesTime.nombreT} tâches sont piochées.',
                      Theme.of(context).textTheme.bodyLarge,
                    ),
                    CustomText.center(
                      "Combien de Tâches tu veux piocher?",
                      Theme.of(context).textTheme.bodyLarge,
                    ),

                    SizedBox(height: 5),

                    Form(
                      key: _formKey,
                      child: Column(
                        spacing: 20,
                        children: [
                  
                     
                          TextFormField(
                              controller: _numberController,

                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),

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
                                scoreP.resetCheckboxesWithLength(1);

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
              );
            },
          ),
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
