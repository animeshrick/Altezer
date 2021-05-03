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
    prefs = await SharedPreferences.getInstance();
  }

  void clear() {
    prefs?.clear();
  }

  //keys
  final isLoginKey = 'isLogin';
  final firstNameUser = 'YJUserFirstname';
  final lastNameUser = 'YJUserLastname';
  final emailUser = 'YJUserEmail';
  final userId = 'YJUserId';

  //isLogin
  void setIsLogin(value) => prefs?.setBool(isLoginKey, value);
  bool? isLogin() => prefs?.getBool(isLoginKey) ?? false;

  //isLogin
  void setFirstName(value) => prefs?.setString(firstNameUser, value);
  String? getFirstName() => prefs?.getString(firstNameUser);

  //isLogin
  void setLastName(value) => prefs?.setString(lastNameUser, value);
  String? getLastName() => prefs?.getString(lastNameUser);

  //isLogin
  void setUserEmail(value) => prefs?.setString(emailUser, value);
  String? getUserEmail() => prefs?.getString(emailUser);

  //isLogin
  void setUserId(value) => prefs?.setInt(userId, value);
  int? getUserId() => prefs?.getInt(userId);

  void saveUserDetails(userData) {
    print('sp userdata - $userData');

    setFirstName(userData['YJUserFirstname']);
    setLastName(userData['YJUserLastname']);
    setUserEmail(userData['YJUserEmail']);
    setUserId(userData['YJUserId']);
    setIsLogin(true);
  }
}

SharePreferenceInstance sp = SharePreferenceInstance();
