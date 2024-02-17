import 'package:api_lessons/search_image/pages/searchpage/search_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../settingpage/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pagelist = [
    SearchPage(),
    SettingPage(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Seaarch Image and Download"),
        ),
        body: pagelist[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: tr("home")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: tr("setting")),
            ]));
  }
}
