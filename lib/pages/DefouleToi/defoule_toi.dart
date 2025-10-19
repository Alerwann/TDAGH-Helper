import 'package:flutter/material.dart';
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
        "Défoule toi",
        context,
        "accueil",
        true,
      ),
      body: Consumer2<DefouleProvider, ScoreProvider>(
        builder: (context, defouleP, scoreP, child) {
          return Center(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText.center(
                  "Le record :",
                  Theme.of(context).textTheme.titleMedium,
                ),
                CustomText.center(
                  " ${defouleP.scoreDefoule}",
                  Theme.of(context).textTheme.titleMedium,
                ),

                CustomText.center(
                  "Temps d'une partie :",
                  Theme.of(context).textTheme.titleMedium,
                ),
                CustomText.center(
                  " ${defouleP.timerDuration} s",
                  Theme.of(context).textTheme.titleMedium,
                ),

                SizedBox(height: 10),
                SizedBox(
                  width: 260,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GamePage()),
                      );
                    },
                    child: Text("Start"),
                  ),
                ),

                SizedBox(
                  width: 260,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (contex) => ModifTimerGame(),
                        ),
                      );
                    },
                    child: Text("Modifier timer"),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 260,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      await defouleP.resetScore();

                      print("✅ Score:  ${defouleP.scoreDefoule}");

                      setState(() {});
                    },
                    child: Text("Remise à 0"),
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
