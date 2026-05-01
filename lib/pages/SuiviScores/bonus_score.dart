import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/core/navigation/app_navigator.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/pages/DefouleToi/defoule_toi.dart';
import 'package:tdahelpe/pages/TimerTooth/home_timer_tooth.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class BonusScore extends StatefulWidget {
  const BonusScore({super.key});

  @override
  State<BonusScore> createState() => _BonusScoreState();
}

class _BonusScoreState extends State<BonusScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        AppLocalizations.of(context)!.pointBonusSuivi,
        context,
        'accueil',
        true,
        Icon(Icons.arrow_back_rounded),
      ),
      body: Consumer2<ScoreProvider, ProfilProvider>(
        builder: (context, scoreP, profilP, child) {
          final int nbCleantooth = (scoreP.toothScore / 5).floor();
          final int nbRecord = (scoreP.defouleScore / 5).floor();
          return Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText.center(
                    AppLocalizations.of(context)!.dentScore(scoreP.toothScore),
                    Theme.of(context).textTheme.headlineMedium,
                  ),

                  SizedBox(
                    width: 300,
                    child: StepProgressIndicator(
                      totalSteps: 3,
                      currentStep: nbCleantooth,
                      padding: 6.0,
                      size: 12,
                      progressDirection: TextDirection.ltr,
                      selectedColor: Colors.green,
                      unselectedColor: Colors.black12,
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.yellowAccent,
                          const Color.fromARGB(255, 49, 236, 7),
                        ],
                      ),
                      unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color.fromARGB(255, 228, 112, 4),
                          const Color.fromARGB(255, 246, 6, 6),
                        ],
                      ),
                    ),
                  ),

                  nbCleantooth != 3
                      ? CustomText.center(
                         
                          AppLocalizations.of(
                            context,
                          )!.nbrLavageRestant(3 - nbCleantooth),
                          Theme.of(context).textTheme.headlineSmall,
                        )
                      : CustomText.center(
                          AppLocalizations.of(context)!.validNbLavage,
                          Theme.of(context).textTheme.headlineSmall,
                        ),

                  OutlinedButton(
                    onPressed: () {
                      AppNavigator.replaceTo(context, HomeTimertooth());
                    },
                    child: Text(AppLocalizations.of(context)!.redictDent),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: CustomText.center(
                      AppLocalizations.of(
                        context,
                      )!.defouleScore(scoreP.defouleScore),
                      Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: StepProgressIndicator(
                      totalSteps: 4,
                      currentStep: nbRecord,
                      padding: 6.0,
                      size: 12,
                      progressDirection: TextDirection.ltr,
                      selectedColor: Colors.green,
                      unselectedColor: Colors.black12,
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.yellowAccent,
                          const Color.fromARGB(255, 49, 236, 7),
                        ],
                      ),
                      unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color.fromARGB(255, 228, 112, 4),
                          const Color.fromARGB(255, 246, 6, 6),
                        ],
                      ),
                    ),
                  ),

                  nbRecord < 4
                      ? CustomText.center(
                          AppLocalizations.of(
                            context,
                          )!.resteDefoule(4 - nbRecord),
                          Theme.of(context).textTheme.headlineSmall,
                        )
                      : CustomText.center(
                          AppLocalizations.of(context)!.felicitationRecord,
                          Theme.of(context).textTheme.headlineSmall,
                        ),
                  OutlinedButton(
                    onPressed: () {
                      AppNavigator.replaceTo(context, HomeDefouleToi());
                    },
                    child: Text(AppLocalizations.of(context)!.redirectDefoul),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
