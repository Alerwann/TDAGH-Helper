import 'package:flutter_application_1/services/defoule_service.dart';
import 'package:flutter/material.dart';

class DefouleProvider extends ChangeNotifier {
  int _scoreDefoule = 0;
  int _timerDuration = 20;

  int get scoreDefoule => _scoreDefoule;
  int get timerDuration => _timerDuration;

  DefouleProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _scoreDefoule = await DefouleService.getScoreDefoule();
  }

  Future<void> saveScore(int scoreD) async {
    _scoreDefoule = scoreD;
    await DefouleService.saveScoreDefoule(_scoreDefoule);
    notifyListeners();
  }

  Future<void> resetScore() async {
    _scoreDefoule = 0;
    await DefouleService.restScoreDefoule();
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
