import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GenreLibraryPage extends StatefulWidget {
  @override
  _GenreLibraryPageState createState() => _GenreLibraryPageState();
}

class _GenreLibraryPageState extends State<GenreLibraryPage> {
  int sdkVersion = 0;
  List<GenreModel> genres = [];

  @override
  void initState() {
    getGenreAlbums();
    super.initState();
  }

  Future<void> getGenreAlbums() async {
    int _sdkVersion = await OnAudioQuery().getDeviceSDK();

    List<GenreModel> _genres = await OnAudioQuery().queryGenres();

    if (mounted)
      setState(() {
        sdkVersion = _sdkVersion;
        genres = _genres;
      });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2,
      children: genres
          .map(
            (e) => Card(
              clipBehavior: Clip.antiAlias,
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor.withOpacity(0.08),
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Text(
                    e.genreName,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
