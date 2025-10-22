import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tdahelpe/services/profil_storage_service.dart';

class ProfilProvider extends ChangeNotifier {
  String _pseudo = 'Inconnu';

  String _profilImagePath = 'assets/images/defaultprofilimage.png';

  bool get isDefaultImage => _profilImagePath.startsWith('assets/');

  String get pseudo => _pseudo;

  String get profilImagePath => _profilImagePath;

  ProfilProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _pseudo = await ProfilStorageService.getPseudo();
    String savedPath = await ProfilStorageService.getImagePath();

    // Vérifier si le fichier existe pour les chemins non-assets
    if (!savedPath.startsWith('assets/')) {
      File file = File(savedPath);
      if (await file.exists()) {
        _profilImagePath = savedPath;
      } else {
        _profilImagePath = 'assets/images/defaultprofilimage.png';
      }
    } else {
      _profilImagePath = savedPath;
    }

    notifyListeners();
  }

  Future<bool> setProfilImagePath(String profilPath) async {
    final oldProfilImage = _profilImagePath;
    _profilImagePath = profilPath;
    try {
      await ProfilStorageService.saveProfilImagePath(_profilImagePath);
      notifyListeners();
      return true;
    } catch (e) {
      print("❌  Erreur de sauvegarde : $e");
      _profilImagePath = oldProfilImage;
      return false;
    }
  }

  Future<bool> resetProfilimagePath() async {
    _profilImagePath = 'assets/images/defaultprofilimage.png';
    return await setProfilImagePath(_profilImagePath);
  }

  Future<bool> setPseudo(String pseudo) async {
    final oldpseudo = _pseudo;
    _pseudo = pseudo;
    try {
      await ProfilStorageService.savePseudo(_pseudo);
      notifyListeners();
      return true;
    } catch (e) {
      print("❌  Erreur de sauvegarde du pseudo : $e");
      _pseudo = oldpseudo;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPseudo() async {
    _pseudo = 'Inconnu';
    return await setPseudo(_pseudo);
  }

  Future<bool> resetAll() async {
    final pseudoSuccess = await resetPseudo();
    final imageSuccess = await resetProfilimagePath();

    if (!pseudoSuccess || !imageSuccess) {
      print("❌ Erreur lors de la réinitialisation");
    }

    return pseudoSuccess && imageSuccess;
  }
}
