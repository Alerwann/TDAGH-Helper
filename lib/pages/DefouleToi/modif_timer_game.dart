import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/defoule_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class ModifTimerGame extends StatefulWidget {
  const ModifTimerGame({super.key});

  @override
  State<ModifTimerGame> createState() => _ModifTimerGameState();
}

class _ModifTimerGameState extends State<ModifTimerGame> {
  TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        "Modification du timer",
        context,
        "parametre",
        true,
        Icon(Icons.arrow_back_rounded),
      ),
      body: Consumer<DefouleProvider>(
        builder: (context, defoulP, child) {
          return Center(
            child: Form(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.center(
                      "Saisie la durée souhaité du timer en seconde.",
                      Theme.of(context).textTheme.bodyLarge,
                    ),
                    CustomText.center(
                      "Nombre maximal de seconde : 600",
                      Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 20),
                    CustomText.center(
                      "⚠️ La modification va supprimer le record enregistré ⚠️",
                      TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: "Temps",
                              prefixIcon: Icon(Icons.timer),
                              labelText: 'Temps en second',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un nombre';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Veuillez entrer un nombre valide';
                              }
                              if (int.tryParse(value)! > 600) {
                                return "Nombre de tache maximal => 600";
                              }
                              return null;
                            },
                            maxLength: 3,
                            controller: _numberController,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final nbSaisi = int.parse(
                                  _numberController.text,
                                );

                                setState(() {
                                  defoulP.saveTimerDuration(nbSaisi);
                                  defoulP.resetScore();

                                  _numberController.clear();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Timer mis à jour avec succès !',
                                    ),
                                  ),
                                );

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
              ),
            ),
          );
        },
      ),
    );
  }
}
