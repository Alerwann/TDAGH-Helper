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
    'coucher': 22,
    'reinit': 4,
  };

  int get reveilHours => _hours['reveil']!;
  int get midiHours => _hours['midi']!;
  int get soirHours => _hours['soir']!;
  int get coucherHours => _hours['coucher']!;

  int get reinitHours => _hours['reinit']!;

  int get timerGame => _timerGame;

  bool get isLoading => _isLoading;

  HeureProfilProvider() {
    loadData();
  }

  Future<void> loadData() async {
    print("🫟LOAD DATA");
    _isLoading = true;
    notifyListeners();

    _hours['reveil'] =
        await ErrorHandler.handleAsync(
          () => HoraireStorageService.getHours('reveil'),
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

    _hours["coucher"] =
        await ErrorHandler.handleAsync(
          () => HoraireStorageService.getHours('coucher'),
          errorMessage: "L'heure du coucher n'a pas pu être chargée",
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
        coucherHour: _hours['coucher']!,
      );
    } catch (e) {
      if (kDebugMode) {
        // print('❌ Erreur lors de la programmation des notifications : $e');
      }
    }
  }

  Future<bool> resetAllHours() async {
    final oldHours = Map<String, int>.from(_hours);

    // Reset des valeurs
    _hours = {'reveil': 7, 'midi': 12, 'soir': 19, 'coucher': 22, 'reinit': 4};

    // Sauvegarder chaque valeur
    for (var entry in _hours.entries) {
      final success = await HoraireStorageService.saveHours(
        entry.key,
        entry.value,
      );

      if (!success) {
        // Rollback complet
        _hours = oldHours;
        return false;
      }
    }

    // Toutes les sauvegardes ont réussi
    await _scheduleNotificationsWithLoadedHours();
    notifyListeners();
    return true;
  }

  Future<bool> setTimerGame(int timerG) async {
    final oldTimer = _timerGame;
    _timerGame = timerG;

    final succes = await HoraireStorageService.saveTimerGame(_timerGame);

    if (!succes) {
      _timerGame = oldTimer;
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> setHours(int hours, String moment) async {
    final momentLower = moment.toLowerCase();

    if (!_hours.containsKey(momentLower)) {
      return false;
    }

    if (_hours[momentLower] == hours) {
      return true;
    }

    final oldValue = _hours[momentLower]!;
    _hours[momentLower] = hours;

    // ✅ Juste vérifier le bool
    final success = await HoraireStorageService.saveHours(momentLower, hours);

    if (!success) {
      _hours[momentLower] = oldValue;
      return false;
    }

    await _scheduleNotificationsWithLoadedHours();
    notifyListeners();
    return true;
  }

  int? getHours(String moment) {
    return _hours[moment.toLowerCase()];
  }
}
