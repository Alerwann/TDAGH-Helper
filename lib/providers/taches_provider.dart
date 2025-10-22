import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tdahelpe/data/list/taches_list.dart';
import 'package:tdahelpe/data/schema/taches_shema.dart';
import 'package:tdahelpe/services/taches_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TachesProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

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
      final List<dynamic> tachesList = json.decode(tachesJson);
      _taches = tachesList.map((json) => TachesSchema.fromJson(json)).toList();
    } else {
      _taches = TachesList.getDefaultCards();
      await _saveTaches();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Sauvegarder avec gestion d'erreur
  Future<bool> _saveTaches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String tachesJson = json.encode(
        _taches.map((tache) => tache.toJson()).toList(),
      );
      await prefs.setString(_storageKey, tachesJson);
      return true;
    } catch (e) {
      print("❌ Erreur lors de la sauvegarde des tâches : $e");
      return false;
    }
  }

  // Ajouter une tâche
  Future<bool> ajouterTache(TachesSchema tache) async {
    _taches.insert(0, tache);
    final success = await _saveTaches();

    if (!success) {
      // Annuler l'ajout si la sauvegarde échoue
      _taches.removeAt(0);
      return false;
    }

    notifyListeners();
    return true;
  }

  // Réinitialiser les tâches choisies
  Future<bool> reinitTache() async {
    _choixTaches = ['0'];
    return await saveListeTache(_choixTaches);
  }

  // Supprimer une tâche par nom
  Future<bool> supprimerTache(String nomTache) async {
    final index = _taches.indexWhere((tache) => tache.tacheName == nomTache);

    if (index == -1) {
      return false; // Tâche non trouvée
    }

    final tacheSupprimee = _taches[index];
    _taches.removeAt(index);

    final success = await _saveTaches();

    if (!success) {
      // Restaurer la tâche si la sauvegarde échoue
      _taches.insert(index, tacheSupprimee);
      return false;
    }

    notifyListeners();
    return true;
  }

  // Modifier une tâche existante
  Future<bool> modifierTache(
    String ancienNom,
    TachesSchema nouvelleTache,
  ) async {
    final index = _taches.indexWhere((tache) => tache.tacheName == ancienNom);

    if (index == -1) {
      return false; // Tâche non trouvée
    }

    final ancienneTache = _taches[index];
    _taches[index] = nouvelleTache;

    final success = await _saveTaches();

    if (!success) {
      // Restaurer l'ancienne tâche si la sauvegarde échoue
      _taches[index] = ancienneTache;
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> modifierNombreTache(int newnombreT) async {
    final oldNombreT = _nombreT;
    _nombreT = newnombreT;

    final success = await TachesStorageService.saveNombreTaches(_nombreT);

    if (!success) {
      print("❌ Sauvegarde du nombre de tâches a échoué");
      _nombreT = oldNombreT;
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> saveListeTache(List<String> listeTache) async {
    final oldchoixTache = _choixTaches;
    _choixTaches = listeTache;

    final success = await TachesStorageService.saveListeChoix(_choixTaches);

    if (!success) {
      _choixTaches = oldchoixTache;
      print("❌ Sauvegarde de la liste a échoué ");
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
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
