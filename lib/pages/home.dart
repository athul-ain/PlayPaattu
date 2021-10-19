import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../widgets/album_card.dart';
import 'recents.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
    DeviceModel deviceInfo = await OnAudioQuery().queryDeviceInfo();

    List<AlbumModel> _recentAlbums = await OnAudioQuery()
        .queryAlbums(AlbumSortType.LAST_YEAR, null, null, true);

    setState(() {
      sdkVersion = deviceInfo.sdk;
      recentAlbums = _recentAlbums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (recentAlbums.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Recent Activity",
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecentsPage())),
                  child: const Text("VIEW ALL"),
                )
              ],
            ),
          ),
        GridView.count(
          padding: const EdgeInsets.only(left: 5, right: 5),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: recentAlbums
              .map((e) => AlbumCartWidget(thisAlbum: e, sdkVersion: sdkVersion))
              .toList(),
        )
      ],
    );
  }
}
