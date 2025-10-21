import 'package:flutter/foundation.dart';
import 'package:tdahelpe/data/schema/bonus_level_schema.dart';
import 'package:tdahelpe/services/bonus_level_service.dart';

class BonusLevelProvider extends ChangeNotifier {
  List<BonusLevel> _levels = [];
  bool _isLoading = true;

  List<BonusLevel> get levels => _levels;
  bool get isLoading => _isLoading;
  BonusLevelProvider() {
    if (kDebugMode) {
      print('🎯 BonusLevelProvider créé');
    }
    _loadLevels();
  }

  // Pour l'instant, méthode vide
  Future<void> _loadLevels() async {
    if (kDebugMode) {
      print('📥 Début du chargement des grades...');
    }

    _isLoading = true;
    notifyListeners();

    _levels = await BonusLevelService.loadLevels();

    if (kDebugMode) {
      print('✅ ${_levels.length} grades chargés dans le provider');
    }

    _isLoading = false;
    notifyListeners();
  }

  BonusLevel? getCurrentGrade(int currentLevel) {
    int gradeIndex = currentLevel ~/ 5;

    
    if (gradeIndex >= _levels.length) {

      return _levels.isNotEmpty ? _levels.last : null;
    }

 
    try {
      return _levels.firstWhere((level) => level.declancheLevel == gradeIndex);
    } catch (e) {
      return null;
    }
  }

  BonusLevel? getGradeByIndex(int index) {
    try {
      return _levels.firstWhere((level) => level.declancheLevel == index);
    } catch (e) {
      return null;
    }
  }

  BonusLevel? getNextGrade(int currentLevel) {
    int currentIndex = currentLevel ~/ 5;
    int nextIndex = currentIndex + 1;

    if (nextIndex >= _levels.length) {
      return null; // Plus de grades
    }

    return getGradeByIndex(nextIndex);
  }


  int? getNextGradeLevel(int currentLevel) {
    int currentIndex = currentLevel ~/ 5;
    int nextIndex = currentIndex + 1;

    if (nextIndex >= _levels.length) {
      return null;
    }

 
    return nextIndex * 5;
  }
}
