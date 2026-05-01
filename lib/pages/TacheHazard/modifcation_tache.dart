import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/data/schema/taches_shema.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class ModifcationTache extends StatefulWidget {
  final TachesSchema tacheComplete;

  const ModifcationTache({super.key, required this.tacheComplete});

  @override
  State<ModifcationTache> createState() => _ModifcationTacheState();
}

class _ModifcationTacheState extends State<ModifcationTache> {
  final TextEditingController _textController = TextEditingController();
  late TacheDuration dureeSelectionnee = widget.tacheComplete.tacheDuration;
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _textController.text = widget.tacheComplete.tacheName;
    dureeSelectionnee = widget.tacheComplete.tacheDuration;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomHeightApBcar.customApp(
          AppLocalizations.of(context)!.modifTache,
          context,
          "parametre",
          true,
          Icon(Icons.arrow_back_rounded),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Consumer<TachesProvider>(
              builder: (context, tacheP, child) {
                return Container(
                  margin: EdgeInsets.only(top: 30),

                  child: Form(
                    child: Column(
                      spacing: 15,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText.center(
                         AppLocalizations.of(context)!.newTaskName,
                          Theme.of(context).textTheme.headlineLarge,
                        ),

                        TextFormField(
                          controller: _textController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.activityName,
                            prefixIcon: Icon(Icons.person),
                            labelText: AppLocalizations.of(context)!.activityName,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        CustomText.center(
                          AppLocalizations.of(context)!.estimationDuree,
                          Theme.of(context).textTheme.headlineLarge,
                        ),

                        SizedBox(
                          height: 190,
                          child: Card(
                            child: RadioGroup(
                              groupValue: dureeSelectionnee,
                              onChanged: (TacheDuration? value) {
                                if (value != null) {
                                  setState(() {
                                    dureeSelectionnee = value;
                                  });
                                }
                              },

                              child: GridView.count(
                                controller: ScrollController(
                                  keepScrollOffset: false,
                                ),
                                crossAxisCount: 2,
                                childAspectRatio: 3,

                                children: [
                                  SizedBox(
                                    child: RadioListTile<TacheDuration>(
                                      title: Text(
                                        AppLocalizations.of(context)!.court,
                                      ),
                                      value: TacheDuration.court,
                                    ),
                                  ),

                                  SizedBox(
                                    child: RadioListTile<TacheDuration>(
                                      title: Text(
                                        AppLocalizations.of(context)!.moyen,
                                      ),
                                      value: TacheDuration.moyen,
                                    ),
                                  ),

                                  RadioListTile<TacheDuration>(
                                    title: Text(
                                      AppLocalizations.of(context)!.long,
                                    ),
                                    value: TacheDuration.long,
                                  ),

                                  RadioListTile<TacheDuration>(
                                    title: Text(
                                      AppLocalizations.of(context)!.tresLong,
                                    ),
                                    value: TacheDuration.tresLong,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            if (_textController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!.saisiNomAct,
                                  ),
                                ),
                              );
                              return;
                            }

                            TachesSchema tacheNew = TachesSchema(
                              tacheName: _textController.text.trim(),
                              tacheDuration: dureeSelectionnee,
                              isCustom: true
                            );

                            tacheP.modifierTache(
                              widget.tacheComplete.tacheName,
                              tacheNew,
                            );

                            _textController.clear();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!.succesModif,
                                ),
                              ),
                            );
                            tacheP.reinitTache();

                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.valider),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.retour),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
