import 'package:flutter/material.dart';
import 'package:flutter_application_1/audio/audio_controller.dart';

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

  Future<void> playSound(String assetKey) async {
    if (!_isReady || _audioController == null) {
      return;
    }

    await _audioController!.playSound(assetKey);
    _isPlaying = true;
  }

  Future<void> pauseSound() async {
    if (!isPlaying) {
      return;
    }

    await _audioController!.pauseMusic();
    _isPlaying = false;
  }
  Future<void> stopSound() async {
    if (!isPlaying) {
      return;
    }

    await _audioController!.stopMusic();
    _isPlaying = false;
  }
  // Nettoyage des ressources
  @override
  void dispose() {
    _audioController?.dispose();
    super.dispose();
  }
}
