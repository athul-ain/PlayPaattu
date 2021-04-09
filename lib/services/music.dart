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

  SongModel? _nowPlayingSong;
  SongModel? get nowPlayingSong => _nowPlayingSong;
  setNowPlayingSong(SongModel thisSong) {
    _nowPlayingSong = thisSong;
    notifyListeners();
  }

  String? _nowSongID;
  String? get nowSongID => _nowSongID;
  setNowSongID(id) {
    _nowSongID = id;
    notifyListeners();
  }

  playSong(SongModel thisSong) async {
    setNowPlayingSong(thisSong);
    await audioPlayer
        .play(thisSong.data, volume: 1, isLocal: true, stayAwake: true)
        .then((value) {
      _isPlaying = true;
      notifyListeners();
    });
  }

  pauseSong(SongModel thisSong) async {
    setNowPlayingSong(thisSong);
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
