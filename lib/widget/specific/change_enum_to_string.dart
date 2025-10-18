import 'package:flutter/material.dart';

class ChangeEnumToString {

  static Color changeEnumtoString(String enumName) {


    // String convertValue = "";
    Color colorAssigne = Colors.black;
    switch (enumName) {
      case 'court':
        // convertValue = 'Court';
        colorAssigne = Colors.green;
        break;
      case 'moyen':
        // convertValue = 'Moyen';
        colorAssigne = const Color.fromARGB(255, 209, 227, 9);
        break;
      case 'long':
        // convertValue = 'Long';
        colorAssigne = const Color.fromARGB(255, 205, 1, 1);
        break;
      case 'tresLong':
        // convertValue = 'Très long';
        colorAssigne = const Color.fromARGB(255, 139, 1, 1);
        break;
    }
    return colorAssigne;
  }
}
