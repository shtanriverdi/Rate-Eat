import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveToken(String token) async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    await preference.setString("token", token);
  }

  static Future<bool> hasToken() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    var value = preference.getString("token");

    return value != null;
  }

  static Future<void> deleteAll() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    await preference.clear();
  }

  static Future<void> deleteUser() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    await preference.remove("token");
    await preference.remove("id");
  }

  static Future<String?> getToken() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    final String? token = preference.getString("token");
    return token;
  }

  static Future<void> saveId(String id) async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    await preference.setString("id", id);
  }

  static Future<String?> getId() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    final String? id = preference.getString("id");
    return id;
  }
  
  static Future<void> saveAppState(bool opened) async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    await preference.setBool("showHome", opened);
  }

  static Future<bool> hasOpend() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    var value = preference.getBool("showHome");

    if (value != null) {
      return value;
    } else {
      return false;
    }
  }
}
