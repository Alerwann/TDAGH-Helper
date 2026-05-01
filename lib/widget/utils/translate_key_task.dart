import 'package:flutter/cupertino.dart';
import 'package:tdahelpe/data/schema/bonus_level_schema.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';

String translateKey(String key, BuildContext context) {
  final l10n = AppLocalizations.of(context)!;

  switch (key) {
    case 'faireLaVaisselle':
      return l10n.faisLaVaisselle;
    case 'laveDouche':
      return l10n.laveDouche;
    case 'poussiere':
      return l10n.poussiere;
    case 'listCourse':
      return l10n.listCourse;
    case 'comptes':
      return l10n.comptes;
    case 'laveWc':
      return l10n.laveWc;
    case 'poubelles':
      return l10n.poubelles;
    default:
      return key;
  }
}

String translateGrade(BonusLevel key, BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final idGrade = key.declancheLevel;
  switch (idGrade) {
    case 0:
      return l10n.grade_0;
    case 1:
      return l10n.grade_1;
    case 2:
      return l10n.grade_2;
    case 3:
      return l10n.grade_3;
    case 4:
      return l10n.grade_4;
    case 5:
      return l10n.grade_5;
          case 6:
      return l10n.grade_6;
    case 7:
      return l10n.grade_7;
    case 8:
      return l10n.grade_8;
    case 9:
      return l10n.grade_9;
    case 10:
      return l10n.grade_10;

    default:
      return l10n.grad_error;
  }
}
