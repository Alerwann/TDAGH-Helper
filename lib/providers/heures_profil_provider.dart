import 'package:flutter/material.dart';
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

  int get reveilHours => _reveilHours;
  int get reveilMinutes => _reveilMinutes;
  int get midiHours => _midiHours;
  int get midiMinutes => _midiMinutes;
  int get soirhours => _soirHours;
  int get soirMinutes => _soirMinutes;
  int get coucheHours => _coucheHours;
  int get coucheMinutes => _coucheMinutes;
  int get timerGame => _timerGame;

  HeureProfilProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _reveilHours = await HoraireStorageService.getHours('réveil');

    _midiHours = await HoraireStorageService.getHours('midi');

    _soirHours = await HoraireStorageService.getHours('soir');

    _coucheHours = await HoraireStorageService.getHours('couché');

    _timerGame = await HoraireStorageService.getTimerGame();

    notifyListeners();
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

    await HoraireStorageService.saveHours("réveil", _reveilHours);
    await HoraireStorageService.saveHours("midi", _midiHours);
    await HoraireStorageService.saveHours("soir", _soirHours);
    await HoraireStorageService.saveHours("couché", _coucheHours);

    await NotificationService.cancelAllNotifications();
    await NotificationService.scheduleAllNotifications(
      reveilHour: _midiHours,
      midiHour: _soirHours,
      soirHour: _coucheHours,
      coucheHour: _coucheHours + 1,
    );

    notifyListeners();
  }

  Future<void> setHours(int hours, String moment) async {
    switch (moment.toLowerCase()) {
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
        await HoraireStorageService.saveHours("soir", _soirHours);
        break;
      case 'couché':
        _coucheHours = hours;
        await HoraireStorageService.saveHours("couché", _coucheHours);
        break;
    }

    await NotificationService.cancelAllNotifications();

    await NotificationService.scheduleAllNotifications(
      reveilHour: _midiHours,
      midiHour: _soirHours,
      soirHour: _coucheHours,
      coucheHour: _coucheHours + 1,
    );

    notifyListeners();
  }

  Future<void> setTimerGame(int timerG) async {
    _timerGame = timerG;
    await HoraireStorageService.saveTimerGame(_timerGame);
    notifyListeners();
  }
}
