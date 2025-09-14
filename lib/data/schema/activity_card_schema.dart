import 'package:flutter/widgets.dart';

class ActivityCard {
  final String activityName;
  final String imagePath;
  final Widget destination;
  final Color firstColor;
  final Color secondColor;


  ActivityCard({
    required this.activityName,
    required this.imagePath,
    required this.destination,
    required this.firstColor,
    required this.secondColor,
  });
}
