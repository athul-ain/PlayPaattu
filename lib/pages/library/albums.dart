import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widgets/album_card.dart';

class AlbumsLibraryPage extends StatefulWidget {
  const AlbumsLibraryPage({Key? key}) : super(key: key);

  @override
  _AlbumsLibraryPageState createState() => _AlbumsLibraryPageState();
}

class _AlbumsLibraryPageState extends State<AlbumsLibraryPage> {
  int sdkVersion = 0;
  List<AlbumModel> recentAlbums = [];

  @override
  void initState() {
    getRecentAlbums();
    super.initState();
  }

  Future<void> getRecentAlbums() async {
    DeviceModel deviceInfo = await OnAudioQuery().queryDeviceInfo();

    List<AlbumModel> _recentAlbums = await OnAudioQuery().queryAlbums();

    if (mounted) {
      setState(() {
        sdkVersion = deviceInfo.sdk;
        recentAlbums = _recentAlbums;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(5.0),
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      children: recentAlbums
          .map((e) => AlbumCartWidget(thisAlbum: e, sdkVersion: sdkVersion))
          .toList(),
    );
  }
}
