import 'package:flutter/material.dart';
import '../services/bingo_storage_service.dart'; // Import du service qu'on vient de créer

class BingoProvider extends ChangeNotifier {
  int _morningScore = 0;
  int _midiScore = 0;
  int _afternoonScore = 0;
  int _eveningScore = 0;
  DateTime? _lastResetDate;

  // Getters pour les scores individuels
  int get morningScore => _morningScore;
  int get midiScore => _midiScore;
  int get afternoonScore => _afternoonScore;
  int get eveningScore => _eveningScore;

  // Getter pour le score global (calculé automatiquement)
  int get globalScore =>
      _morningScore + _midiScore + _afternoonScore + _eveningScore;

  // Constructor - charge les données au démarrage
  BingoProvider() {
    _loadData();
  }

  // Charger les données sauvegardées
  Future<void> _loadData() async {
    _morningScore = await BingoStorageService.getScore('matin');
    _midiScore = await BingoStorageService.getScore('midi');
    _afternoonScore = await BingoStorageService.getScore('soir');
    _eveningScore = await BingoStorageService.getScore('couché');
    _lastResetDate = await BingoStorageService.getLastResetDate();

    // Vérifier s'il faut faire un reset
    await _checkAndReset();

    notifyListeners();
  }

  // Fonction de reset quotidien
  Future<void> _checkAndReset() async {
    final now = DateTime.now();
    final today6AM = DateTime(now.year, now.month, now.day, 6);

    if (_lastResetDate == null || _lastResetDate!.isBefore(today6AM)) {
      if (now.isAfter(today6AM)) {
        // Reset tous les scores
        _morningScore = 0;
        _midiScore = 0;
        _afternoonScore = 0;
        _eveningScore = 0;

        // Sauvegarder les scores remis à zéro
        await BingoStorageService.saveScore('matin', 0);
        await BingoStorageService.saveScore('midi', 0);
        await BingoStorageService.saveScore('soir', 0);
        await BingoStorageService.saveScore('couché', 0);

        // Reset l'état de toutes les cartes
        await BingoStorageService.resetAllCardsState();

        // Sauvegarder la date de reset
        _lastResetDate = now;
        await BingoStorageService.saveLastResetDate(_lastResetDate!);

        notifyListeners();
      }
    }
  }

  // Incrémenter le score avec sauvegarde
  Future<void> incrementglobal(String moment) async {
    switch (moment) {
      case 'matin':
        _morningScore++;
        await BingoStorageService.saveScore('matin', _morningScore);
        break;
      case 'midi':
        _midiScore++;
        await BingoStorageService.saveScore('midi', _midiScore);
        break;
      case 'soir':
        _afternoonScore++;
        await BingoStorageService.saveScore('soir', _afternoonScore);
        break;
      case 'couché':
        _eveningScore++;
        await BingoStorageService.saveScore('couché', _eveningScore);
        break;
    }
    notifyListeners();
  }

  // Décrémenter le score avec sauvegarde
  Future<void> decrementglobal(String moment) async {
    switch (moment) {
      case 'matin':
        _morningScore = _morningScore > 0 ? _morningScore - 1 : 0;
        await BingoStorageService.saveScore('matin', _morningScore);
        break;
      case 'midi':
        _midiScore = _midiScore > 0 ? _midiScore - 1 : 0;
        await BingoStorageService.saveScore('midi', _midiScore);
        break;
      case 'soir':
        _afternoonScore = _afternoonScore > 0 ? _afternoonScore - 1 : 0;
        await BingoStorageService.saveScore('soir', _afternoonScore);
        break;
      case 'couché':
        _eveningScore = _eveningScore > 0 ? _eveningScore - 1 : 0;
        await BingoStorageService.saveScore('couché', _eveningScore);
        break;
    }
    notifyListeners();
  }

  // Reset tous les scores (optionnel)
  Future<void> resetAllScores() async {
    _morningScore = 0;
    _midiScore = 0;
    _afternoonScore = 0;
    _eveningScore = 0;

    await BingoStorageService.saveScore('matin', 0);
    await BingoStorageService.saveScore('midi', 0);
    await BingoStorageService.saveScore('soir', 0);
    await BingoStorageService.saveScore('couché', 0);

    notifyListeners();
  }
}
