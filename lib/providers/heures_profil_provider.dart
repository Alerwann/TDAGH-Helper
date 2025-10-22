import 'package:flutter/foundation.dart';
import 'package:tdahelpe/services/horaire_storage_service.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';
import 'package:tdahelpe/services/notifications/notification_service.dart';
import 'package:tdahelpe/utils/error_handler.dart';

class HeureProfilProvider extends ChangeNotifier {
  int _timerGame = 20;


  bool _isLoading = true;

  Map<String, int> _hours = {
    'reveil': 7,
    'midi': 12,
    'soir': 19,
    'couche': 22,
    'reinit': 4,
  };

  int get reveilHours => _hours['reveil']!;
  int get midiHours => _hours['midi']!;
  int get soirHours => _hours['soir']!;
  int get coucheHours => _hours['couche']!;

  int get reinitHours => _hours['reinit']!;

  int get timerGame => _timerGame;

  bool get isLoading => _isLoading;

  HeureProfilProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    _hours['reveil'] =
        await ErrorHandler.handleAsync(
          () => HoraireStorageService.getHours('réveil'),
          errorMessage: "L'heure du réveil n'a pas pu être chargée",
          defaultValue: 7,
        ) ??
        7;

    _hours['midi'] =
        await ErrorHandler.handleAsync(
          () => HoraireStorageService.getHours('midi'),
          errorMessage: "L'heure de midi n'a pas pu être chargée",
          defaultValue: 12,
        ) ??
        12;

    _hours["soir"] =
        await ErrorHandler.handleAsync(
          () => HoraireStorageService.getHours('soir'),
          errorMessage: "L'heure du soir n'a pas pu être chargée",
          defaultValue: 19,
        ) ??
        19;

    _hours["couche"] =
        await ErrorHandler.handleAsync(
          () => HoraireStorageService.getHours('couché'),
          errorMessage: "L'heure du couché n'a pas pu être chargée",
          defaultValue: 21,
        ) ??
        21;

    _hours["reinit"] =
        await ErrorHandler.handleAsync(
          () => HoraireStorageService.getHours('reinit'),
          errorMessage: "L'heure de réinitialisation n'a pas pu être chargée",
          defaultValue: 4,
        ) ??
        4;

    _timerGame =
        await ErrorHandler.handleAsync(
          () => HoraireStorageService.getTimerGame(),
          errorMessage: "La durée du jeu n'a pas pu être réinitialisé",
          defaultValue: 20,
        ) ??
        20;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _scheduleNotificationsWithLoadedHours() async {
    try {
      bool hasPermissions =
          await AndroidNotificationHandler.hasAllPermissions();

      if (!hasPermissions) {
        if (kDebugMode) {
          print('⚠️ Permissions manquantes pour programmer les alarmes');
        }
        return;
      }

      await NotificationService.scheduleAllNotifications(
        reveilHour: _hours['reveil']!,
        midiHour: _hours['midi']!,
        soirHour: _hours['soir']!,
        coucheHour: _hours['couche']!,
      );

      if (kDebugMode) {
        print('✅ Toutes les notifications programmées');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur lors de la programmation des notifications : $e');
      }
    }
  }

  Future<bool> resetAllHours() async {
    try {
      _hours = {'reveil': 7, 'midi': 12, 'soir': 19, 'couche': 22, 'reinit': 4};

      // Sauvegarder chaque valeur
      for (var entry in _hours.entries) {
        await HoraireStorageService.saveHours(entry.key, entry.value);
      }

      await _scheduleNotificationsWithLoadedHours();
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur lors de la réinitialisation: $e');
      }
      return false;
    }
  }

  Future<bool> setTimerGame(int timerG) async {
    final oldTimer = _timerGame;
    _timerGame = timerG;
    try {
      await HoraireStorageService.saveTimerGame(_timerGame);
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur sauvegarde score: $e');
      }
      _timerGame = oldTimer;
      notifyListeners();
      return false;
    }
  }

  Future<bool> setHours(int hours, String moment) async {
    final momentLower = moment.toLowerCase();

    // 1. Vérifier si le moment existe
    if (!_hours.containsKey(momentLower)) {
      if (kDebugMode) {
        print('⚠️ Moment inconnu : $moment');
      }
      return false;
    }

    // 2. Vérifier si c'est la même valeur
    if (_hours[momentLower] == hours) {
      if (kDebugMode) {
        print('⏭️ $moment : même valeur ($hours), pas de modification');
      }
      return true;
    }

    // 3. Modifier et sauvegarder
    try {
      _hours[momentLower] = hours;
      await HoraireStorageService.saveHours(momentLower, hours);
      await _scheduleNotificationsWithLoadedHours();
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur lors de la modification de $moment: $e');
      }
      return false;
    }
  }

  int? getHours(String moment) {
    return _hours[moment.toLowerCase()];
  }
}
