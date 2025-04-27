import 'package:just_audio/just_audio.dart';

import '../models/radio_station.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  RadioStation? _currentStation;
  RadioStation? get currentStation => _currentStation;

  Future<void> setUrl(String url) async {
    await _audioPlayer.setUrl(url);
  }

  void play() => _audioPlayer.play();

  void pause() => _audioPlayer.pause();

  void stop() => _audioPlayer.stop();

  void setVolume(double volume) => _audioPlayer.setVolume(volume);

  void setCurrentStation(RadioStation station) {
    _currentStation = station;
  }

  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

  void dispose() {
    _audioPlayer.dispose();
  }
}