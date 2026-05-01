import 'package:flutter/material.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class PersoAlertDialog {

static void showInfoDialog(BuildContext context ,String title, String message  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomText.center(title, TextTheme.of(context).bodySmall),
        content: CustomText.center(
          message,
          TextTheme.of(context).bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(AppLocalizations.of(context)!.ferme, style: TextStyle(color: Color(0xFF00CC44))),
          ),
        ],
      ),
    );
  }
}