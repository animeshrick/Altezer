import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotEmail extends StatefulWidget {
  @override
  _ForgotEmailState createState() => _ForgotEmailState();
}

class _ForgotEmailState extends State<ForgotEmail> {
  var emailcontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
                controller: emailcontroller,
                autofocus: false,
                obscureText: true,
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
                controller: emailcontroller,
                autofocus: false,
                obscureText: true,
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
                controller: emailcontroller,
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              SizedBox(
                width: 1.sw,
                height: 0.07.sh,
                child: button(() {}, "Retrive Email Address", green),
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
    );
  }
}
