import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/defoule_service.dart';

class DefouleProvider extends ChangeNotifier {
  int _scoreDefoule = 0;
  int get scoreDefoule => _scoreDefoule;

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
    await DefouleService.saveScoreDefoule(_scoreDefoule);
    notifyListeners();
  }
}
