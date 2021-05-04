import 'package:altezar/api/apiCall.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/auths/signUp.dart';
import 'package:altezar/view/home/home.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'forgotEmail.dart';
import 'forgotPassword.dart';

class Intro extends StatefulWidget {
  final bool isChecked;

  const Intro({Key? key, required this.isChecked}) : super(key: key);
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool isHidden = true;
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController newpasswordcontroller = TextEditingController();
  TextEditingController confpasswordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    confpasswordcontroller = TextEditingController(text: "");
    // passwordcontroller = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, top: 35),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  altezerLogoImage,
                  fit: BoxFit.fill,
                  height: 0.05.sh,
                  width: 0.1.sw,
                ),
                SizedBox(height: 0.07.sh),
                Image.asset(
                  logoImage,
                  fit: BoxFit.fill,
                  height: 0.1.sh,
                  width: 1.sw,
                ),
                Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 25, color: grey),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Valid email ";
                    } else if (value.trim().isEmpty) {
                      return "Enter Valid email";
                    }
                  },
                  controller: emailcontroller,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Password:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: passwordcontroller,
                  autofocus: false,
                  obscureText: isHidden,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Valid password ";
                    } else if (value.trim().isEmpty) {
                      return "Enter Valid password";
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                        child: Icon(isHidden
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: 1.sw,
                  height: 0.07.sh,
                  child: button(() {
                    if (_formKey.currentState!.validate()) {
                      _userLogin(
                          emailcontroller.text.toString(),
                          passwordcontroller.text.toString(),
                          confpasswordcontroller.text.toString(),
                          widget.isChecked);
                    }
                  }, "Sign In", Colors.blueAccent, white),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(SignUp());
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 38),
                        children: <TextSpan>[
                          TextSpan(text: 'Or, '),
                          TextSpan(
                              text: 'Sign Up Now',
                              style: TextStyle(color: Colors.blue))
                        ],
                      ),
                      textScaleFactor: 0.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(ForgotPassword());
                      },
                      child: Text('Forgot password',
                          style: TextStyle(color: Colors.blue, fontSize: 18)),
                    ),
                    SizedBox(
                      child: customText('|', black, 16,
                          fontWeight: FontWeight.bold),
                      width: 5,
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Get.to(ForgotEmail());
                        },
                        child: Text('Forgot email',
                            style: TextStyle(color: Colors.blue, fontSize: 18)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _userLogin(String? email, String? password, String? confPassword,
      bool? isChecked) async {
    try {
      setState(() {
        isLoading = true;
      });

      showProgress(context);
      var result = await networkcallService.loginAPICall(
          email: email,
          password: password,
          isChecked: isChecked,
          confirmPassword: confPassword);
      hideProgress(context);

      setState(() {
        isLoading = false;
      });
      // print('res- $result');
      if (result['data'] != null) {
        var checked = result['data']['IsChecked'];
        // print('c- $checked');
        if (checked != null) {
          _showLoginDialog();
        } else {
          showToast("Login Successfully", greenColor);
          Get.offAll(Home());
        }
      } else
        showToast(result['message'], red);
    } catch (e) {
      // isLoading = false;
      print(e.toString());
      // setState(() {});
      // showToast(e, red);
    }
  }

  void _showLoginDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: customText('Registation done successfully !', green, 18.0),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Password:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: newpasswordcontroller,
                  autofocus: false,
                  obscureText: isHidden,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password ";
                    } else if (value.trim().isEmpty) {
                      return "Enter password";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Confirm Password:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: confpasswordcontroller,
                  autofocus: false,
                  obscureText: isHidden,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password ";
                    } else if (value.trim().isEmpty) {
                      return "Enter password";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                if (newpasswordcontroller.text.isEmpty ||
                    confpasswordcontroller.text.isEmpty) {
                  showToast('Enter Password', red);
                } else if (newpasswordcontroller.text !=
                    confpasswordcontroller.text) {
                  showToast('Password mismatch', red);
                } else {
                  _userLogin(
                      emailcontroller.text.toString(),
                      newpasswordcontroller.text.toString(),
                      confpasswordcontroller.text.toString(),
                      true);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
