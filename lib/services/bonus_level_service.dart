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
      rethrow; // ✅ Laisse ErrorHandler gérer
    }
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
