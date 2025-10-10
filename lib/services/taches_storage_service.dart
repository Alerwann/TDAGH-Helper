import 'package:shared_preferences/shared_preferences.dart';

class TachesStorageService {
 
  static const String _nombreTaches = "nombreTaches";
  static const String _listChoix = "listeChoix";

  static Future<void> saveNombreTaches(int nombreT) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _nombreTaches;
    await prefs.setInt(key, nombreT);
  }


  static Future<void> saveListeChoix(List<String> listTotalChoix) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _listChoix;
    await prefs.setStringList(key, listTotalChoix);
  }

  static Future<int> getNombreT() async {
    final prefs = await SharedPreferences.getInstance();
    final nombreT = prefs.getInt(_nombreTaches) ?? 3;
    return nombreT;
  }

  static Future<List<String>> getChoixTaches() async {
    final prefs = await SharedPreferences.getInstance();
    final listeChoix = prefs.getStringList(_listChoix) ?? ['0'];
    return listeChoix;
  }
}
