import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/pages/Bingo%20ok/general_bingo_card.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';

class MomentButton {
  static Widget buildMomentButton(
    String moment,
    IconData icon,
    Color iconColor,
    bool isActive,
    BuildContext context,
  ) {
    int hourMomentdeb = 12;
    int hourMomentfin = 12;
    int scoreByMoment = 0;

    return ElevatedButton(
      onPressed: isActive
          ? () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BingoGamePreview(titleMoment: moment),
              ),
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

                Text(moment, style: Theme.of(context).textTheme.headlineLarge),

                Icon(icon, color: iconColor),
              ],
            ),
            Consumer<HeureProfilProvider>(
              builder: (context, profil, child) {
                switch (moment.toLowerCase()) {
                  case 'matin':
                    hourMomentdeb = profil.reveilHours - 1;
                    hourMomentfin = profil.midiHours + 1;

                    break;
                  case 'midi':
                    hourMomentdeb = profil.midiHours - 1;
                    hourMomentfin = profil.soirhours + 1;

                    break;
                  case 'soir':
                    hourMomentdeb = profil.soirhours - 1;
                    hourMomentfin = profil.coucheHours + 1;

                    break;
                  case 'couché':
                    hourMomentdeb = profil.coucheHours - 1;
                    hourMomentfin = profil.reveilHours + 1;

                    break;
                }
                return isActive
                    ? Text(
                        "Fin d'accès à $hourMomentfin H",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    : Text(
                        "Ouverture à $hourMomentdeb H",
                        style: Theme.of(context).textTheme.bodyMedium,
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
                  case 'couché':
                    scoreByMoment = scoreP.eveningScore;
                    break;
                }
                return Text(
                  " Le score pour le $moment : $scoreByMoment/4",
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
