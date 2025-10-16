import 'dart:ui';
import 'package:tdahelpe/data/schema/activity_card_schema.dart';
import 'package:tdahelpe/pages/Bingo%20ok/homepage.dart';
import 'package:tdahelpe/pages/DefouleToi/defoule_toi.dart';
import 'package:tdahelpe/pages/TacheHazard/accueil_taches.dart';
import 'package:tdahelpe/pages/TimerTooth/home_timer_tooth.dart';

class ActivityList {
  static final List<ActivityCard> _defaultCards = [
    ActivityCard(
      activityName: 'Bingo',
      imagePath: 'assets/images/bingo_images/bingoLogo.png',
      destination: HomeBingoPage(),
      firstColor: Color.fromARGB(255, 70, 220, 210),
      secondColor: Color.fromARGB(255, 230, 130, 240),
      backColor: Color.fromARGB(208, 255, 230, 6),
    ),
    ActivityCard(
      activityName: 'Tire Tâches',
      imagePath: 'assets/images/Tacheslogo.png',
      destination: AccueilTaches(),
      firstColor: Color.fromARGB(255, 23, 189, 230),
      secondColor: Color.fromARGB(255, 243, 120, 177),
      backColor: Color.fromARGB(121, 230, 255, 5),
    ),
    ActivityCard(
      activityName: 'Brosse à Dents',
      imagePath: 'assets/images/timerdent.png',
      destination: HomeTimertooth(),
      firstColor: Color.fromARGB(255, 255, 214, 118),
      secondColor: Color.fromARGB(255, 248, 7, 28),
      backColor: Color.fromARGB(167, 181, 253, 0),
    ),

    ActivityCard(
      activityName: 'Défoulage',
      imagePath: 'assets/images/rageux.png',
      destination: HomeDefouleToi(),
      firstColor: Color.fromARGB(255, 255, 214, 118),
      secondColor: Color.fromARGB(255, 248, 7, 28),
      backColor: Color.fromARGB(99, 3, 216, 92),
    ),
  ];
  static List<ActivityCard> getDefaultCards() {
    return List.from(_defaultCards);
  }
}
