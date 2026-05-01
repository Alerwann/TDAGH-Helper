import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
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
        AppLocalizations.of(context)!.modifHoraire,
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
                        moment: AppLocalizations.of(
                          context,
                        )!.matin,
                        momentController: matinController,
                      ),
                      HoraireChamps(
                        moment: AppLocalizations.of(context)!.midi,
                        momentController: midiController,
                      ),
                      HoraireChamps(
                        moment: AppLocalizations.of(
                          context,
                        )!.soir,
                        momentController: soirController,
                      ),
                      HoraireChamps(
                        moment: AppLocalizations.of(
                          context,
                        )!.coucher,
                        momentController: coucherController,
                      ),
                      HoraireChamps(
                        moment: "reinit",
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
                                 SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!.validMajAlarm,
                                  ),
                                  duration: Duration(milliseconds: 1000),
                                ),
                              );
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.valider),
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
                                title: Text(
                                  AppLocalizations.of(context)!.reinit,
                                ),
                                content: Text(
                                  AppLocalizations.of(context)!.attentionPerteDonnee,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: Text(
                                      AppLocalizations.of(context)!.annuler,
                                    ),
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
                                    child: Text(
                                      AppLocalizations.of(context)!.confirmer,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                          label: Text(AppLocalizations.of(context)!.reinit),
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
