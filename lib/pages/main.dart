import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
//import 'package:play_paattu/widgets/navbar.dart';
import 'package:share_plus/share_plus.dart';
import 'favorites.dart';
import 'playlists.dart';
import 'home.dart';
import 'library/library.dart';
import 'recents.dart';
import 'settings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int sdkVersion = 0;
  int selectedPage = 0;
  List mainPages = [
    const HomePage(),
    const FavoritesPage(),
    const PlaylistsPage(),
    const LibraryPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SongModel? currentSong;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: PageTransitionSwitcher(
              transitionBuilder:
                  (child, primaryAnimation, secondaryAnimation) =>
                      FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              ),
              child: mainPages[selectedPage],
            ),
          ),
          if (currentSong != null) Container(height: 58)
        ],
      ),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 11,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.88, 0.95, 1],
              colors: [
                Theme.of(context).appBarTheme.backgroundColor!,
                Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.5),
                Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.1),
              ],
            ),
          ),
        ),
        title: Card(
          color: Colors.deepOrange[100],
          clipBehavior: Clip.antiAlias,
          elevation: 0.1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          margin: const EdgeInsets.only(top: 3),
          child: InkWell(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Builder(
                    builder: (context) => IconButton(
                          icon: Icon(
                            Icons.menu_rounded,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        )),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                      text: "Play ",
                    ),
                    TextSpan(
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                      text: "Paattu",
                    ),
                  ]),
                ),
                IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: null,
                  disabledColor: Theme.of(context).primaryColorDark,
                )
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SafeArea(
              child: ListTile(
                title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).appBarTheme.iconTheme!.color),
                        text: "Play "),
                    TextSpan(
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                        text: "Paattu"),
                  ]),
                ),
              ),
            ),
            InkWell(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RecentsPage())),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Row(children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                  Icon(
                    Icons.history_rounded,
                    size: 25,
                    color: Theme.of(context).textTheme.button!.color,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                  Text(
                    "Recents",
                    style: Theme.of(context).textTheme.button,
                  )
                ]),
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Settings",
                style: Theme.of(context).textTheme.button,
              ),
              leading: Icon(
                Icons.settings_outlined,
                color: Theme.of(context).textTheme.button!.color,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              ),
            ),
            ListTile(
              title: Text(
                "Share",
                style: Theme.of(context).textTheme.button,
              ),
              leading: Icon(
                Icons.share_outlined,
                color: Theme.of(context).textTheme.button!.color,
              ),
              onTap: () => Share.share(
                  'Hey, I have Found a new awesome Music Player App Play Paattu, Check it out on Play Store https://play.google.com/store/apps/details?id=app.paattu.play'),
            ),
            SafeArea(child: Container()),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        height: 70,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: "Home",
            tooltip: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: "Favorites",
            tooltip: "Favorites",
          ),
          NavigationDestination(
            icon: Icon(Icons.playlist_play_outlined),
            selectedIcon: Icon(Icons.playlist_play_rounded),
            label: "Playlists",
            tooltip: "Playlists",
          ),
          NavigationDestination(
            icon: Icon(Icons.my_library_music_outlined),
            selectedIcon: Icon(Icons.my_library_music_rounded),
            label: "Library",
            tooltip: "Library",
          ),
        ],
        selectedIndex: selectedPage,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (value) {
          setState(() => selectedPage = value);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.music_note_outlined),
      ),
      bottomSheet: currentSong == null
          ? null
          : Container(
              color: Theme.of(context).cardColor,
              height: 58,
              child: Row(
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: QueryArtworkWidget(
                      artworkBorder: BorderRadius.circular(0),
                      id: currentSong.id,
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
                    ),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentSong.title,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Container(height: 3),
                        Text(
                          currentSong.artist ?? "",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.play_arrow_outlined),
                      onPressed: () {
                        //TODO: Play
                      })
                ],
              ),
            ),
    );
  }
}
