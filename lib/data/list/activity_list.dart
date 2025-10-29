import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tdahelpe/data/schema/activity_card_schema.dart';
import 'package:tdahelpe/pages/Bingo/homepage.dart';
import 'package:tdahelpe/pages/DefouleToi/defoule_toi.dart';
import 'package:tdahelpe/pages/TacheHazard/accueil_taches.dart';
import 'package:tdahelpe/pages/TimerTooth/home_timer_tooth.dart';

class ActivityList {
  static final List<ActivityCard> _defaultCards = [
    ActivityCard(
      activityName: 'Bingo',
      imagePath: 'assets/images/bingo_images/bingoLogo.png',
      destination: HomeBingoPage(),
      backColor: Color.fromARGB(255, 224, 240, 5),
    ),
    ActivityCard(
      activityName: 'Tire Tâches',
      imagePath: 'assets/images/Tacheslogo.png',
      destination: AccueilTaches(),
      backColor: Color.fromARGB(255, 221, 235, 93),
    ),
    ActivityCard(
      activityName: 'Brosse à Dents',
      imagePath: 'assets/images/timerdent.png',
      destination: HomeTimertooth(),
      backColor: Color.fromARGB(255, 131, 219, 54),
    ),

    ActivityCard(
      activityName: 'Défoule-Toi',
      imagePath: 'assets/images/rageux.png',
      destination: HomeDefouleToi(),
      backColor: Color.fromARGB(255, 96, 189, 20),
    ),
  ];
  static List<ActivityCard> getDefaultCards() {
    return List.from(_defaultCards);
  }
}
