import 'package:shared_preferences/shared_preferences.dart';

class ProfilStorageService {
  static const String _pseudo = 'pseudo';
  static const String _profilImagePath = 'profil_image_path';

  static Future<bool> savePseudo(String pseudo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_pseudo, pseudo);
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
