import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/core/navigation/app_navigator.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/pages/Bingo/general_bingo_card.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/utils/horaire_moment.dart';

class MomentButton extends StatelessWidget {
  final String moment;
  final String afficheMoment;
  final IconData icon;
  final Color iconColor;

  const MomentButton({
    super.key,

    required this.icon,
    required this.iconColor,
    required this.moment,
    required this.afficheMoment
  });

  @override
  Widget build(BuildContext context) {
    int scoreByMoment = 0;

    return ElevatedButton(
      onPressed: HoraireMoment.isMomentAccessible(moment, context)
          ? () => AppNavigator.push(
              context,
              BingoGamePreview(titleMoment: moment),
            )
          : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Column(
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Icon(icon, color: iconColor),
                Text(afficheMoment, style: Theme.of(context).textTheme.headlineLarge),
                Icon(icon, color: iconColor),
              ],
            ),
            Consumer<HeureProfilProvider>(
              builder: (context, profil, child) {
                final horaires = HoraireMoment.momentPhrase(moment, context);
                return HoraireMoment.isMomentAccessible(moment, context)
                    ? Text(
                        AppLocalizations.of(
                          context,
                        )!.labelFinAcces(horaires[1]),
                      )
                    : Text(
                        AppLocalizations.of(
                          context,
                        )!.labelOuverture(horaires[0]),
                      );
              },
            ),

            Consumer<ScoreProvider>(
              builder: (context, scoreP, child) {
                switch (moment.toLowerCase()) {
                  case 'matin':
                    scoreByMoment = scoreP.morningScore;
                    break;
                  case 'midi':
                    scoreByMoment = scoreP.midiScore;
                    break;
                  case 'soir':
                    scoreByMoment = scoreP.afternoonScore;
                    break;
                  case 'coucher':
                    scoreByMoment = scoreP.eveningScore;
                    break;
                }
                return Text(
                  AppLocalizations.of(
                    context,
                  )!.scoreMoment(moment, scoreByMoment),
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
