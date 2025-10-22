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
    if (kDebugMode) {
      print("🔄 Réinitialisation du score de défoulage");
    }

    final oldScore = _scoreDefoule; 
    _scoreDefoule = 0;

    try {
      await DefouleService.resetScoreDefoulee();
      notifyListeners();

      if (kDebugMode) {
        print("✅ Score réinitialisé avec succès");
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur réinitialisation score: $e');
      }

      _scoreDefoule = oldScore;
      notifyListeners();

      return false;
    }
  }

  Future<bool> saveScore(int scoreD) async {
    final oldScore = _scoreDefoule;
    _scoreDefoule = scoreD;

    try {
      await DefouleService.saveScoreDefoule(_scoreDefoule);
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur sauvegarde score: $e');
      }
      _scoreDefoule = oldScore;
      notifyListeners();
      return false;
    }
  }

  Future<bool> saveTimerDuration(int timerD) async {
    final oldDuration = _timerDuration;
    _timerDuration = timerD;

    try {
      await DefouleService.saveTimerDuration(_timerDuration);
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur sauvegarde timer: $e');
      }
      _timerDuration = oldDuration;
      notifyListeners();
      return false;
    }
  }

Future<bool> resetTimerDuration() async {
    final oldDuration = _timerDuration; 
    _timerDuration = 20; 

    try {
      await DefouleService.resetTimerDuration();
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur réinitialisation timer: $e');
      }


      _timerDuration = oldDuration;
      notifyListeners();

      return false;
    }
  }
}
