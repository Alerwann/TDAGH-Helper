import 'package:shared_preferences/shared_preferences.dart';

class ProfilStorageService {
  static const String _pseudo = 'pseudo';
  static const String _profilImagePath = 'profil_image_path';

  static Future<void> savePseudo(String pseudo) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _pseudo;
    await prefs.setString(key, pseudo);
  }

  static Future<void> saveProfilImagePath(String profilimagepath) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _profilImagePath;
    await prefs.setString(key, profilimagepath);
  }

  static Future<String> getPseudo() async {
    final prefs = await SharedPreferences.getInstance();

    final psuedo = prefs.getString(_pseudo) ?? 'personne';
    return psuedo;
  }

  static Future<String> getImagePath() async {
    final prefs = await SharedPreferences.getInstance();

    final imagePath =
        prefs.getString(_profilImagePath) ??
        'assets/images/defaultprofilimage.png';
    return imagePath;
  }
}
