import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future saveData({required String key, required String value}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    shp.setString(key, value);
  }

  static Future<String?> getData({required String key}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    return shp.getString(key);
  }
}
