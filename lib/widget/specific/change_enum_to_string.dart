import 'package:flutter/material.dart';

class ChangeEnumToString {
  static Color changeEnumtoString(String enumName) {
    Color colorAssigne = Colors.black;
    switch (enumName) {
      case 'court':
        colorAssigne = Colors.green;
        break;
      case 'moyen':
        colorAssigne = const Color.fromARGB(255, 209, 227, 9);
        break;
      case 'long':
        colorAssigne = const Color.fromARGB(255, 205, 1, 1);
        break;
      case 'tresLong':
        colorAssigne = const Color.fromARGB(255, 139, 1, 1);
        break;
    }
    return colorAssigne;
  }
}
