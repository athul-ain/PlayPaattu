import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';
import 'favorites.dart';
import 'playlists.dart';
import 'home.dart';
import 'library/library.dart';
import 'recents.dart';
import 'settings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int sdkVersion = 0;
  int selectedPage = 0;
  List mainPages = [
    HomePage(),
    FavoritesPage(),
    PlaylistsPage(),
    LibraryPage(),
  ];

  @override
  void initState() {
    getSdkVersion();
    super.initState();
  }

  getSdkVersion() async {
    DeviceModel deviceInfo = await OnAudioQuery().queryDeviceInfo();
    if (mounted) setState(() => sdkVersion = deviceInfo.sdk);
  }

  @override
  Widget build(BuildContext context) {
    SongModel? currentSong = null;
    //Provider.of<MusicService>(context).nowPlayingSong;
    bool isPlaying = false;
    // Provider.of<MusicService>(context).isPlaying;

    return Container(
      color: Theme.of(context).canvasColor,
      child: Scaffold(
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
                stops: [0.88, 0.95, 1],
                colors: [
                  Theme.of(context).appBarTheme.color!,
                  Theme.of(context).appBarTheme.color!.withOpacity(0.5),
                  Theme.of(context).appBarTheme.color!.withOpacity(0.1),
                ],
              ),
            ),
          ),
          title: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(top: 3),
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
                            icon: Icon(Icons.menu_rounded,
                                color: Theme.of(context)
                                    .appBarTheme
                                    .iconTheme!
                                    .color),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          )),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
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
                    icon: Icon(Icons.search_rounded),
                    onPressed: null,
                    disabledColor:
                        Theme.of(context).appBarTheme.iconTheme!.color,
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
                              color: Theme.of(context)
                                  .appBarTheme
                                  .iconTheme!
                                  .color),
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
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RecentsPage())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Row(children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                    Icon(
                      Icons.history_rounded,
                      size: 25,
                      color: Theme.of(context).textTheme.button!.color,
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                    Text(
                      "Recents",
                      style: Theme.of(context).textTheme.button,
                    )
                  ]),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Settings",
                  style: Theme.of(context).textTheme.button,
                ),
                leading: Icon(
                  Icons.settings_outlined,
                  color: Theme.of(context).textTheme.button!.color,
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage())),
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (value) {
            setState(() => selectedPage = value);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              activeIcon: Icon(Icons.favorite_rounded),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play_outlined),
              activeIcon: Icon(Icons.playlist_play_rounded),
              label: "Playlists",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_music_outlined),
              activeIcon: Icon(Icons.my_library_music_rounded),
              label: "Library",
            ),
          ],
          fixedColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).textTheme.caption!.color,
          type: BottomNavigationBarType.fixed,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.music_note_outlined),
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
                        artwork: currentSong.artwork,
                        deviceSDK: sdkVersion,
                      ),
                    ),
                    Container(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${currentSong.title}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Container(height: 3),
                          Text(
                            "${currentSong.artist}",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_outlined
                              : Icons.play_arrow_outlined,
                        ),
                        onPressed: () {
                          // if (isPlaying) {
                          //   Provider.of<MusicService>(context, listen: false)
                          //       .pauseSong(currentSong);
                          // } else {
                          //   Provider.of<MusicService>(context, listen: false)
                          //       .resumeSong();
                          // }
                        })
                  ],
                ),
              ),
      ),
    );
  }
}
