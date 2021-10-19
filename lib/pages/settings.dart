import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(11),
                  child: Text(
                    "Theme",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.bodyText1!.fontWeight,
                    ),
                  ),
                ),
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) {
                    String _currenttheme;
                    if (notifier.appTheme == AppTheme.light) {
                      _currenttheme = "Light";
                    } else if (notifier.appTheme == AppTheme.dark) {
                      _currenttheme = "Dark";
                    } else {
                      _currenttheme = "System default";
                    }

                    return ListTile(
                      leading: const Icon(Icons.nights_stay_rounded),
                      title: const Text("Choose theme"),
                      subtitle: Text(_currenttheme),
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            int value;
                            if (notifier.appTheme == AppTheme.light) {
                              value = 2;
                            } else if (notifier.appTheme == AppTheme.dark) {
                              value = 3;
                            } else {
                              value = 1;
                            }

                            return AlertDialog(
                              title: const Text('Choose theme'),
                              content: SizedBox(
                                height: 145,
                                width: 800,
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      value: 1,
                                      dense: true,
                                      title: const Text("System default"),
                                      groupValue: value,
                                      onChanged: (val) {
                                        notifier.setAutoTheme();
                                      },
                                    ),
                                    RadioListTile(
                                      value: 2,
                                      dense: true,
                                      title: const Text("Light"),
                                      groupValue: value,
                                      onChanged: (val) {
                                        notifier.setLightTheme();
                                      },
                                    ),
                                    RadioListTile(
                                      value: 3,
                                      dense: true,
                                      title: const Text("Dark"),
                                      groupValue: value,
                                      onChanged: (val) {
                                        notifier.setDarkTheme();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('DONE'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(11),
                  child: Text(
                    "About",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.bodyText1!.fontWeight,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text("Share app"),
                  leading: const Icon(Icons.share_outlined),
                  onTap: () {
                    Share.share(
                        'Hey, I have Found a new awesome Music Player App Play Paattu, Check it out on Play Store https://play.google.com/store/apps/details?id=app.paattu.play');
                  },
                ),
                ListTile(
                  title: const Text("Rate us"),
                  leading: const Icon(Icons.rate_review_outlined),
                  onTap: () => openUrl("market://details?id=app.paattu.play"),
                ),
                ListTile(
                  title: const Text("More apps"),
                  leading: const Icon(Icons.apps_rounded),
                  onTap: () => openUrl("https://paattu.in/apps"),
                ),
                ListTile(
                  title: const Text("Contact us"),
                  leading: const Icon(Icons.contact_page_outlined),
                  onTap: () => openUrl("https://paattu.in/contact"),
                ),
                ListTile(
                  title: const Text("Visit Website"),
                  leading: const Icon(Icons.web_rounded),
                  onTap: () => openUrl("https://paattu.in"),
                ),
                const Divider(),
              ],
            ),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SafeArea(
                    child: Text("Version : ${snapshot.data!.version}"),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

openUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
