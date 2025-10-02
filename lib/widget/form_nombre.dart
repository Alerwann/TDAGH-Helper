import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/providers/defoule_provider.dart';
import 'package:flutter_application_1/providers/score_provider.dart';
import 'package:flutter_application_1/providers/taches_provider.dart';
import 'package:provider/provider.dart';

class NumberForm extends StatefulWidget {
  final int nbMax;
  final String typechoice;
  const NumberForm({super.key, required this.nbMax, required this.typechoice});

  @override
  State<NumberForm> createState() => _ParametretirageState();
}

class _ParametretirageState extends State<NumberForm> {
  List value = [0, 1];

  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final int nbMax = widget.nbMax;
    final String typechoice = widget.typechoice;

    return Center(
      child: Consumer3<TachesProvider, ScoreProvider, DefouleProvider>(
        builder: (context, tachesTime, scoreP, defoulP, child) {
          return Column(
            children: [
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
                            decoration: InputDecoration(hint: Text("Nombre")),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un nombre';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Veuillez entrer un nombre valide';
                              }
                              if (int.tryParse(value)! > nbMax) {
                                return "Nombre de tache maximal => $nbMax";
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final nbSaisi = int.parse(_numberController.text);

                              setState(() {
                                if (typechoice == "tache") {
                                  tachesTime.modifierNombreTache(nbSaisi);
                                } else if (typechoice == "game") {
                                  defoulP.saveTimerDuration(nbSaisi);
                                } else {}
                                _numberController.clear();
                              });
                              if (typechoice == "tache") {
                                tachesTime.reinitTAche();
                                scoreP.resetCheckboxesWithLength(1);
                              }
                            }

                            Navigator.pop(context);
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
    );
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }
}
