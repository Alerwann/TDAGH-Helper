import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/data/schema/bonus_level_schema.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/pages/SuiviScores/bingo_score.dart';
import 'package:tdahelpe/pages/SuiviScores/bonus_score.dart';
import 'package:tdahelpe/pages/SuiviScores/fonctionnement_score.dart';
import 'package:tdahelpe/pages/SuiviScores/tache_score.dart';
import 'package:tdahelpe/providers/bonus_level_provider.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/widget/utils/buton_theme.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:tdahelpe/widget/utils/translate_key_task.dart';

class AccueilScore extends StatefulWidget {
  const AccueilScore({super.key});

  @override
  State<AccueilScore> createState() => _AccueilScoreState();
}

class _AccueilScoreState extends State<AccueilScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        AppLocalizations.of(context)!.avancementQuete,
        context,
        "accueil",
        false,
        Icon(Icons.home),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Consumer3<ScoreProvider, BonusLevelProvider, ProfilProvider>(
            builder: (context, scoreP, bonusP, profilP, child) {
              final grade =
                  bonusP.getGradeByIndex(scoreP.niveauPersonnal)?? BonusLevel(declancheLevel: 123, gradeName: "Error", description: "Impossible de charger");
              return Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText.center(
                    "${translateGrade(grade, context)} ${profilP.pseudo.toUpperCase()}",
                    Theme.of(context).textTheme.titleMedium,
                  ),

                  CustomText.center(
                    AppLocalizations.of(
                      context,
                    )!.xpNiveau(scoreP.xpByLevel, scoreP.maxXpByLevel),
                    Theme.of(context).textTheme.bodyLarge,
                  ),

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 25,
                      vertical: 5,
                    ),
                    child: StepProgressIndicator(
                      padding: 0,
                      size: 16,
                      totalSteps: 500,
                      currentStep: scoreP.xpByLevel,
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      unselectedColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 30),
                  ButonTheme.standardButton(BingoScore(), "Bingo", context),

                  ButonTheme.standardButton(
                    TacheScore(),
                    AppLocalizations.of(context)!.taches,
                    context,
                  ),

                  ButonTheme.standardButton(
                    BonusScore(),
                    AppLocalizations.of(context)!.pointBonus,
                    context,
                  ),

                  ButonTheme.standardButton(
                    FonctionnementScore(),
                    AppLocalizations.of(context)!.fonctionnement,
                    context,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
