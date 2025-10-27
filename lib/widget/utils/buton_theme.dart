import 'package:flutter/material.dart';
import 'package:tdahelpe/core/navigation/app_navigator.dart';

class ButonTheme {

  static SizedBox  standardButton (Widget redirectionW, String titleButon, BuildContext context){
     return SizedBox(
      height: 60,
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          AppNavigator.push(context, redirectionW);
        },
        child: Text(titleButon),
      ),
    );
  }

  static   SizedBox boutonOfParametre(
    String label,
    IconData iconName,
    Widget directionW,
    BuildContext context
  ) {
    return SizedBox(
      width: 300,
      child: ElevatedButton.icon(
        onPressed: () {
          AppNavigator.push(context, directionW);
        },
        label: Text(label),
        icon: Icon(iconName, color: Color.fromARGB(225, 1, 112, 81)),
      ),
    );
  }
}