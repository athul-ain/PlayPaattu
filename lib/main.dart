import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_paattu/pages/main.dart';
import 'package:play_paattu/utils/app_data.dart';
import 'package:play_paattu/utils/theme.dart';
import 'package:provider/provider.dart';

import 'services/music.dart';

void main() {
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
}

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        // ChangeNotifierProvider<MusicService>.value(
        //   value: MusicService(),
        // ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppData.APP_NAME,
            theme: notifier.appTheme == AppTheme.dark ? dark : light,
            darkTheme: notifier.appTheme == AppTheme.auto ? dark : null,
            home: AudioServiceWidget(child: MainScreen()),
          );
        },
      ),
    );
  }
}
