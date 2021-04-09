import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:play_paattu/widgets/song_list_tile.dart';

class AlbumDetailPage extends StatefulWidget {
  const AlbumDetailPage({Key? key, required this.thisAlbum}) : super(key: key);
  final AlbumModel thisAlbum;

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  int sdkVersion = 0;
  List<SongModel> songs = [];

  @override
  void initState() {
    getSongs();
    super.initState();
  }

  Future<void> getSongs() async {
    int _sdkVersion = await OnAudioQuery().getDeviceSDK();

    List<SongModel> _songs = await OnAudioQuery()
        .queryAudiosFrom(AudiosFromType.ALBUM, widget.thisAlbum.albumName);

    if (mounted)
      setState(() {
        sdkVersion = _sdkVersion;
        songs = _songs;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).canvasColor.withOpacity(0.4),
                      Theme.of(context).canvasColor.withOpacity(0.2),
                      Theme.of(context).canvasColor.withOpacity(0.1),
                      Theme.of(context).canvasColor.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).textTheme.caption!.color,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            expandedHeight: MediaQuery.of(context).size.width < 360
                ? MediaQuery.of(context).size.width
                : 360,
            brightness: Brightness.dark,
            backgroundColor: Theme.of(context).backgroundColor,
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.thisAlbum.albumId,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      stops: [0.36, 0.93],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [Colors.black12, Colors.transparent],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.luminosity,
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: sdkVersion >= 29
                        ? QueryArtworkWidget(
                            artworkBorder: BorderRadius.circular(0),
                            id: int.parse(widget.thisAlbum.albumId),
                            type: ArtworkType.ALBUM,
                            artworkQuality: FilterQuality.high,
                            nullArtworkWidget: Container(
                              color: Colors.black26,
                              child: Icon(
                                Icons.album,
                                color: Colors.grey[700],
                                size: 188,
                              ),
                            ),
                          )
                        : widget.thisAlbum.artwork != null
                            ? Image(
                                image: FileImage(
                                  File(widget.thisAlbum.artwork!),
                                ),
                              )
                            : Container(
                                color: Colors.black26,
                                child: Icon(
                                  Icons.album,
                                  color: Colors.grey[700],
                                  size: 133,
                                ),
                              ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.queue_music_rounded,
                          color: Colors.grey[500],
                        ),
                      ),
                      title: Text(
                        songs.length == 0 ? "" : songs[0].album,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(songs.length == 0
                          ? ""
                          : songs.length.toString() + " Songs"),
                    )
                  ] +
                  List.generate(
                    songs.length,
                    (index) => SongListTileWidget(
                      sdkVersion: sdkVersion,
                      thisSong: songs[index],
                      index: index + 1,
                    ),
                  ) +
                  [SafeArea(child: Container())],
            ),
          )
        ],
      ),
    );
  }
}
