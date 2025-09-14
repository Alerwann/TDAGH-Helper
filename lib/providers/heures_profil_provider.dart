import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/horaire_storage_service.dart';

class HeureProfilProvider extends ChangeNotifier {
  int _reveilHours = 7;
  int _reveilMinutes = 0;
  int _midiHours = 12;
  int _midiMinutes = 0;
  int _soirHours = 19;
  int _soirMinutes = 0;
  int _coucheHours = 22;
  int _coucheMinutes = 0;

  int get reveilHours => _reveilHours;
  int get reveilMinutes => _reveilMinutes;
  int get midiHours => _midiHours;
  int get midiMinutes => _midiMinutes;
  int get soirhours => _soirHours;
  int get soirMinutes => _soirMinutes;
  int get coucheHours => _coucheHours;
  int get coucheMinutes => _coucheMinutes;

  HeureProfilProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _reveilHours = await HoraireStorageService.getHours('réveil');
    _reveilMinutes = await HoraireStorageService.getMinutes('réveil');
    _midiHours = await HoraireStorageService.getHours('midi');
    _midiMinutes = await HoraireStorageService.getMinutes('midi');
    _soirHours = await HoraireStorageService.getHours('soir');
    _soirMinutes = await HoraireStorageService.getMinutes('soir');
    _coucheHours = await HoraireStorageService.getHours('couché');
    _coucheMinutes = await HoraireStorageService.getMinutes('couché');

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

    await HoraireStorageService.saveMinutes("réveil", _reveilMinutes);
    await HoraireStorageService.saveMinutes("midi", _midiMinutes);
    await HoraireStorageService.saveMinutes("soir", _soirMinutes);
    await HoraireStorageService.saveMinutes('couché', _coucheMinutes);

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

    notifyListeners();
  }

  Future<void> setMinutes(int minutes, String moment) async {
    switch (moment.toLowerCase()) {
      case 'réveil':
        _reveilMinutes = minutes;
        await HoraireStorageService.saveHours('réveil', _reveilMinutes);
        break;
      case 'midi':
        _midiMinutes = minutes;
        await HoraireStorageService.saveHours('midi', _midiMinutes);
        break;
      case 'soir':
        _soirMinutes = minutes;
        await HoraireStorageService.saveHours("soir", _soirMinutes);
        break;
      case 'couché':
        _coucheMinutes = minutes;
        await HoraireStorageService.saveHours("couché", _coucheMinutes);
        break;
    }

    notifyListeners();
  }
}
