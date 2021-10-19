import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../utils/duration_parser.dart';

class SongListTileWidget extends StatefulWidget {
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
  State<SongListTileWidget> createState() => _SongListTileWidgetState();
}

class _SongListTileWidgetState extends State<SongListTileWidget> {
  AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.thisSong.title),
      subtitle: Text(
          "${widget.thisSong.artist} • ${durationToMinutesSeconds(widget.thisSong.duration)}"),
      leading: widget.index != null
          ? Padding(
              padding: const EdgeInsets.only(left: 21),
              child: Text("${widget.index}"),
            )
          : Card(
              clipBehavior: Clip.antiAlias,
              child: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(0),
                id: widget.thisSong.id,
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
                artwork: widget.thisSong.artwork,
                deviceSDK: widget.sdkVersion,
              ),
            ),
      onTap: () {
        print("playing ${widget.thisSong.data}");

        AudioSource.uri(
          Uri.parse(widget.thisSong.data),
          tag: MediaItem(
            // Specify a unique ID for each media item:
            id: '1',
            // Metadata to display in the notification:
            album: "Album name",
            title: "Song name",
            artUri: Uri.parse('https://example.com/albumart.jpg'),
          ),
        );
      },
    );
  }
}
