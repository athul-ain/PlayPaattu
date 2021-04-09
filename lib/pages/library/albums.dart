import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widgets/album_card.dart';

class AlbumsLibraryPage extends StatefulWidget {
  @override
  _AlbumsLibraryPageState createState() => _AlbumsLibraryPageState();
}

class _AlbumsLibraryPageState extends State<AlbumsLibraryPage> {
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

    List<AlbumModel> _recentAlbums = await OnAudioQuery().queryAlbums();

    if (mounted)
      setState(() {
        sdkVersion = _sdkVersion;
        recentAlbums = _recentAlbums;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
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
    );
  }
}
