import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/list/taches_list.dart';
import 'package:flutter_application_1/data/schema/taches_shema.dart';
import 'package:flutter_application_1/services/taches_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TachesProvider extends ChangeNotifier {
  List<TachesSchema> _taches = [];
  List<String> _choixTaches = [];
  static const String _storageKey = 'user_taches';

  List<String> get choixTaches => List.unmodifiable(_choixTaches);

  List<TachesSchema> get taches => List.unmodifiable(_taches);

  int _nombreT = 3;
  int get nombreT => _nombreT;

  TachesProvider() {
    _loadTaches();
  }

  // Charger depuis local storage
  Future<void> _loadTaches() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tachesJson = prefs.getString(_storageKey);

    _nombreT = await TachesStorageService.getNombreT();
    _choixTaches = await TachesStorageService.getChoixTaches();

    if (tachesJson != null) {
      // Charger depuis le storage
      final List<dynamic> tachesList = json.decode(tachesJson);
      _taches = tachesList.map((json) => TachesSchema.fromJson(json)).toList();
    } else {
      // Premier lancement : charger les tâches par défaut
      _taches = TachesList.getDefaultCards();
      await _saveTaches(); // Sauvegarder immédiatement
    }
    notifyListeners();
  }

  // Sauvegarder dans local storage
  Future<void> _saveTaches() async {
    final prefs = await SharedPreferences.getInstance();
    final String tachesJson = json.encode(
      _taches.map((tache) => tache.toJson()).toList(),
    );
    await prefs.setString(_storageKey, tachesJson);
  }

  // Ajouter une tâche
  Future<void> ajouterTache(TachesSchema tache) async {
    _taches.insert(0, tache);
    await _saveTaches();
    notifyListeners();
  }

  // Supprimer une tâche par nom
  Future<void> supprimerTache(String nomTache) async {
    _taches.removeWhere((tache) => tache.tacheName == nomTache);
    await _saveTaches();
    notifyListeners();
  }

  // Modifier une tâche existante
  Future<void> modifierTache(
    String ancienNom,
    TachesSchema nouvelleTache,
  ) async {
    final index = _taches.indexWhere((tache) => tache.tacheName == ancienNom);
    if (index != -1) {
      _taches[index] = nouvelleTache;
      await _saveTaches();
      notifyListeners();
    }
  }

  Future<void> modifierNombreTache(int newnombreT) async {
    _nombreT = newnombreT;
    await TachesStorageService.saveNombreTaches(_nombreT);
    notifyListeners();
  }

  Future<void> saveListeTache(List<String> listeTache) async {
    _choixTaches = listeTache;
    await TachesStorageService.saveListeChoix(_choixTaches);
    notifyListeners();
  }

  // Méthodes utilitaires
  TachesSchema? trouverTache(String nom) {
    try {
      return _taches.firstWhere((tache) => tache.tacheName == nom);
    } catch (e) {
      return null;
    }
  }

  bool tacheExiste(String nom) {
    return _taches.any((tache) => tache.tacheName == nom);
  }
}
