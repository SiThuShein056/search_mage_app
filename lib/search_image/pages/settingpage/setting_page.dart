import 'package:api_lessons/search_image/pages/downloadedImage/downloaded_image_page.dart';
import 'package:api_lessons/search_image/provider/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../language_page/language_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Consumer<ThemeProvider>(builder: (context, ThemeProvider tp, child) {
          return ListTile(
            onTap: () {},
            title: Text(tr("night_mode")),
            leading: Icon(Icons.dark_mode),
            trailing: Consumer<ThemeProvider>(
                builder: (context, ThemeProvider tp, child) {
              return Switch(
                  value: tp.tm == ThemeMode.dark,
                  onChanged: (isOn) {
                    if (isOn) {
                      tp.changeToDark();
                    } else {
                      tp.changeToLight();
                    }
                  });
            }),
          );
        }),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DownloadedImage();
            }));
          },
          title: Text(tr("download_image")),
          leading: Icon(Icons.download),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LanguagePage();
            })).then((value) {
              setState(() {});
            });
          },
          title: Text(tr("lang")),
          leading: Icon(Icons.language),
        )
      ],
    );
  }
}
