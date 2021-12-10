import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    DeviceModel deviceInfo = await OnAudioQuery().queryDeviceInfo();

    List<SongModel> _songs = await OnAudioQuery()
        .queryAudiosFrom(AudiosFromType.ALBUM_ID, widget.thisAlbum.id);

    if (mounted) {
      setState(() {
        sdkVersion = deviceInfo.version;
        songs = _songs;
      });
    }
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
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.thisAlbum.id,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
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
                    padding: const EdgeInsets.all(0),
                    child: QueryArtworkWidget(
                      artworkBorder: BorderRadius.circular(0),
                      id: widget.thisAlbum.id,
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
                        songs.isEmpty ? "" : songs[0].album ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(songs.isEmpty
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
