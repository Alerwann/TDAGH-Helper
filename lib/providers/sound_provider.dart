import 'package:flutter/material.dart';
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
      _isInitializing = false;
      notifyListeners();
    }
  }

Future<void> playSound(String assetKey, String typeMemory) async {
    if (!_isReady) return;
    await _audioController!.playSound(assetKey, typeMemory);
    _isPlaying = true; 
    notifyListeners();
  }

  Future<void> pauseSound() async {
    if (_isPlaying) {
      await _audioController!.pauseMusic();
      _isPlaying = false; 
      notifyListeners();
    }
  }

  Future<void> stopSound() async {
    if (_isPlaying) {
      await _audioController!.stopMusic();
      _isPlaying = false; 
      notifyListeners();
    }
  }


  // Nettoyage des ressources
  @override
  void dispose() {
    _audioController?.dispose();
    super.dispose();
  }
}
