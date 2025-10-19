import 'package:flutter/material.dart';
import 'package:tdahelpe/widget/utils/text_degrade.dart';

class CustomHeightApBcar {
  static double heightAppbar(String textInput, BuildContext context) {
    int maxLines = 1;

    final TextScaler textScaler = MediaQuery.textScalerOf(context);

    final screenWidth = (MediaQuery.of(context).size.width) - 100;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: textInput,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    );

    textPainter.layout(maxWidth: screenWidth);
    print("❓ textpaint maxline: ${textPainter.didExceedMaxLines}");

    while (textPainter.didExceedMaxLines) {
      maxLines += 1;
      textPainter = TextPainter(
        text: TextSpan(
          text: textInput,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
        textScaler: textScaler,
      );

      textPainter.layout(maxWidth: screenWidth);
    }


    return textPainter.height + 20;
  }

  static AppBar customApp(
    String title,
    BuildContext context,
    String typeApp,
    bool returnHome,
  ) {
    AppBar returnApp = AppBar(
      toolbarHeight: CustomHeightApBcar.heightAppbar(title, context),
      title: TextDegrade(title: title, choicetype: typeApp),
      leading: returnHome
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.home),
            )
          : null,
    );

    return returnApp;
  }
}
