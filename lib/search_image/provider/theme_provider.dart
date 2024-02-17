import 'package:api_lessons/search_image/shp/shp.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode tm = ThemeMode.system;

  checkTheme() {
    SharedPref.getData(key: "theme").then((value) {
      if (value != null) {
        if (value == "system") {
          tm = ThemeMode.system;
        } else if (value == "dark") {
          tm = ThemeMode.dark;
        } else if (value == "light") {
          tm = ThemeMode.light;
        }

        notifyListeners();
      }
    });
  }

  changeToSystem() {
    tm = ThemeMode.system;
    notifyListeners();
    SharedPref.saveData(key: "theme", value: "system");
  }

  changeToDark() {
    tm = ThemeMode.dark;
    notifyListeners();
    SharedPref.saveData(key: "theme", value: "dark");
  }

  changeToLight() {
    tm = ThemeMode.light;
    notifyListeners();
    SharedPref.saveData(key: "theme", value: "light");
  }
}
