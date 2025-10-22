import 'package:shared_preferences/shared_preferences.dart';

class TachesStorageService {
  static const String _nombreTaches = "nombreTaches";
  static const String _listChoix = "listeChoix";

  static Future<bool> saveNombreTaches(int nombreT) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_nombreTaches, nombreT);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> saveListeChoix(List<String> listTotalChoix) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_listChoix, listTotalChoix);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> getNombreT() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_nombreTaches) ?? 3;
    } catch (e) {
      return 3;
    }
  }

  static Future<List<String>> getChoixTaches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_listChoix) ?? ['0'];
    } catch (e) {
      return ['0'];
    }
  }
}
