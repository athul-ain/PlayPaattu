import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widgets/song_list_tile.dart';

class SongsLibraryPage extends StatefulWidget {
  @override
  _SongsLibraryPageState createState() => _SongsLibraryPageState();
}

class _SongsLibraryPageState extends State<SongsLibraryPage> {
  int sdkVersion = 0;
  List<SongModel> allSongs = [];
  bool isLoading = true;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    getAllSongs();
    super.initState();
  }

  getAllSongs() async {
    int _sdkVersion = await OnAudioQuery().getDeviceSDK();
    setState(() => isLoading = true);
    var _audios = await OnAudioQuery().queryAudios();

    setState(() {
      sdkVersion = _sdkVersion;
      allSongs = _audios;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? FutureBuilder(
            future: Future.delayed(Duration(seconds: 1)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
          )
        : Scrollbar(
            thickness: 8,
            radius: Radius.circular(5),
            controller: controller,
            isAlwaysShown: true,
            child: ListView(
              controller: controller,
              children: allSongs
                  .map(
                    (e) => SongListTileWidget(
                      sdkVersion: sdkVersion,
                      thisSong: e,
                    ),
                  )
                  .toList(),
            ),
          );
  }
}
