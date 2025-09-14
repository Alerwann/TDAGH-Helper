import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/profil_storage_service.dart';

class ProfilProvider extends ChangeNotifier {
  String _pseudo = 'Iconnu';
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

  Future<void> setProfilImagePath(String profilPath) async {
    _profilImagePath = profilPath;
    await ProfilStorageService.saveProfilImagePath(_profilImagePath);
    notifyListeners();
  }

  Future<void> resetProfilimagePath() async {
    _profilImagePath = 'assets/images/defaultprofilimage.png';
    await ProfilStorageService.saveProfilImagePath(_profilImagePath);
    notifyListeners();
  }

  Future<void> setPseudo(String pseudo) async {
    _pseudo = pseudo;
    await ProfilStorageService.savePseudo(_pseudo);
    notifyListeners();
  }

  Future<void> resetPseudo() async {
    _pseudo = 'Inconnu';
    await ProfilStorageService.savePseudo(_pseudo);
    notifyListeners();
  }

  Future<void> resetAll() async {
    resetPseudo();
    resetProfilimagePath();
    notifyListeners();
  }
}
