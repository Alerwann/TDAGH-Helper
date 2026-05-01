import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
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
         AppLocalizations.of(context)!.modifTimer,
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
                       AppLocalizations.of(context)!.saisieTimerSecond,
                      Theme.of(context).textTheme.bodyLarge,
                    ),
                    CustomText.center(
                       AppLocalizations.of(context)!.tempsMax,
                      Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 20),
                    CustomText.center(
                      AppLocalizations.of(context)!.warningSupRecord,
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
                              hintText:  AppLocalizations.of(context)!.temps,
                              prefixIcon: Icon(Icons.timer),
                              labelText:  AppLocalizations.of(context)!.tempsSecond,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return  AppLocalizations.of(context)!.saisieNombre;
                              }
                              if (int.tryParse(value) == null) {
                                return  AppLocalizations.of(context)!.saisienombreInvalide;
                              }
                              if (int.tryParse(value)! > 600) {
                                return  AppLocalizations.of(context)!.nombreTacheMax;
                              }
                              return null;
                            },
                            maxLength: 3,
                            controller: _numberController,
                          ),

                          // Enregistrer le nouveau compteur
                          
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final nbSaisi = int.parse(
                                  _numberController.text,
                                );

                                final saveSuccess = await defoulP
                                    .saveTimerDuration(nbSaisi);
                                final resetSuccess = await defoulP.resetScore();

                                _numberController.clear();

                                final success = saveSuccess && resetSuccess;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ?  AppLocalizations.of(
                                              context,
                                            )!.succesMajTime 
                                          :  AppLocalizations.of(
                                              context,
                                            )!.errorMajtime,
                                    ),
                                    backgroundColor: success
                                        ? Colors.green
                                        : Colors.orange,
                                    duration: Duration(seconds: 2),
                                  ),
                                );

                                if (success) {
                                  Navigator.pop(context);
                                }

                                if (mounted) {
                                  setState(() {});
                                }
                              }
                            },
                            child: Text(AppLocalizations.of(context)!.valider),
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
