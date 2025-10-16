import 'package:flutter/material.dart';

class CustomText {
  static Widget center(String inputText, TextStyle? inputTheme) {
    return Text(inputText, textAlign: TextAlign.center, style: inputTheme);
  }

  static Widget left(String inputText, TextStyle? inputTheme) {
    return Text(inputText, textAlign: TextAlign.left, style: inputTheme);
  }

  static Widget right(String inputText, TextStyle? inputTheme) {
    return Text(inputText, textAlign: TextAlign.right, style: inputTheme);
  }
}
