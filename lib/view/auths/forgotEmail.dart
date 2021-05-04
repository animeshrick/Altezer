import 'package:altezar/api/apiCall.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'intro.dart';

class ForgotEmail extends StatefulWidget {
  @override
  _ForgotEmailState createState() => _ForgotEmailState();
}

class _ForgotEmailState extends State<ForgotEmail> {
  var phoneController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 35),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  altezerLogoImage,
                  fit: BoxFit.fill,
                  height: 0.03.sh,
                  width: 0.1.sw,
                ),
                SizedBox(height: 0.08.sh),
                Image.asset(
                  logoImage,
                  fit: BoxFit.fill,
                  height: 0.1.sh,
                  width: 1.sw,
                ),
                Center(
                  child: Text(
                    "Forgot Email",
                    style: TextStyle(fontSize: 25, color: grey),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter First Name:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: firstNameController,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter Last Name:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: lastNameController,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter Phone Name:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  maxLength: 10,
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Phone Number  ";
                    } else if (value.trim().isEmpty) {
                      return "Enter Phone Number  ";
                    }
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: 1.sw,
                  height: 0.07.sh,
                  child: button(() {
                    if (_formKey.currentState!.validate()) {
                      _forgotEmail(firstNameController.text,
                          lastNameController.text, phoneController.text);
                    }
                  }, "Retrive Email Address", green, white),
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
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _forgotEmail(String? fname, String? lname, String? phnumber) async {
    try {
      setState(() {
        isLoading = true;
      });

      showProgress(context);
      var result = await networkcallService.forgotEmailAPICall(
          firstName: fname, lastName: lname, phoneNumber: phnumber);
      hideProgress(context);

      setState(() {
        isLoading = false;
      });
      if (result != null) {
        var message = result['message'];
        _shoewEmailDialogue(message);
      }
    } catch (e) {
      // isLoading = false;
      print(e.toString());
      // setState(() {});
      // showToast(e, red);
    }
  }

  void _shoewEmailDialogue(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: customText('Retrive Email Address !', green, 18.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(text, Colors.black, 20),
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
