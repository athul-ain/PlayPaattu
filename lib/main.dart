import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_paattu/pages/main.dart';
import 'package:play_paattu/utils/app_data.dart';
import 'package:play_paattu/utils/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());

  bool isDarkMode =
      WidgetsBinding.instance!.platformDispatcher.platformBrightness ==
          Brightness.dark;

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness:
        isDarkMode ? Brightness.light : Brightness.dark,
    systemNavigationBarContrastEnforced: true,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppData.APP_NAME,
            theme: notifier.appTheme == AppTheme.dark ? dark : light,
            darkTheme: notifier.appTheme == AppTheme.auto ? dark : null,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
