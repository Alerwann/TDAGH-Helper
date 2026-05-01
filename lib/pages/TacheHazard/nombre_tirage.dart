import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
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
        appBar: CustomHeightApBcar.customApp(
          AppLocalizations.of(context)!.nombreTirage,
          context,
          "parametre",
          true,
          Icon(Icons.arrow_back_rounded),
        ),
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
                      AppLocalizations.of(context)!.actuelNombreTache(tachesTime.nombreT),
                      Theme.of(context).textTheme.bodyLarge,
                    ),
                    CustomText.center(
                     AppLocalizations.of(context)!.nombrePiocheDemande,
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

                              label: Text(AppLocalizations.of(context)!.nombrePioche),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.saisieNombre;
                              }
                              if (int.tryParse(value) == null) {
                                return AppLocalizations.of(context)!.saisienombreInvalide;
                              }
                              if (int.tryParse(value)! >
                                  tachesTime.taches.length) {
                                return AppLocalizations.of(
                                  context,
                                )!.nombrePiocheSupMax(tachesTime.taches.length);
                              }
                              if (int.parse(value) > 10) {
                                return AppLocalizations.of(
                                  context,
                                )!.nombreTacheMax;
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
                                tachesTime.reinitTache();
                                scoreP.resetCheckboxesWithLength(1);

                                Navigator.pop(context);
                              }
                            },
                            child: Text(AppLocalizations.of(context)!.valider),
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
