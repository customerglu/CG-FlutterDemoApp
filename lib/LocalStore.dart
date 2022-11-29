import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  final String nudge_url = "nudge_url";
  final String user_id = "user_id";

  Future<bool> setAppSharePopUp(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SET _appSharePopUp");
    print(value);
    return (prefs.setString(nudge_url, value));
  }

  Future<String> getAppSharePopUp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SET _appSharePopUp");
    var value = prefs.getString(nudge_url) ?? '';
    print(value);
    return value;
  }

  Future<bool> setuserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SET _appSharePopUp");
    print(value);
    return (prefs.setString(user_id, value));
  }

  Future<bool> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SET _appSharePopUp");
    var value = prefs.getString(user_id) ?? '';
    if (value.isEmpty) {
      return false;
    }
    print(value);
    return true;
  }
}
