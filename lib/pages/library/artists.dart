import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsLibraryPage extends StatefulWidget {
  const ArtistsLibraryPage({Key? key}) : super(key: key);

  @override
  _ArtistsLibraryPageState createState() => _ArtistsLibraryPageState();
}

class _ArtistsLibraryPageState extends State<ArtistsLibraryPage> {
  int sdkVersion = 0;
  List<ArtistModel> recentArtists = [];

  @override
  void initState() {
    getRecentArtists();
    super.initState();
  }

  Future<void> getRecentArtists() async {
    List<ArtistModel> _recentArtists = await OnAudioQuery().queryArtists();

    if (mounted) {
      setState(() {
        recentArtists = _recentArtists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(
        left: 5.0,
        right: 5.0,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      children: recentArtists
          .map((thisArtist) => Padding(
                padding: const EdgeInsets.all(3),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: QueryArtworkWidget(
                              id: thisArtist.id,
                              type: ArtworkType.ALBUM,
                              nullArtworkWidget: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[300],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Icon(
                                    Icons.person_rounded,
                                    size: 88,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              ),
                              artworkBorder: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                thisArtist.artist,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(onTap: () {}),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
