import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:play_paattu/pages/album_detail.dart';

class AlbumCardWidget extends StatelessWidget {
  final AlbumModel thisAlbum;

  const AlbumCardWidget({
    Key? key,
    required this.thisAlbum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: thisAlbum.id,
                  child: QueryArtworkWidget(
                    id: thisAlbum.id,
                    type: ArtworkType.ALBUM,
                    artworkQuality: FilterQuality.medium,
                    artworkBorder: BorderRadius.circular(8),
                    nullArtworkWidget: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    thisAlbum.album,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    thisAlbum.artist ?? "",
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlbumDetailPage(thisAlbum: thisAlbum),
              ),
            );
          },
        )
      ],
    );
  }
}
