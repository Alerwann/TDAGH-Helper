import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:tdahelpe/services/profil_storage_service.dart';

class ProfilProvider extends ChangeNotifier {
  String _pseudo = 'Inconnu';

  String _profilImagePath = 'assets/images/defaultprofilimage.png';

  String _languageChoose = 'en';

  bool get isDefaultImage => _profilImagePath.startsWith('assets/');

  String get pseudo => _pseudo;

  String get profilImagePath => _profilImagePath;

  String get languageChoose => _languageChoose;

  Locale get locale => Locale(_languageChoose);

  ProfilProvider() {
    _loadData();
  }
  Future<void> _loadData() async {
    print("✅ init profil");
    try {
      _pseudo = await ProfilStorageService.getPseudo();

      String savedPath = await ProfilStorageService.getImagePath();
      if (savedPath.startsWith('assets/')) {
        _profilImagePath = savedPath;
      } else {
        File file = File(savedPath);
        _profilImagePath = (await file.exists())
            ? savedPath
            : 'assets/images/defaultprofilimage.png';
      }

      _languageChoose = await ProfilStorageService.getLanguage();
      print("✅ saveLanguage : $_languageChoose");
    } catch (e) {
      if (kDebugMode) print('❌ Erreur chargement profil: $e');

      _pseudo = 'Inconnu';
      _profilImagePath = 'assets/images/defaultprofilimage.png';
      _languageChoose = 'en';
    } finally {
      notifyListeners();
    }
  }

  Future<bool> setProfilImagePath(String profilPath) async {
    final oldProfilImage = _profilImagePath;
    _profilImagePath = profilPath;

    final success = await ProfilStorageService.saveProfilImagePath(
      _profilImagePath,
    );

    if (!success) {
      _profilImagePath = oldProfilImage;
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> resetProfilimagePath() async {
    _profilImagePath = 'assets/images/defaultprofilimage.png';
    return await setProfilImagePath(_profilImagePath);
  }

  Future<bool> setPseudo(String pseudo) async {
    final oldpseudo = _pseudo;
    _pseudo = pseudo;

    final success = await ProfilStorageService.savePseudo(_pseudo);
    if (!success) {
      _pseudo = oldpseudo;
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> resetPseudo() async {
    _pseudo = 'Inconnu';
    return await setPseudo(_pseudo);
  }

  Future<bool> setLanguage(String language) async {
    final oldLanguage = _languageChoose;
    _languageChoose = language;

    final success = await ProfilStorageService.saveLanguage(_languageChoose);
    if (!success) {
      _languageChoose = oldLanguage;
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> resetLanguage() async {
    _languageChoose = 'en';
    return await setLanguage(_languageChoose);
  }

  Future<bool> resetAll() async {
    final pseudoSuccess = await resetPseudo();
    final imageSuccess = await resetProfilimagePath();
    final languageSuccess = await resetLanguage();

    if (!pseudoSuccess || !imageSuccess || !languageSuccess) {
      print("❌ Erreur lors de la réinitialisation");
    }

    return pseudoSuccess && imageSuccess && languageSuccess;
  }
}
