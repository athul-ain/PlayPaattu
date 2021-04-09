import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:play_paattu/widgets/album_card.dart';

class RecentsPage extends StatefulWidget {
  @override
  _RecentsPageState createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
  ScrollController controller = ScrollController();
  int sdkVersion = 0;
  List<AlbumModel> recentAlbums = [];

  @override
  void initState() {
    getRecentAlbums();
    super.initState();
  }

  Future<void> getRecentAlbums() async {
    int _sdkVersion = await OnAudioQuery().getDeviceSDK();

    List<AlbumModel> _recentAlbums = await OnAudioQuery()
        .queryAlbums(AlbumSortType.LAST_YEAR, null, null, true);

    setState(() {
      sdkVersion = _sdkVersion;
      recentAlbums = _recentAlbums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recents")),
      body: Scrollbar(
        thickness: 8,
        radius: Radius.circular(5),
        controller: controller,
        isAlwaysShown: true,
        child: GridView.count(
          controller: controller,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: recentAlbums
              .map((e) => AlbumCartWidget(thisAlbum: e, sdkVersion: sdkVersion))
              .toList(),
        ),
      ),
    );
  }
}
