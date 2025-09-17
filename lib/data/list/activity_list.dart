import 'dart:ui';
import 'package:flutter_application_1/data/schema/activity_card_schema.dart';
import 'package:flutter_application_1/pages/Bingo/homepage.dart';
import 'package:flutter_application_1/pages/DefouleToi/defoule_toi.dart';
import 'package:flutter_application_1/pages/TacheHazard/tache_liste_affichage.dart';

import 'package:flutter_application_1/pages/TimerTooth/home_timer_tooth.dart';

class ActivityList {
  static final List<ActivityCard> _defaultCards = [
    ActivityCard(
      activityName: 'Bingo',
      imagePath: 'assets/images/bingo_images/bingoLogo.png',
      destination: HomeBingoPage(),
      firstColor: Color.fromARGB(255, 70, 220, 210),
      secondColor: Color.fromARGB(255, 230, 130, 240),
    ),
    ActivityCard(
      activityName: 'Timer brosse à dent',
      imagePath: 'assets/images/timerdent.png',
      destination: HomeTimertooth(),
      firstColor: Color.fromARGB(255, 23, 189, 230),
      secondColor: Color.fromARGB(255, 243, 120, 177),
    ),
    ActivityCard(
      activityName: 'Tache au hasard',
      imagePath: 'assets/images/Tacheslogo.png',
      destination: TacheListeAffichage(),
      firstColor: Color.fromARGB(255, 241, 203, 145),
      secondColor: Color.fromARGB(255, 17, 220, 156),
    ),
    ActivityCard(
      activityName: 'Défoulage',
      imagePath: 'assets/images/rageux.png',
      destination: HomeDefouleToi(),
      firstColor: Color.fromARGB(255, 255, 214, 118),
      secondColor: Color.fromARGB(255, 248, 7, 28),
    ),
  ];
  static List<ActivityCard> getDefaultCards() {
    return List.from(_defaultCards);
  }
}
