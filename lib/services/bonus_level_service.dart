import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart'; // Pour rootBundle
import 'package:csv/csv.dart'; // Pour lire le CSV
import 'package:tdahelpe/data/schema/bonus_level_schema.dart';

class BonusLevelService {
  static Future<List<BonusLevel>> loadLevels() async {
    try {
      final csvString = await rootBundle.loadString(
        'assets/data/level_bonus.csv',
      );

      List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvString,
        eol: '\n',
        fieldDelimiter: ';',
      );

      List<BonusLevel> levels = rows
          .skip(1)
          .map((row) => BonusLevel.fromCsv(row))
          .toList();

      if (kDebugMode) {
        print('✅ ${levels.length} grades chargés');
      }

      return levels;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur chargement grades : $e');
      }
      return _getDefaultLevels();
    }
  }

static  List<BonusLevel> _getDefaultLevels() {
    return [
      BonusLevel(
        declancheLevel: 0,
        gradeName: 'Explorateur',
        description: "Tout voyage commence par une exploration.",
      ),
      BonusLevel(
        declancheLevel: 1,
        gradeName: 'Endurant',
        description: "Ton voyage commence à prendre forme tu tiens bien.",
      ),
      BonusLevel(
        declancheLevel: 2,
        gradeName: 'Obstiné',
        description: "Tu veux aller au bout, ça se sent.",
      ),
      BonusLevel(
        declancheLevel: 3,
        gradeName: "Têtu",
        description:
            "D’habitude c’est pas un compliment mais là c’est plus que ça.",
      ),
      BonusLevel(
        declancheLevel: 4,
        gradeName: "Maitre de la Routine",
        description: "Tu es le Yoda des habitudes : sage et constant.",
      ),
      BonusLevel(
        declancheLevel: 5,
        gradeName: "Seigneur des Tâches",
        description: "Ta notoriété commence à faire du bruit.",
      ),
      BonusLevel(
        declancheLevel: 6,
        gradeName: "Roi de l’organisation",
        description: "Tu gères ton quotidien n’a plus de limite.",
      ),
      BonusLevel(
        declancheLevel: 7,
        gradeName: "Dominateur des entraves",
        description: "Tout le monde s’agenouille à ton passage.",
      ),
      BonusLevel(
        declancheLevel: 8,
        gradeName: "Ange de l’habitude",
        description: "Tu voles au dessus des difficultés.",
      ),
      BonusLevel(
        declancheLevel: 9,
        gradeName: "Être suprême de la vie quotidienne",
        description: "La vie quotidienne n’a plus de secret.",
      ),
      BonusLevel(
        declancheLevel: 10,
        gradeName: "Dieu du quotidien",
        description: "On ne peut t’arrêter maintenant, tu nous domines tous.",
      ),
    ];
  }

  static Future<BonusLevel?> getLevelReward(int currentLevel) async {
    try {
      final levels = await loadLevels();

      return levels.firstWhere((level) => level.declancheLevel == currentLevel);
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Niveau $currentLevel non trouvé: $e');
      }
      return null;
    }
  }
}
