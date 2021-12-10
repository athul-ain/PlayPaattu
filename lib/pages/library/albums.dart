import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widgets/album_card.dart';

class AlbumsLibraryPage extends StatefulWidget {
  const AlbumsLibraryPage({Key? key}) : super(key: key);

  @override
  _AlbumsLibraryPageState createState() => _AlbumsLibraryPageState();
}

class _AlbumsLibraryPageState extends State<AlbumsLibraryPage> {
  List<AlbumModel> recentAlbums = [];

  @override
  void initState() {
    getRecentAlbums();
    super.initState();
  }

  Future<void> getRecentAlbums() async {
    log("message");

    List<AlbumModel> _recentAlbums =
        await OnAudioQuery().queryAlbums(sortType: AlbumSortType.ALBUM);

    if (mounted) {
      setState(() {
        recentAlbums = _recentAlbums;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(
        left: 5.0,
        right: 5.0,
        top: 5.0,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      children: recentAlbums.map((e) => AlbumCardWidget(thisAlbum: e)).toList(),
    );
  }
}
