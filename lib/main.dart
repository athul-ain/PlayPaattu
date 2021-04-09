import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_paattu/pages/main.dart';
import 'package:play_paattu/services/music.dart';
import 'package:play_paattu/utils/app_data.dart';
import 'package:play_paattu/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());

  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    //systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider<MusicService>.value(
          value: MusicService(),
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppData.APP_NAME,
            theme: notifier.appTheme == AppTheme.dark ? dark : light,
            darkTheme: notifier.appTheme == AppTheme.auto ? dark : null,
            home: MainScreen(),
          );
        },
      ),
    );
  }
}
