import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:play_paattu/widgets/album_card.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({Key? key}) : super(key: key);

  @override
  _RecentsPageState createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
  ScrollController controller = ScrollController();
  List<AlbumModel> recentAlbums = [];

  @override
  void initState() {
    getRecentAlbums();
    super.initState();
  }

  Future<void> getRecentAlbums() async {
    List<AlbumModel> _recentAlbums = await OnAudioQuery().queryAlbums();

    setState(() {
      recentAlbums = _recentAlbums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recents")),
      body: Scrollbar(
        controller: controller,
        isAlwaysShown: true,
        child: GridView.count(
          controller: controller,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children:
              recentAlbums.map((e) => AlbumCardWidget(thisAlbum: e)).toList(),
        ),
      ),
    );
  }
}
