import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:play_paattu/widgets/album_card.dart';

import 'recents.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sdkVersion = 0;
  List<AlbumModel> recentAlbums = [];

  @override
  void initState() {
    getRecentAlbums();
    super.initState();
  }

  Future<void> getRecentAlbums() async {
    int _sdkVersion = await OnAudioQuery().getDeviceSDK();

    List<AlbumModel> _recentAlbums = await OnAudioQuery()
        .queryAlbums(AlbumSortType.LAST_YEAR, null, null, true);

    setState(() {
      sdkVersion = _sdkVersion;
      recentAlbums = _recentAlbums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (recentAlbums.length > 0)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Recent Activity",
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RecentsPage())),
                  child: Text("VIEW ALL"),
                )
              ],
            ),
          ),
        Container(
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: recentAlbums
                .map((e) =>
                    AlbumCartWidget(thisAlbum: e, sdkVersion: sdkVersion))
                .toList(),
          ),
        )
      ],
    );
  }
}
