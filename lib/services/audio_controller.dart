import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:logging/logging.dart';

class AudioController {
  static final Logger _log = Logger('AudioController');
  AudioPlayer? _audioPlayer;
  bool _isInitialized = false;

  Future<void> initialize() async {
    try {
      _audioPlayer = AudioPlayer();

      await _audioPlayer!.setAudioContext(
        AudioContext(
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.playback,
            options: {
              AVAudioSessionOptions.mixWithOthers,
              AVAudioSessionOptions.duckOthers,
            },
          ),
          android: AudioContextAndroid(
            isSpeakerphoneOn: false,
            stayAwake: true,
            contentType: AndroidContentType.music,
            usageType: AndroidUsageType.media,
            audioFocus: AndroidAudioFocus.gain,
          ),
        ),
      );

      _isInitialized = true;
      _log.info('AudioController initialized successfully');
    } catch (e) {
      _log.severe('Error initializing AudioController: $e');
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
    // LIGNE 1

    if (!_isInitialized || _audioPlayer == null) {
      // LIGNE 2
      _log.warning('AudioController not initialized, initializing now...');
      await initialize();
    }

    // LIGNE 3

    try {
      if (typeMemory == "interne") {
        // LIGNE 4
        await _audioPlayer!.play(DeviceFileSource(assetKey));
        // LIGNE 5
      } else if (typeMemory == "appli") {
        // LIGNE 6
        await _audioPlayer!.play(AssetSource(assetKey));
        // LIGNE 7
      }
    } catch (e) {
      // LIGNE 8
      _log.severe('Error playing sound: $e');

      try {
        if (typeMemory == "interne") {
          await _audioPlayer!.play(DeviceFileSource(assetKey));
        } else if (typeMemory == "appli") {
          await _audioPlayer!.play(AssetSource(assetKey));
        }
      } catch (e2) {
        // LIGNE 9
        _log.severe('Error playing sound: $e2');
      }
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
      await _audioPlayer!.pause();
    } else {
      _log.warning('Cannot pause: AudioController not initialized');
    }
  }

  Future<void> stopMusic() async {
    if (_audioPlayer != null && _isInitialized) {
      await _audioPlayer!.stop();
    } else {
      _log.warning('Cannot stop: AudioController not initialized');
    }
  }
}
