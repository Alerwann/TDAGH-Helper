import 'package:flutter/material.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class MessageRecord extends StatelessWidget {
  final int scoreTape;
  final int recordTape;
  const MessageRecord({super.key, required this.scoreTape, required this.recordTape});

  @override
  Widget build(BuildContext context) {
   if (recordTape < scoreTape) {
      return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: [
            CustomText.center(
              AppLocalizations.of(context)!.bestRecord,
              Theme.of(context).textTheme.headlineMedium,
            ),
            Text("🤗", style: TextStyle(fontSize: 60)),
          ],
        ),
      );
    } 
    // Message si record non battu
    else if(recordTape>scoreTape){
      return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: [
            CustomText.center(
              AppLocalizations.of(context)!.recordMessage(recordTape),
              Theme.of(context).textTheme.headlineMedium,
            ),
            Text("😭", style: TextStyle(fontSize: 40)),
          ],
        ),
      );
    }else{
       return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: [
            CustomText.center(
             AppLocalizations.of(context)!.egalRecord,
              Theme.of(context).textTheme.headlineMedium,
            ),
            Text("😉", style: TextStyle(fontSize: 40)),
          ],
        ),
      );
    }
  }
  }
