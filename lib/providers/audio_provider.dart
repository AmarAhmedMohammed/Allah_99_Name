import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/allah_name.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _preloadPlayer = AudioPlayer(); // For preloading next track
  final FlutterTts _flutterTts = FlutterTts();
  Timer? _nextTrackTimer;

  List<AllahName> _playlist = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _isLoading = false;
  final bool _autoPlay = true;

  AllahName? get currentName =>
      _currentIndex < _playlist.length ? _playlist[_currentIndex] : null;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  int get totalCount => _playlist.length;

  AudioProvider() {
    _initializeTts();
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() {
    // Set audio player to low latency mode for faster playback
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _audioPlayer.setPlayerMode(PlayerMode.lowLatency);

    _audioPlayer.onPlayerComplete.listen((_) {
      _onAudioComplete();
    });
  }

  void _initializeTts() async {
    await _flutterTts.setLanguage('ar-SA');
    await _flutterTts.setSpeechRate(0.4); // Slower for learning
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setCompletionHandler(() {
      _onAudioComplete();
    });
  }

  void setPlaylist(List<AllahName> names) {
    _playlist = names;
    _currentIndex = 0;
    notifyListeners();

    // Preload first audio for instant playback
    if (_playlist.isNotEmpty) {
      _preloadAudio(0);
    }
  }

  /// Preload audio for instant playback
  Future<void> _preloadAudio(int index) async {
    if (index < 0 || index >= _playlist.length) return;

    final name = _playlist[index];
    if (!name.hasAudio) return;

    try {
      final url = name.audioUrl!;
      if (url.startsWith('assets/')) {
        final assetPath = url.replaceFirst('assets/', '');
        await _preloadPlayer.setSource(AssetSource(assetPath));
      } else {
        await _preloadPlayer.setSource(UrlSource(url));
      }
      debugPrint('✅ Preloaded audio for index $index');
    } catch (e) {
      debugPrint('⚠️ Failed to preload audio: $e');
    }
  }

  Future<void> playByIndex(int index) async {
    _nextTrackTimer?.cancel();
    if (index < 0 || index >= _playlist.length) return;

    _currentIndex = index;
    _isLoading = true;
    notifyListeners();

    final name = _playlist[index];

    try {
      // Try playing beautiful recitation from multiple sources
      bool audioPlayed = false;

      if (name.hasAudio) {
        // Try primary audio URL with immediate playback
        audioPlayed = await _tryPlayAudioFast(name.audioUrl!);

        // If primary fails, try alternative URLs
        if (!audioPlayed) {
          final alternativeUrls = name.getAlternativeAudioUrls();
          for (final url in alternativeUrls) {
            audioPlayed = await _tryPlayAudioFast(url);
            if (audioPlayed) break;
          }
        }
      }

      // Fallback to Text-to-Speech if all audio sources fail
      if (!audioPlayed) {
        await _flutterTts.speak(name.arabic);
        _isPlaying = true;
      }

      // Preload next track for instant playback
      if (_currentIndex < _playlist.length - 1) {
        _preloadAudio(_currentIndex + 1);
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
      // Final fallback to TTS
      await _flutterTts.speak(name.arabic);
      _isPlaying = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Try to play audio with optimized fast playback
  Future<bool> _tryPlayAudioFast(String url) async {
    try {
      debugPrint('🎵 Fast play: $url');

      // Check if it's a local asset or remote URL
      if (url.startsWith('assets/')) {
        // Play from local asset with low latency
        final assetPath = url.replaceFirst('assets/', '');
        debugPrint('📁 Loading local asset: $assetPath');

        // Set source and play immediately
        await _audioPlayer.play(AssetSource(assetPath));
      } else {
        // Play from remote URL
        debugPrint('🌐 Loading remote URL: $url');
        await _audioPlayer.play(UrlSource(url));
      }

      _isPlaying = true;
      debugPrint('✅ Audio playing successfully');
      return true;
    } catch (e) {
      debugPrint('❌ Failed to play audio from: $url');
      debugPrint('❌ Error: $e');
      return false;
    }
  }

  Future<void> play() async {
    if (_playlist.isEmpty) return;
    await playByIndex(_currentIndex);
  }

  Future<void> pause() async {
    _nextTrackTimer?.cancel();
    await _audioPlayer.pause();
    await _flutterTts.stop();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> stop() async {
    _nextTrackTimer?.cancel();
    await _audioPlayer.stop();
    await _flutterTts.stop();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> next() async {
    if (_currentIndex < _playlist.length - 1) {
      await playByIndex(_currentIndex + 1);
    } else {
      // Loop back to start
      await playByIndex(0);
    }
  }

  Future<void> previous() async {
    if (_currentIndex > 0) {
      await playByIndex(_currentIndex - 1);
    } else {
      // Go to last
      await playByIndex(_playlist.length - 1);
    }
  }

  Future<void> togglePlay() async {
    if (_isPlaying) {
      await pause();
    } else {
      await play();
    }
  }

  void _onAudioComplete() {
    _isPlaying = false;
    notifyListeners();

    if (_autoPlay && _currentIndex < _playlist.length - 1) {
      _nextTrackTimer?.cancel();
      _nextTrackTimer = Timer(const Duration(seconds: 3), () {
        if (_autoPlay) {
          playByIndex(_currentIndex + 1);
        }
      });
    }
  }

  @override
  void dispose() {
    _nextTrackTimer?.cancel();
    _audioPlayer.dispose();
    _preloadPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }
}
