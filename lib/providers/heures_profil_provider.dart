import 'package:flutter/foundation.dart';
import 'package:tdahelpe/services/horaire_storage_service.dart';
import 'package:tdahelpe/services/notification_service.dart';

class HeureProfilProvider extends ChangeNotifier {
  int _reveilHours = 7;
  int _reveilMinutes = 0;
  int _midiHours = 12;
  int _midiMinutes = 0;
  int _soirHours = 19;
  int _soirMinutes = 0;
  int _coucheHours = 22;
  int _coucheMinutes = 0;
  int _timerGame = 20;
  int _reinitHours = 4;

  int get reveilHours => _reveilHours;
  int get reveilMinutes => _reveilMinutes;
  int get midiHours => _midiHours;
  int get midiMinutes => _midiMinutes;
  int get soirhours => _soirHours;
  int get soirMinutes => _soirMinutes;
  int get coucheHours => _coucheHours;
  int get coucheMinutes => _coucheMinutes;
  int get timerGame => _timerGame;
  int get reinitHours => _reinitHours;

  HeureProfilProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _reveilHours = await HoraireStorageService.getHours('réveil');
    if (kDebugMode) {
      print('📥 Réveil chargé: $_reveilHours');
    }

    _midiHours = await HoraireStorageService.getHours('midi');
    if (kDebugMode) {
      print('📥 Midi chargé: $_midiHours');
    }

    _soirHours = await HoraireStorageService.getHours('soir');
    if (kDebugMode) {
      print('📥 Soir chargé: $_soirHours');
    }

    _coucheHours = await HoraireStorageService.getHours('couché');
    if (kDebugMode) {
      print('📥 Couché chargé: $_coucheHours');
    }
    _reinitHours = await HoraireStorageService.getHours('reinit');
    if (kDebugMode) {
      print('📥 Heure de réinitialisation chargé: $_reinitHours');
    }

    _timerGame = await HoraireStorageService.getTimerGame();

    notifyListeners();
  }

  Future<void> _scheduleNotificationsWithLoadedHours() async {
    try {
      // ✅ Vérifier TOUTES les permissions nécessaires
      bool hasPermissions = await NotificationService.hasAllPermissions();

      if (!hasPermissions) {
        if (kDebugMode) {
          print('⚠️ Permissions manquantes pour programmer les alarmes');
        }
       
      }

      await NotificationService.scheduleAllNotifications(
        reveilHour: _reveilHours,
        midiHour: _midiHours,
        soirHour: _soirHours,
        coucheHour: _coucheHours,
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

  Future<void> resetAllHours() async {
    _reveilHours = 7;
    _reveilMinutes = 0;
    _midiHours = 12;
    _midiMinutes = 0;
    _soirHours = 19;
    _soirMinutes = 0;
    _coucheHours = 22;
    _coucheMinutes = 0;
    _reinitHours = 4;

    await HoraireStorageService.saveHours("réveil", _reveilHours);
    await HoraireStorageService.saveHours("midi", _midiHours);
    await HoraireStorageService.saveHours("soir", _soirHours);
    await HoraireStorageService.saveHours("couché", _coucheHours);
    await HoraireStorageService.saveHours("reinit", _reinitHours);

    await _scheduleNotificationsWithLoadedHours();

    notifyListeners();
  }

  Future<void> setHours(int hours, String moment) async {

    final momentLower = moment.toLowerCase();

    // Récupérer la valeur actuelle
    int currentValue;
    switch (momentLower) {
      case 'réveil':
        currentValue = _reveilHours;
        break;
      case 'midi':
        currentValue = _midiHours;
        break;
      case 'soir':
        currentValue = _soirHours;
        break;
      case 'couché':
        currentValue = _coucheHours;
        break;
      case 'reinit':
        currentValue = _reinitHours;
        break;
      default:
        if (kDebugMode) {
          print('⚠️ Moment inconnu : $moment');
        }
        return;
    }

    if (currentValue == hours) {
      if (kDebugMode) {
        print('⏭️ $moment : même valeur ($hours), pas de modification');
      }
      return;
    }

    if (kDebugMode) {
      print('🔧 setHours appelé : $moment = $hours');
    }


    switch (momentLower) {
      case 'réveil':
        _reveilHours = hours;
        await HoraireStorageService.saveHours('réveil', _reveilHours);
        break;
      case 'midi':
        _midiHours = hours;
        await HoraireStorageService.saveHours('midi', _midiHours);
        break;
      case 'soir':
        _soirHours = hours;
        await HoraireStorageService.saveHours('soir', _soirHours);
        break;
      case 'couché':
        _coucheHours = hours;
        await HoraireStorageService.saveHours('couché', _coucheHours);
        break;
      case 'reinit':
        _reinitHours = hours;
        await HoraireStorageService.saveHours('reinit', _reinitHours);
        print("✅ nouvel horair de réinitialisation $_reinitHours");
        break;
    }

    if (kDebugMode) {
      print(
        '✅ $moment mis à jour : $hours, reprogrammation des notifications...',
      );
    }

    // Reprogrammer TOUTES les notifications avec les nouvelles heures
    await _scheduleNotificationsWithLoadedHours();

    if (kDebugMode) {
      print('✅ Notifications reprogrammées');
    }

    notifyListeners();
  }

  Future<void> setTimerGame(int timerG) async {
    _timerGame = timerG;
    await HoraireStorageService.saveTimerGame(_timerGame);
    notifyListeners();
  }
}
