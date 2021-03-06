import 'package:flutter/material.dart';
import 'package:play_paattu/pages/library/genre.dart';
import 'artists.dart';
import 'songs.dart';
import 'albums.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 2,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          titleSpacing: 0,
          title: TabBar(
            indicatorColor: Theme.of(context).primaryColorDark,
            labelColor: Theme.of(context).primaryColorDark,
            unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color,
            tabs: const [
              Tab(text: "Genre"),
              Tab(text: "Artists"),
              Tab(text: "Albums"),
              Tab(text: "Songs"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GenreLibraryPage(),
            ArtistsLibraryPage(),
            AlbumsLibraryPage(),
            SongsLibraryPage(),
          ],
        ),
      ),
    );
  }
}
