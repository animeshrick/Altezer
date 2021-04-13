
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceInstance {
  static SharedPreferences? prefs;

  static final SharePreferenceInstance networkcall =
      new SharePreferenceInstance._internal();

  SharePreferenceInstance._internal();

  factory SharePreferenceInstance() {
    return networkcall;
  }

  //shared pref initialize
  init() async {
    SharedPreferences.getInstance()
        .then((value) => prefs = value)
        .catchError((e) {
      print("Got error: ${e.error}"); // Finally, callback fires.
      // Future completes with 42.
    });
  }

  void clear() {
    prefs?.clear();
  }

  //keys
  final isLoginKey = 'isLogin';
  final userToken = 'user_token';

  //isLogin
  void setIsLogin(value) => prefs?.setBool(isLoginKey, value);
  bool? isLogin() => prefs?.getBool(isLoginKey);

  //token
  void setToken(token) => prefs?.setString(userToken, token);
  String? getToken() => prefs?.getString(userToken);

  void saveUserDetails(jsonResponce) {
    setToken(jsonResponce['data']['api_token']);
    setIsLogin(true);
  }
}

SharePreferenceInstance sharePrefereceInstance = SharePreferenceInstance();
