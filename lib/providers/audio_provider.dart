import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/allah_name.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();

  List<AllahName> _playlist = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _isLoading = false;
  bool _autoPlay = true;

  AllahName? get currentName =>
      _currentIndex < _playlist.length ? _playlist[_currentIndex] : null;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  int get totalCount => _playlist.length;

  AudioProvider() {
    _initializeTts();
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
  }

  Future<void> playByIndex(int index) async {
    if (index < 0 || index >= _playlist.length) return;

    _currentIndex = index;
    _isLoading = true;
    notifyListeners();

    final name = _playlist[index];

    try {
      // Try playing audio file if URL exists
      if (name.audioUrl != null && name.audioUrl!.isNotEmpty) {
        await _audioPlayer.play(UrlSource(name.audioUrl!));
        _isPlaying = true;
      } else {
        // Use Text-to-Speech for Arabic
        await _flutterTts.speak(name.arabic);
        _isPlaying = true;
      }
    } catch (e) {
      print('Error playing audio: $e');
      // Fallback to TTS
      await _flutterTts.speak(name.arabic);
      _isPlaying = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> play() async {
    if (_playlist.isEmpty) return;
    await playByIndex(_currentIndex);
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    await _flutterTts.stop();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> stop() async {
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
    if (_autoPlay && _currentIndex < _playlist.length - 1) {
      playByIndex(_currentIndex + 1);
    } else {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }
}
