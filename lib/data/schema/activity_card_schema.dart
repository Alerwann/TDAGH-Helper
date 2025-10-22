import 'package:flutter/widgets.dart';

class ActivityCard {
  final String activityName;
  final String imagePath;
  final Widget destination;
  final Color backColor;

  ActivityCard({
    required this.activityName,
    required this.imagePath,
    required this.destination,
    required this.backColor,
  });
}
