import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class FonctionnementScore extends StatelessWidget {
  const FonctionnementScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        AppLocalizations.of(context)!.fonctionnement,
        context,
        "parametre",
        true,
        Icon(Icons.arrow_back_rounded),
      ),
      body: Consumer2<ScoreProvider, HeureProfilProvider>(
        builder: (context, scoreP, heurP, child) {
          return Center(
            child: SizedBox(
              width: 350,
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      CustomText.center(
                        AppLocalizations.of(context)!.regleNiveau,
                        Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomText.center(
                        AppLocalizations.of(context)!.explainXp(scoreP.maxXpByLevel),
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        AppLocalizations.of(context)!.regleReinitialisation,
                        Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomText.center(
                        AppLocalizations.of(context)!.reinitHeure(heurP.reinitHours),
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        AppLocalizations.of(context)!.explainReinit,
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                       AppLocalizations.of(context)!.bingoExplainPoint,
                        Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomText.center(
                        AppLocalizations.of(context)!.bingoCount,
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                       AppLocalizations.of(context)!.explainTache,
                        Theme.of(context).textTheme.titleSmall,
                      ),

                      CustomText.center(
                        AppLocalizations.of(context)!.countTAchePoint,
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        AppLocalizations.of(context)!.explainDefoule,
                        Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomText.center(
                        AppLocalizations.of(context)!.explainDent,
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                        AppLocalizations.of(context)!.dentPoint,
                        Theme.of(context).textTheme.bodyLarge,
                      ),
                      CustomText.center(
                       AppLocalizations.of(context)!.maxPontAct,
                        Theme.of(context).textTheme.bodyLarge,
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
