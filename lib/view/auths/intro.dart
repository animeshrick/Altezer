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
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final formKey = GlobalKey<FormState>();
  bool isHidden = true;
  var passwordcontroller = TextEditingController();
  var emailcontroller = TextEditingController();

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
                controller: emailcontroller,
                autofocus: false,
                obscureText: true,
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
                      child: Icon(
                          isHidden ? Icons.visibility_off : Icons.visibility)),
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
                  print('f');
                  Get.to(Home());
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
                    child: Text('Forgot your password',
                        style: TextStyle(color: Colors.blue, fontSize: 18)),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(ForgotEmail());
                    },
                    child: Text('Forgot your email',
                        style: TextStyle(color: Colors.blue, fontSize: 18)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
