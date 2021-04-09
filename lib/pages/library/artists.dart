import 'dart:io';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsLibraryPage extends StatefulWidget {
  @override
  _ArtistsLibraryPageState createState() => _ArtistsLibraryPageState();
}

class _ArtistsLibraryPageState extends State<ArtistsLibraryPage> {
  ScrollController controller = ScrollController();
  int sdkVersion = 0;
  List<ArtistModel> recentArtists = [];

  @override
  void initState() {
    getRecentArtists();
    super.initState();
  }

  Future<void> getRecentArtists() async {
    int _sdkVersion = await OnAudioQuery().getDeviceSDK();

    List<ArtistModel> _recentArtists = await OnAudioQuery().queryArtists();

    if (mounted)
      setState(() {
        sdkVersion = _sdkVersion;
        recentArtists = _recentArtists;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 8,
      radius: Radius.circular(5),
      controller: controller,
      isAlwaysShown: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          controller: controller,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: recentArtists
              .map((thisArtist) => Padding(
                    padding: const EdgeInsets.all(3),
                    child: Card(
                      margin: EdgeInsets.all(0),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                  child: sdkVersion >= 29
                                      ? QueryArtworkWidget(
                                          id: thisArtist.id,
                                          type: ArtworkType.ALBUM,
                                          nullArtworkWidget: Container(
                                            color: Colors.black26,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Icon(
                                                Icons.person_rounded,
                                                size: 88,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Ink.image(
                                          image: FileImage(
                                              File(thisArtist.artwork)),
                                          fit: BoxFit.cover)
                                  // : Container(
                                  //     color: Colors.black26,
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.all(18.0),
                                  //       child: Icon(
                                  //         Icons.person_rounded,
                                  //         size: 88,
                                  //         color:
                                  //             Theme.of(context).iconTheme.color,
                                  //       ),
                                  //     ),
                                  //   ),
                                  ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      thisArtist.artistName,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            splashColor: Colors.black38,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
