import 'package:flutter/material.dart';
import 'package:tdahelpe/core/navigation/app_navigator.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/pages/DefouleToi/game_page.dart';
import 'package:tdahelpe/pages/DefouleToi/modif_timer_game.dart';
import 'package:tdahelpe/providers/defoule_provider.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class HomeDefouleToi extends StatefulWidget {
  const HomeDefouleToi({super.key});

  @override
  State<HomeDefouleToi> createState() => _HomeDefouleToiState();
}

class _HomeDefouleToiState extends State<HomeDefouleToi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        AppLocalizations.of(context)!.defouleToi,
        context,
        "accueil",
        true,
        Icon(Icons.home),
      ),
      body: Consumer2<DefouleProvider, ScoreProvider>(
        builder: (context, defouleP, scoreP, child) {
          return Center(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText.center(
                  AppLocalizations.of(context)!.lerecord ,
                  Theme.of(context).textTheme.titleMedium,
                ),
                CustomText.center(
                  " ${defouleP.scoreDefoule}",
                  Theme.of(context).textTheme.titleMedium,
                ),

                CustomText.center(
                  AppLocalizations.of(context)!.tempsPartie  ,
                  Theme.of(context).textTheme.titleMedium,
                ),
                CustomText.center(
                  " ${defouleP.timerDuration} s",
                  Theme.of(context).textTheme.titleMedium,
                ),

                SizedBox(height: 10),

                // bouton Start
                SizedBox(
                  width: 260,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      AppNavigator.push(context, GamePage());
                    },
                    child: Text("Start"),
                  ),
                ),

                // bouton modifier timer
                SizedBox(
                  width: 260,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      await AppNavigator.push(context, ModifTimerGame());
                    },
                    child: Text(AppLocalizations.of(context)!.modifTimer),
                  ),
                ),
                SizedBox(height: 10),

                // réinitialisation timer
                SizedBox(
                  width: 260,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      final success = await defouleP.resetScore();

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.scoreReinitValid,
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.erreurReinitScore,
                            ),
                            backgroundColor: Colors.orange,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }

                      setState(() {});
                    },
                    child: Text(AppLocalizations.of(context)!.remiseAzero),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
