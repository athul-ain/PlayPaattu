import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:play_paattu/services/music.dart';
import 'package:provider/provider.dart';
import '../utils/duration_parser.dart';

class SongListTileWidget extends StatelessWidget {
  const SongListTileWidget({
    Key? key,
    required this.sdkVersion,
    required this.thisSong,
    this.index,
  }) : super(key: key);

  final int sdkVersion;
  final SongModel thisSong;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(thisSong.title),
      subtitle: Text(
          "${thisSong.artist} • ${durationToMinutesSeconds(thisSong.duration)}"),
      leading: index != null
          ? Padding(
              padding: const EdgeInsets.only(left: 21),
              child: Text("$index"),
            )
          : Card(
              clipBehavior: Clip.antiAlias,
              child: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(0),
                id: thisSong.id,
                type: ArtworkType.AUDIO,
                artworkQuality: FilterQuality.low,
                nullArtworkWidget: Container(
                  width: 50,
                  height: 50,
                  color: Colors.black26,
                  child: Icon(
                    Icons.album,
                    color: Colors.grey[700],
                    size: 30,
                  ),
                ),
                artwork: thisSong.artwork,
                deviceSDK: sdkVersion,
              ),
            ),
      onTap: () {
        print("playing ${thisSong.data}");
        //Provider.of<MusicService>(context, listen: false).playSong(thisSong);
      },
    );
  }
}
