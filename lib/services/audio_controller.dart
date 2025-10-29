import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:logging/logging.dart';

class AudioController {
  static final Logger _log = Logger('AudioController');
  AudioPlayer? _audioPlayer;
  bool _isInitialized = false;

  Future<void> initialize() async {
    try {
      _audioPlayer = AudioPlayer();

      if (Platform.isIOS) {
        await _audioPlayer!.setAudioContext(
          AudioContext(
            iOS: AudioContextIOS(
              category: AVAudioSessionCategory.playback,
              options: {
                AVAudioSessionOptions.mixWithOthers,
                AVAudioSessionOptions.duckOthers,
              },
            ),
          ),
        );
      } else if (Platform.isAndroid) {
        await _audioPlayer!.setAudioContext(
          AudioContext(
            android: AudioContextAndroid(
              isSpeakerphoneOn: false,
              stayAwake: true,
              contentType: AndroidContentType.music,
              usageType: AndroidUsageType.media,
              audioFocus: AndroidAudioFocus.gain,
            ),
          ),
        );
      }

      _isInitialized = true;
      _log.info('AudioController initialized successfully');
    } catch (e) {
      _log.severe('Error initializing AudioController: $e');
      _isInitialized = false;
    }
  }

  void dispose() {
    try {
      if (_audioPlayer != null && _isInitialized) {
        _audioPlayer!.dispose();
        _audioPlayer = null;
        _isInitialized = false;
        _log.info('AudioController disposed');
      }
    } catch (e) {
      _log.severe('Error disposing AudioController: $e');
    }
  }

  Future<void> playSound(String assetKey, String typeMemory) async {
    if (!_isInitialized || _audioPlayer == null) {
      await initialize();
      if (!_isInitialized) {
        _log.severe('Impossible d\'initialiser l\'audio');
        return;
      }
    }

    try {
      await _audioPlayer!.stop();

      if (typeMemory == "interne") {
        await _audioPlayer!.play(DeviceFileSource(assetKey));
      } else if (typeMemory == "appli") {
        await _audioPlayer!.play(AssetSource(assetKey));
      }
    } catch (e) {
      _log.severe('Erreur lecture audio: $e');
    }
  }

  Future<void> playDeviceFile(String filePath) async {
    if (!_isInitialized || _audioPlayer == null) {
      _log.warning('AudioController not initialized, initializing now...');
      await initialize();
    }

    try {
      await _audioPlayer!.play(DeviceFileSource(filePath));
      _log.info('Playing device file: $filePath');
    } catch (e) {
      _log.severe('Error playing device file: $e');

      try {
        await _audioPlayer!.play(DeviceFileSource(filePath));
      } catch (e2) {
        _log.severe('Error playing device file: $e2');
      }
    }
  }

Future<void> pauseMusic() async {
    if (_audioPlayer != null && _isInitialized) {
      try {
        await _audioPlayer!.pause();
      } catch (e) {
        _log.severe('Error pausing audio: $e');
      }
    } else {
      _log.warning('Cannot pause: AudioController not initialized');
    }
  }

  Future<void> stopMusic() async {
    if (_audioPlayer != null && _isInitialized) {
      try {
        await _audioPlayer!.stop();
        await _audioPlayer!.release();
      } catch (e) {
        _log.severe('Error stopping audio: $e');
      }
    } else {
      _log.warning('Cannot stop: AudioController not initialized');
    }
  }
}
