import 'dart:io';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:play_paattu/pages/album_detail.dart';

class AlbumCartWidget extends StatelessWidget {
  final AlbumModel thisAlbum;
  final int sdkVersion;

  const AlbumCartWidget(
      {Key? key, required this.thisAlbum, required this.sdkVersion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: thisAlbum.id,
      child: Card(
        margin: EdgeInsets.all(3.8),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: sdkVersion >= 29
                      ? QueryArtworkWidget(
                          id: int.parse(thisAlbum.albumId),
                          type: ArtworkType.ALBUM,
                          artworkQuality: FilterQuality.medium,
                          artworkBorder: BorderRadius.circular(0),
                          nullArtworkWidget: Container(
                            color: Colors.black26,
                            child: Icon(
                              Icons.album,
                              color: Colors.grey[700],
                              size: 133,
                            ),
                          ),
                        )
                      : thisAlbum.artwork == null
                          ? Container(
                              color: Colors.black26,
                              child: Icon(
                                Icons.album,
                                color: Colors.grey[700],
                                size: 133,
                              ),
                            )
                          : Image(
                              image: FileImage(
                                File(thisAlbum.artwork!),
                              ),
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        thisAlbum.albumName,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        thisAlbum.artist,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              splashColor: Colors.black38,
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
        ),
      ),
    );
  }
}
