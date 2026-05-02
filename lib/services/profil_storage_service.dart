import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilStorageService {
  static const String _pseudo = 'pseudo';
  static const String _profilImagePath = 'profil_image_path';
  static const String _languageChoose = 'en';

  static Future<bool> savePseudo(String pseudo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_pseudo, pseudo);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> saveLanguage(String language) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageChoose.toString(), language);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> saveProfilImagePath(String profilimagepath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_profilImagePath, profilimagepath);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getPseudo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_pseudo) ?? 'Inconnu';
    } catch (e) {
      return 'Inconnu';
    }
  }

  static Future<String> getLanguage() async {
    final String languageChoose;
    try {
      final prefs = await SharedPreferences.getInstance();
      final supposeLang = prefs.getString(_languageChoose);
      if (supposeLang == null) {
        final String deviceLocale = Platform.localeName.split('_')[0];

        languageChoose = ['fr', 'de', 'es'].contains(deviceLocale)
            ? deviceLocale
            : 'en';

        await ProfilStorageService.saveLanguage(_languageChoose);
      } else {
        languageChoose = supposeLang;
      }
      return languageChoose;
    } catch (e) {
      return 'en';
    }
  }

  static Future<String> getImagePath() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_profilImagePath) ??
          'assets/images/defaultprofilimage.png';
    } catch (e) {
      return 'assets/images/defaultprofilimage.png';
    }
  }
}
