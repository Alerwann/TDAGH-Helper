import 'package:flutter/material.dart';
import '../services/score_storage_service.dart'; // Import du service qu'on vient de créer

class ScoreProvider extends ChangeNotifier {
  int _morningScore = 0;
  int _midiScore = 0;
  int _afternoonScore = 0;
  int _eveningScore = 0;
  int _tacheScore = 0;
  DateTime? _lastResetDate;

  int get morningScore => _morningScore;
  int get midiScore => _midiScore;
  int get afternoonScore => _afternoonScore;
  int get eveningScore => _eveningScore;
  int get tacheScore => _tacheScore;

  int get globalScore =>
      _morningScore +
      _midiScore +
      _afternoonScore +
      _eveningScore +
      _tacheScore;

  ScoreProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _morningScore = await ScoreStorageService.getScore('matin');
    _midiScore = await ScoreStorageService.getScore('midi');
    _afternoonScore = await ScoreStorageService.getScore('soir');
    _eveningScore = await ScoreStorageService.getScore('couché');
    _tacheScore = await ScoreStorageService.getScore('taches');
    _lastResetDate = await ScoreStorageService.getLastResetDate();

    await _checkAndReset();

    notifyListeners();
  }

  Future<void> _checkAndReset() async {
    final now = DateTime.now();
    final today6AM = DateTime(now.year, now.month, now.day, 6);

    if (_lastResetDate == null || _lastResetDate!.isBefore(today6AM)) {
      if (now.isAfter(today6AM)) {
        _morningScore = 0;
        _midiScore = 0;
        _afternoonScore = 0;
        _eveningScore = 0;
        _tacheScore = 0;

        await ScoreStorageService.saveScore('matin', 0);
        await ScoreStorageService.saveScore('midi', 0);
        await ScoreStorageService.saveScore('soir', 0);
        await ScoreStorageService.saveScore('couché', 0);
        await ScoreStorageService.saveScore('taches', 0);

        await ScoreStorageService.resetAllCardsState();

        _lastResetDate = now;
        await ScoreStorageService.saveLastResetDate(_lastResetDate!);

        notifyListeners();
      }
    }
  }

  Future<void> incrementglobal(String moment) async {
    switch (moment) {
      case 'matin':
        _morningScore++;
        await ScoreStorageService.saveScore('matin', _morningScore);
        break;
      case 'midi':
        _midiScore++;
        await ScoreStorageService.saveScore('midi', _midiScore);
        break;
      case 'soir':
        _afternoonScore++;
        await ScoreStorageService.saveScore('soir', _afternoonScore);
        break;
      case 'couché':
        _eveningScore++;
        await ScoreStorageService.saveScore('couché', _eveningScore);
        break;
      case 'taches':
        _tacheScore += 1;
        await ScoreStorageService.saveScore('couché', _tacheScore);
        break;
    }
    notifyListeners();
  }

  Future<void> decrementglobal(String moment) async {
    switch (moment) {
      case 'matin':
        _morningScore = _morningScore > 0 ? _morningScore - 1 : 0;
        await ScoreStorageService.saveScore('matin', _morningScore);
        break;
      case 'midi':
        _midiScore = _midiScore > 0 ? _midiScore - 1 : 0;
        await ScoreStorageService.saveScore('midi', _midiScore);
        break;
      case 'soir':
        _afternoonScore = _afternoonScore > 0 ? _afternoonScore - 1 : 0;
        await ScoreStorageService.saveScore('soir', _afternoonScore);
        break;
      case 'couché':
        _eveningScore = _eveningScore > 0 ? _eveningScore - 1 : 0;
        await ScoreStorageService.saveScore('couché', _eveningScore);
        break;
      case 'taches':
        _tacheScore = _tacheScore > 0 ? _tacheScore - 1 : 0;
        await ScoreStorageService.saveScore('taches', _tacheScore);
        break;
    }
    notifyListeners();
  }

  Future<void> resetAllScores() async {
    _morningScore = 0;
    _midiScore = 0;
    _afternoonScore = 0;
    _eveningScore = 0;
    _tacheScore = 0;

    await ScoreStorageService.saveScore('matin', 0);
    await ScoreStorageService.saveScore('midi', 0);
    await ScoreStorageService.saveScore('soir', 0);
    await ScoreStorageService.saveScore('couché', 0);
    await ScoreStorageService.saveScore('tache', 0);

    notifyListeners();
  }
}
