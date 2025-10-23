import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/widget/specific/horaire_champs.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';

class ModifHoraire extends StatefulWidget {
  const ModifHoraire({super.key});

  @override
  State<ModifHoraire> createState() => _ModifHoraireState();
}

class _ModifHoraireState extends State<ModifHoraire> {
  TextEditingController matinController = TextEditingController();
  TextEditingController midiController = TextEditingController();
  TextEditingController soirController = TextEditingController();
  TextEditingController coucherController = TextEditingController();
  TextEditingController reinitController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final heureP = Provider.of<HeureProfilProvider>(context, listen: false);
      matinController.text = heureP.reveilHours.toString();
      midiController.text = heureP.midiHours.toString();
      soirController.text = heureP.soirHours.toString();
      coucherController.text = heureP.coucherHours.toString();
      reinitController.text = heureP.reinitHours.toString();
    });
  }

  @override
  void dispose() {
    matinController.dispose();
    midiController.dispose();
    soirController.dispose();
    coucherController.dispose();
    reinitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        "Modification d'horaires",
        context,
        "parametre",
        true,
        Icon(Icons.arrow_back_rounded),
      ),
      body: Consumer<HeureProfilProvider>(
        builder: (context, heureP, child) {
          return Center(
            child: Form(
              key: _formKey,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 15,
                    children: [
                      HoraireChamps(
                        moment: "matin",
                        momentController: matinController,
                      ),
                      HoraireChamps(
                        moment: "midi",
                        momentController: midiController,
                      ),
                      HoraireChamps(
                        moment: "soir",
                        momentController: soirController,
                      ),
                      HoraireChamps(
                        moment: "coucher ",
                        momentController: coucherController,
                      ),
                      HoraireChamps(
                        moment: "reinit ",
                        momentController: reinitController,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              heureP.setHours(
                                int.parse(matinController.text),
                                'reveil',
                              );
                              heureP.setHours(
                                int.parse(midiController.text),
                                'midi',
                              );
                              heureP.setHours(
                                int.parse(soirController.text),
                                'soir',
                              );
                              heureP.setHours(
                                int.parse(coucherController.text),
                                'coucher',
                              );
                              heureP.setHours(
                                int.parse(reinitController.text),
                                'reinit',
                              );
                              FocusScope.of(context).requestFocus(FocusNode());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Les alarmes sont mises à jour.',
                                  ),
                                  duration: Duration(milliseconds: 1000),
                                ),
                              );
                            }
                          },
                          child: Text("Valider"),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Réinitialiser ?'),
                                content: Text(
                                  'Toutes tes données seront perdues.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      heureP.resetAllHours().then((_) {
                                        matinController.text = heureP
                                            .reveilHours
                                            .toString();
                                        midiController.text = heureP.midiHours
                                            .toString();
                                        soirController.text = heureP.soirHours
                                            .toString();
                                        coucherController.text = heureP
                                            .coucherHours
                                            .toString();
                                        reinitController.text = heureP
                                            .reinitHours
                                            .toString();
                                      });
                                    },
                                    child: Text('Confirmer'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                          label: Text('Réinitialiser'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
