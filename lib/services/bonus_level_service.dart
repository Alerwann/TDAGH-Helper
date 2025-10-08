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
        eol: '\n', // End of line = retour à la ligne
        fieldDelimiter: ';', // Ton séparateur (point-virgule)
      );
      List<BonusLevel> levels = rows
          .skip(1) // Ignorer la première ligne (headers)
          .map((row) => BonusLevel.fromCsv(row)) // Transformer chaque ligne
          .toList(); // Convertir en liste

      print('✅ ${levels.length} grades chargés');
      return levels;
    } catch (e) {
      print('❌ Erreur lors du chargement des grades : $e');
      return [];
    }
  }
    static Future<BonusLevel?> getLevelReward(int currentLevel) async {
   
    final levels = await loadLevels();

    try {
      return levels.firstWhere((level) => level.declancheLevel == currentLevel);
    } catch (e) {
    
      return null;
    }
  }
}
