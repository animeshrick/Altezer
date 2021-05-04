import 'package:altezar/api/apiCall.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'intro.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var emailController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 35),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                altezerLogoImage,
                fit: BoxFit.fill,
                height: 0.05.sh,
                width: 0.1.sw,
              ),
              SizedBox(height: 0.15.sh),
              Image.asset(
                logoImage,
                fit: BoxFit.fill,
                height: 0.1.sh,
                width: 1.sw,
              ),
              Center(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 25, color: grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Enter Email:",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Email',
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
                  _forgotPassword(emailController.text);
                }, "Email Temp Password", green, white),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text('Back to login',
                        style: TextStyle(color: Colors.blue, fontSize: 20))),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 30),
                    children: <TextSpan>[
                      TextSpan(text: 'Still having issues? Email is at '),
                      TextSpan(
                          text: 'support@citsja.com',
                          style: TextStyle(color: Colors.blue))
                    ],
                  ),
                  textScaleFactor: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _forgotPassword(String? email) async {
    try {
      setState(() {
        isLoading = true;
      });

      showProgress(context);
      var result = await networkcallService.forgotPasswordAPICall(email: email);
      hideProgress(context);

      if (result != null) {
        var message = result['message'];
        var password = result['data']['Password'];
        _showForgotPassDialogue(message, password);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void _showForgotPassDialogue(String message, String data) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: customText('Email Temporary Password !', green, 18.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(message, Colors.black, 20),
              SizedBox(
                height: 15,
              ),
              customText(
                  'Your temporary password is - $data', Colors.black, 20),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Get.to(Intro(isChecked: false));
              },
            ),
          ],
        );
      },
    );
  }
}
