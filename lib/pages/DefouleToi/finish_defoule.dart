import 'package:tdahelpe/core/navigation/app_navigator.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/pages/DefouleToi/game_page.dart';
import 'package:tdahelpe/providers/defoule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/widget/specific/message_record.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:tdahelpe/widget/utils/text_degrade.dart';

class FinishDefoule extends StatefulWidget {
  final int score;
  const FinishDefoule({super.key, required this.score});

  @override
  State<FinishDefoule> createState() => _FinishDefouleState();
}

class _FinishDefouleState extends State<FinishDefoule> {
  bool bestRecord = false;
  bool enregistreRecord = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final defouleP = Provider.of<DefouleProvider>(context, listen: false);
      final scoreP = Provider.of<ScoreProvider>(context, listen: false);
      if (defouleP.scoreDefoule < widget.score) {
        if (defouleP.scoreDefoule != 0) {
          scoreP.incrementDefouleScore();
        }
        defouleP.saveScore(widget.score);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DefouleProvider>(
      builder: (context, defouleP, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                 AppNavigator.goToRoot();
              },
              icon: Icon(Icons.home),
            ),
            automaticallyImplyLeading: false,
            title: TextDegrade(title:  AppLocalizations.of(context)!.resultats, choicetype: 'accueil'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: CustomText.center(
                     AppLocalizations.of(context)!.messageFinScore(widget.score),
                    Theme.of(context).textTheme.headlineLarge,
                  ),
                ),

                MessageRecord(scoreTape:  widget.score,recordTape:  defouleP.scoreDefoule),
                SizedBox(height: 50),

                // bouton réinitialiser
                Container(
                  height: 60,
                  width: 250,
                  margin: EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      AppNavigator.replaceTo(context,GamePage());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.retry, style: TextStyle(fontSize: 20)),
                  ),
                ),

                // Bouton remise à 0
                Container(
                  height: 60,
                  width: 250,
                  margin: EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () async {
                      final success = await defouleP.resetScore();

                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                               AppLocalizations.of(context)!.erreurReinitScore,
                            ),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.remiseAzero, style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
