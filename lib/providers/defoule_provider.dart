import 'package:flutter/foundation.dart';
import 'package:tdahelpe/services/defoule_service.dart';
import 'package:tdahelpe/utils/error_handler.dart';

class DefouleProvider extends ChangeNotifier {
  int _scoreDefoule = 0;
  int _timerDuration = 20;
  bool _isLoading = true;

  int get scoreDefoule => _scoreDefoule;
  int get timerDuration => _timerDuration;
  bool get isLoading => _isLoading;

  DefouleProvider() {
    if (kDebugMode) {
      print("🏗️ Provider créé");
    }
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    _scoreDefoule =
        await ErrorHandler.handleAsync(
          () => DefouleService.getScoreDefoule(),
          errorMessage: 'Impossible de charger le score de Défoule-toi',
          defaultValue: 0,
        ) ??
        0;
    _timerDuration =
        await ErrorHandler.handleAsync(
          () => DefouleService.getTimerDuration(),
          errorMessage: 'Impossible de charger la durée du jeu',
          defaultValue: 20,
        ) ??
        20;

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> resetScore() async {
    final oldScore = _scoreDefoule;
    _scoreDefoule = 0;

    final succes = await DefouleService.resetScoreDefoulee();
    if (!succes) {
      _scoreDefoule = oldScore;
    return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> saveScore(int scoreD) async {
    final oldScore = _scoreDefoule;
    _scoreDefoule = scoreD;

    final succes = await DefouleService.saveScoreDefoule(_scoreDefoule);

    if (!succes) {
      _scoreDefoule = oldScore;
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> saveTimerDuration(int timerD) async {
    final oldDuration = _timerDuration;
    _timerDuration = timerD;

    final succes = await DefouleService.saveTimerDuration(_timerDuration);

    if (!succes) {
      _timerDuration = oldDuration;
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> resetTimerDuration() async {
    final oldDuration = _timerDuration;
    _timerDuration = 20;

    final succes = await DefouleService.resetTimerDuration();

    if (!succes) {
      _timerDuration = oldDuration;
      return false;
    }

    notifyListeners();
    return true;
  }
}
