import 'package:tdahelpe/services/defoule_service.dart';
import 'package:flutter/material.dart';

class DefouleProvider extends ChangeNotifier {
  int _scoreDefoule = 0;
  int _timerDuration = 20;
  bool _isLoading = true;

  int get scoreDefoule => _scoreDefoule;
  int get timerDuration => _timerDuration;
  bool get isLoading => _isLoading;

  DefouleProvider() {
    print("🏗️ Provider créé");
    _loadData();
  }

  Future<void> _loadData() async {
    print("📥 Début du chargement...");
    _isLoading = true; // ✅
    _scoreDefoule = await DefouleService.getScoreDefoule();
    _timerDuration = await DefouleService.getTimerDuration();
    print("📥 Données chargées : score=$_scoreDefoule, timer=$_timerDuration");
    _isLoading = false; // ✅
    notifyListeners(); // ✅ Important !
  }

  Future<void> resetScore() async {
    print("👀 provider Remise à 0 - AVANT");
    _scoreDefoule = 0;
    await DefouleService.resetScoreDefoulee();
    print("👀 provider Remise à 0 - APRÈS sauvegarde");
    notifyListeners();
  }

  Future<void> saveScore(int scoreD) async {
    _scoreDefoule = scoreD;
    await DefouleService.saveScoreDefoule(_scoreDefoule);
    notifyListeners();
  }

  Future<void> saveTimerDuration(int timerD) async {
    _timerDuration = timerD;
    await DefouleService.saveTimerDuration(_timerDuration);
    notifyListeners();
  }

  Future<void> resetTimerDuration() async {
    _scoreDefoule = 0;
    await DefouleService.resetTimerDuration();
    notifyListeners();
  }
}
