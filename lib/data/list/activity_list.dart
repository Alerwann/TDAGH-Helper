
import 'package:flutter/material.dart';
import 'package:tdahelpe/data/schema/activity_card_schema.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/pages/Bingo/homepage.dart';
import 'package:tdahelpe/pages/DefouleToi/defoule_toi.dart';
import 'package:tdahelpe/pages/TacheHazard/accueil_taches.dart';
import 'package:tdahelpe/pages/TimerTooth/home_timer_tooth.dart';

class ActivityList {
 static List<ActivityCard> getCards(BuildContext context)
 
  {
    return[
    ActivityCard(
      activityName: AppLocalizations.of(context)!.aideDents,
      imagePath: 'assets/images/bingo_images/bingoLogo.png',
      destination: HomeBingoPage(),
      backColor: Color.fromARGB(255, 224, 240, 5),
    ),
    ActivityCard(
      activityName: AppLocalizations.of(context)!.tireTache,
      imagePath: 'assets/images/Tacheslogo.png',
      destination: AccueilTaches(),
      backColor: Color.fromARGB(255, 221, 235, 93),
    ),
    ActivityCard(
      activityName: AppLocalizations.of(context)!.aideDents,
      imagePath: 'assets/images/timerdent.png',
      destination: HomeTimertooth(),
      backColor: Color.fromARGB(255, 131, 219, 54),
    ),

    ActivityCard(
      activityName: AppLocalizations.of(context)!.defouleToi,
      imagePath: 'assets/images/rageux.png',
      destination: HomeDefouleToi(),
      backColor: Color.fromARGB(255, 96, 189, 20),
    ),
  ];}
  
}
