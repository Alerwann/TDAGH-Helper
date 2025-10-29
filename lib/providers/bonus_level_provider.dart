import 'package:flutter/foundation.dart';
import 'package:tdahelpe/data/schema/bonus_level_schema.dart';
import 'package:tdahelpe/services/bonus_level_service.dart';
import 'package:tdahelpe/utils/error_handler.dart';

class BonusLevelProvider extends ChangeNotifier {
  List<BonusLevel> _levels = [];
  bool _isLoading = true;
  List<BonusLevel> get levels => _levels;
  bool get isLoading => _isLoading;

  BonusLevelProvider() {
    _loadLevels();
  }

  Future<void> _loadLevels() async {
    _isLoading = true;
    notifyListeners();

    _levels =
        await ErrorHandler.handleAsync(
          () => BonusLevelService.loadLevels(),
          errorMessage: 'Impossible de charger le niveau',
          defaultValue: [],
        ) ??
        [];

    _isLoading = false;
    notifyListeners();
  }

  BonusLevel? getCurrentGrade(int currentLevel) {
    if (_levels.isEmpty) {
      if (kDebugMode) {
        print('⚠️ getCurrentGrade: Aucun grade chargé');
      }
      return null;
    }
    int gradeIndex = currentLevel ~/ 5;

    if (gradeIndex >= _levels.length) {
      if (kDebugMode) {
        print(
          '🏆 getCurrentGrade: Niveau max atteint (${_levels.last.gradeName})',
        );
      }
      return _levels.last;
    }

    final grade = _levels.firstWhere(
      (level) => level.declancheLevel == gradeIndex,
      orElse: () {
        if (kDebugMode) {
          print('⚠️ getCurrentGrade: Grade index $gradeIndex non trouvé');
        }

        return _levels.first;
      },
    );

    if (kDebugMode) {
      print('✅ getCurrentGrade(niveau $currentLevel) → ${grade.gradeName}');
    }

    return grade;
  }

  BonusLevel? getGradeByIndex(int index) {
    if (_levels.isEmpty) {
      return null;
    }

    // ✅ Utilise firstWhere avec orElse
    final grade = _levels.firstWhere(
      (level) => level.declancheLevel == index,
      orElse: () {
        return _levels.first; // Valeur par défaut
      },
    );

    return grade;
  }

  BonusLevel? getNextGrade(int currentLevel) {
    if (_levels.isEmpty) {
      return null;
    }

    int currentIndex = currentLevel ~/ 5;
    int nextIndex = currentIndex + 1;

    if (nextIndex >= _levels.length) {
      return null; // Plus de grades
    }

    final nextGrade = getGradeByIndex(nextIndex);

    return nextGrade;
  }

  int? getNextGradeLevel(int currentLevel) {
    if (_levels.isEmpty) {
      return null;
    }

    int currentIndex = currentLevel ~/ 5;
    int nextIndex = currentIndex + 1;

    if (nextIndex >= _levels.length) {
      return null;
    }

    final nextLevel = nextIndex * 5;

    return nextLevel;
  }
}
