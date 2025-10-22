import 'package:flutter/material.dart';
import 'package:tdahelpe/services/horaire_storage_service.dart';
import 'package:tdahelpe/services/taches_storage_service.dart';
import 'package:tdahelpe/utils/error_handler.dart';
import '../services/score_storage_service.dart';

class ScoreProvider extends ChangeNotifier {
  final int maxXpByLevel = 500;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  int _xpGlobal = 0;

  // ✅ UNE SEULE Map au lieu de 5 variables !
  Map<String, int> _scores = {
    'matin': 0,
    'midi': 0,
    'soir': 0,
    'couché': 0,
    'taches': 0,
  };

  int _toothScore = 0;
  int _defouleScore = 0;

  DateTime? _lastResetDate;
  List<bool> _isChecked = List.generate(3, (index) => false);
  int _currentStep = 0;

  // ✅ Getters simplifiés
  int get xpGlobal => _xpGlobal;
  int get morningScore => _scores['matin']!;
  int get midiScore => _scores['midi']!;
  int get afternoonScore => _scores['soir']!;
  int get eveningScore => _scores['couché']!;
  int get tacheScore => _scores['taches']!;

  List<bool> get isChecked => _isChecked;
  int get currentStep => _currentStep;
  int get toothScore => _toothScore;
  int get defouleScore => _defouleScore;

  // ✅ Calculs simplifiés
  int get globalBingoScore =>
      _scores['matin']! +
      _scores['midi']! +
      _scores['soir']! +
      _scores['couché']!;

  int get globalScore =>
      ((globalBingoScore / 4).floor() * 5 +
      _scores['taches']! * 15 +
      _toothScore +
      _defouleScore);

  int get niveauPersonnal =>
      (((globalScore + _xpGlobal) / maxXpByLevel).floor());
  int get xpByLevel => (_xpGlobal + globalScore) % maxXpByLevel;

  int nombreTirage = 0;

  ScoreProvider() {
    _loadData();
  }

  // ✅ _loadData ULTRA simplifié avec une boucle !
  Future<void> _loadData() async {
    _xpGlobal =
        await ErrorHandler.handleAsync(
          () => ScoreStorageService.getXpGlobal(),
          errorMessage: 'Impossible de charger l\'XP global',
          defaultValue: 0,
        ) ??
        0;

    // ✅ Charger tous les scores en une boucle !
    for (var moment in _scores.keys) {
      _scores[moment] =
          await ErrorHandler.handleAsync(
            () => ScoreStorageService.getScore(moment),
            errorMessage: 'Impossible de charger le score de $moment',
            defaultValue: 0,
          ) ??
          0;
    }

    _isChecked =
        await ErrorHandler.handleAsync(
          () => ScoreStorageService.getTacheState(),
          errorMessage: 'Impossible de charger l\'état des tâches',
          defaultValue: List.generate(3, (index) => false),
        ) ??
        List.generate(3, (index) => false);

    _currentStep = _isChecked.where((checked) => checked).length;

    _toothScore =
        await ErrorHandler.handleAsync(
          () => ScoreStorageService.getToothScore(),
          errorMessage: 'Impossible de charger le score de brossage',
          defaultValue: 0,
        ) ??
        0;

    _defouleScore =
        await ErrorHandler.handleAsync(
          () => ScoreStorageService.getDefouleScore(),
          errorMessage: 'Impossible de charger le score de défoulage',
          defaultValue: 0,
        ) ??
        0;

    _lastResetDate = await ScoreStorageService.getLastResetDate();

    await _checkAndReset();
    _isLoading = false;
    notifyListeners();
  }

  // ✅ _checkAndReset simplifié
  Future<void> _checkAndReset() async {
    await ErrorHandler.handleAsync(
      () async {
        final now = DateTime.now();
        final reinitHour = await HoraireStorageService.getHours("reinit");
        final today6AM = DateTime(now.year, now.month, now.day, reinitHour, 00);

        if (_lastResetDate == null || _lastResetDate!.isBefore(today6AM)) {
          if (now.isAfter(today6AM)) {
            // Sauvegarder l'XP avant reset
            _xpGlobal = _xpGlobal + globalScore;
            await ScoreStorageService.saveXpGlobal(_xpGlobal);

            // ✅ Reset tous les scores en une boucle !
            _scores = {
              'matin': 0,
              'midi': 0,
              'soir': 0,
              'couché': 0,
              'taches': 0,
            };

            _toothScore = 0;
            _defouleScore = 0;
            _currentStep = 0;

            // Reset des tâches
            await TachesStorageService.saveListeChoix(["0"]);
            nombreTirage = await TachesStorageService.getNombreT();
            _isChecked = List.generate(nombreTirage, (index) => false);

            // ✅ Sauvegarder tous les scores en une boucle !
            for (var entry in _scores.entries) {
              await ScoreStorageService.saveScore(entry.key, entry.value);
            }

            await ScoreStorageService.saveScore('bingoGlobal', 0);
            await ScoreStorageService.saveToothScore(0);
            await ScoreStorageService.saveDefouleScore(0);
            await ScoreStorageService.saveTacheState(_isChecked);
            await ScoreStorageService.resetAllCardsState();

            // Sauvegarder la date de reset
            _lastResetDate = now;
            await ScoreStorageService.saveLastResetDate(_lastResetDate!);
          }
        }
      },
      errorMessage: 'Erreur critique lors de la réinitialisation quotidienne',
      defaultValue: null,
    );
  }

Future<int> getScoreByMoment(String moment) async {
    return await ScoreStorageService.getScore(moment);
  }

  // ✅ increment ULTRA simplifié !
  Future<bool> incrementglobal(String moment) async {
    // Vérifier si le moment existe
    if (!_scores.containsKey(moment)) {
      return false;
    }

    final oldScore = _scores[moment]!;
    _scores[moment] = _scores[moment]! + 1;

    final success = await ScoreStorageService.saveScore(
      moment,
      _scores[moment]!,
    );

    if (!success) {
      _scores[moment] = oldScore;
      return false;
    }

    notifyListeners();
    return true;
  }

  // ✅ decrement ULTRA simplifié !
  Future<bool> decrementglobal(String moment) async {
    // Vérifier si le moment existe
    if (!_scores.containsKey(moment)) {
      return false;
    }

    final oldScore = _scores[moment]!;
    _scores[moment] = _scores[moment]! > 0 ? _scores[moment]! - 1 : 0;

    final success = await ScoreStorageService.saveScore(
      moment,
      _scores[moment]!,
    );

    if (!success) {
      // Rollback
      _scores[moment] = oldScore;
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> resetAllScores() async {
    final oldScores = Map<String, int>.from(_scores);

    _scores = {'matin': 0, 'midi': 0, 'soir': 0, 'couché': 0, 'taches': 0};

    for (var entry in _scores.entries) {
      final success = await ScoreStorageService.saveScore(
        entry.key,
        entry.value,
      );
      if (!success) {
        _scores = oldScores;
          return false;
      }
    }

    notifyListeners();
    return true;
  }

  // ✅ Le reste reste identique
  Future<bool> updateTacheCheck(int index, bool value) async {
    final oldIsChecked = List<bool>.from(_isChecked);
    final oldCurrentStep = _currentStep;
    final oldTacheScore = _scores['taches']!;

    _isChecked[index] = value;
    _currentStep = _isChecked.where((checked) => checked).length;

    bool success;

    if (_currentStep == _isChecked.length && _currentStep > 0) {
      success = await incrementglobal('taches');
    } else {
      success = await resetTacheScore();
    }

    if (!success) {
      _isChecked = oldIsChecked;
      _currentStep = oldCurrentStep;
      _scores['taches'] = oldTacheScore;
      return false;
    }

    final saveSuccess = await ScoreStorageService.saveTacheState(_isChecked);

    if (!saveSuccess) {
      _isChecked = oldIsChecked;
      _currentStep = oldCurrentStep;
      _scores['taches'] = oldTacheScore;
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> resetCheckboxesWithLength(int newLength) async {
    final oldIsChecked = _isChecked;
    final oldCurrentStep = _currentStep;

    _isChecked = List.generate(newLength, (index) => false);
    _currentStep = 0;

    final success = await ScoreStorageService.saveTacheState(_isChecked);

    if (!success) {
      // Rollback
      _isChecked = oldIsChecked;
      _currentStep = oldCurrentStep;
    
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> resetTacheScore() async {
    final oldTacheScore = _scores['taches']!;
    _scores['taches'] = 0;

    final success = await ScoreStorageService.resetTacheScore();

    if (!success) {
      _scores['taches'] = oldTacheScore;
        return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> incrementToothScore() async {
    if (_toothScore >= 15) {
   
      return true;
    }

    final oldToothScore = _toothScore;
    _toothScore += 5;

    final success = await ScoreStorageService.saveToothScore(_toothScore);

    if (!success) {
      _toothScore = oldToothScore;
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> incrementDefouleScore() async {
    if (_defouleScore >= 20) {
      return true;
    }

    final oldDefouleScore = _defouleScore;
    _defouleScore += 5;

    final success = await ScoreStorageService.saveDefouleScore(_defouleScore);

    if (!success) {
      _defouleScore = oldDefouleScore;
         return false;
    }

    notifyListeners();
    return true;
  }
}
