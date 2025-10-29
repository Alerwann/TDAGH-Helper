import 'package:flutter/foundation.dart';

import 'package:tdahelpe/services/audio_controller.dart';

class SoundProvider extends ChangeNotifier {
  AudioController? _audioController;
  bool _isReady = false;
  bool _isInitializing = false;
  bool _isPlaying = false;

  AudioController? get audioController => _audioController;
  bool get isReady => _isReady;
  bool get isInitializing => _isInitializing;
  bool get isPlaying => _isPlaying;

  // Méthode pour initialiser l'audio
  Future<void> initialize() async {
    if (_isInitializing || _isReady) {
      return;
    }

    _isInitializing = true;
    notifyListeners();

    try {
      _audioController = AudioController();
      await _audioController!.initialize();

      _isReady = true;
      _isInitializing = false;

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur initialisation audio: $e');
      }
      _isInitializing = false;
      notifyListeners();
    }
  }

  // ✅ FIX : Ne plus rethrow, logger l'erreur
  Future<void> playSound(String assetKey, String typeMemory) async {
    if (!_isReady) return;

    try {
      await _audioController!.playSound(assetKey, typeMemory);
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur lecture audio: $e');
      }
      _isPlaying = false;
      notifyListeners();
      // ✅ Ne pas rethrow - l'erreur est gérée ici
    }
  }

  // ✅ FIX : Ajouter try-catch
  Future<void> pauseSound() async {
    if (_isPlaying) {
      try {
        await _audioController!.pauseMusic();
        _isPlaying = false;
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print('❌ Erreur pause audio: $e');
        }
        _isPlaying = false;
        notifyListeners();
      }
    }
  }

  Future<void> stopSound() async {
    if (_isPlaying) {
      try {
        await _audioController!.stopMusic();
        _isPlaying = false;
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print('❌ Erreur stop audio: $e');
        }
        _isPlaying = false;
        notifyListeners();
      }
    }
  }

  // Nettoyage des ressources
  @override
  void dispose() {
    _audioController?.dispose();
    super.dispose();
  }
}
