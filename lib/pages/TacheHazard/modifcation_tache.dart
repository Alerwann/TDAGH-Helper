import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/data/schema/taches_shema.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appcar.dart';
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
        appBar: CustomHeightAppcar.customApp("Modifications de la tache", context, "parametre", true),
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
                          "Nom de la nouvelle tache ",
                          Theme.of(context).textTheme.headlineLarge,
                        ),

                        TextFormField(
                          controller: _textController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Nom de l'activité",
                            prefixIcon: Icon(Icons.person),
                            labelText: "Nom de l'activité",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        CustomText.center(
                          "Estimation de la durée ",
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

                        ElevatedButton(
                          onPressed: () {
                            if (_textController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Veuillez saisir un nom d\'activité',
                                  ),
                                ),
                              );
                              return;
                            }

                            TachesSchema tacheNew = TachesSchema(
                              tacheName: _textController.text.trim(),
                              tacheDuration: dureeSelectionnee,
                            );

                            tacheP.modifierTache(
                              widget.tacheComplete.tacheName,
                              tacheNew,
                            );

                            _textController.clear();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tâche modifiée avec succès !'),
                              ),
                            );
                            tacheP.reinitTAche();

                            Navigator.pop(context);
                          },
                          child: Text("Valider"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Retour'),
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
