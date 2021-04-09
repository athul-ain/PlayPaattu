import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicService extends ChangeNotifier {
  MusicService() {
    _isPlaying = false;
  }

  AudioPlayer audioPlayer = AudioPlayer(playerId: 'PlayPaattu');

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool val) {
    _isPlaying = val;
    notifyListeners();
  }

  String? _nowSongID;
  String? get nowSongID => _nowSongID;
  setNowSongID(id) {
    _nowSongID = id;
    notifyListeners();
  }

  playSong(SongModel songnow) async {
    await audioPlayer
        .play(songnow.data, volume: 1, isLocal: true, stayAwake: true)
        .then((value) {
      _isPlaying = true;
      notifyListeners();
    });
  }

  pauseSong(SongModel nowsong) async {
    await audioPlayer.pause().then((value) {
      _isPlaying = false;
    });
    notifyListeners();
  }

  resumeSong() async {
    await audioPlayer.resume().then((value) {
      _isPlaying = true;
    });
    notifyListeners();
  }

  void seekTo(pos) async {
    await audioPlayer.seek(Duration(seconds: pos));
    notifyListeners();
  }
}
