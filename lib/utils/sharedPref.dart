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
  final firstNameUser = 'FirstName';
  final lastNameUser = 'Lastname';
  final emailUser = 'Email';
  final phoneUser = 'PhoneNumber';

  //isLogin
  void setIsLogin(value) => prefs?.setBool(isLoginKey, value);
  bool? isLogin() => prefs?.getBool(isLoginKey);

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
  void setUserPhone(value) => prefs?.setString(phoneUser, value);
  String? getUserPhone() => prefs?.getString(phoneUser);

  void saveUserDetails(jsonResponse) {
    setFirstName(jsonResponse);
    setLastName(jsonResponse);
    setUserEmail(jsonResponse);
    setUserPhone(jsonResponse);
    setIsLogin(true);
  }
}

SharePreferenceInstance sharePrefereceInstance = SharePreferenceInstance();
