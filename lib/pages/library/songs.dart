import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widgets/song_list_tile.dart';

class SongsLibraryPage extends StatefulWidget {
  const SongsLibraryPage({Key? key}) : super(key: key);

  @override
  _SongsLibraryPageState createState() => _SongsLibraryPageState();
}

class _SongsLibraryPageState extends State<SongsLibraryPage> {
  int sdkVersion = 0;
  List<SongModel> allSongs = [];
  bool isLoading = true;
  @override
  void initState() {
    getAllSongs();
    super.initState();
  }

  getAllSongs() async {
    DeviceModel deviceInfo = await OnAudioQuery().queryDeviceInfo();
    if (mounted) setState(() => isLoading = true);
    var _audios = await OnAudioQuery().querySongs();

    if (mounted) {
      setState(() {
        sdkVersion = deviceInfo.version;
        allSongs = _audios;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? FutureBuilder(
            future: Future.delayed(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
          )
        : ListView(
            children: allSongs
                .map(
                  (e) => SongListTileWidget(
                    sdkVersion: sdkVersion,
                    thisSong: e,
                  ),
                )
                .toList(),
          );
  }
}
