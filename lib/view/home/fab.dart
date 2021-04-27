import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Fab extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              height: 0.2.sh,
              color: Color(0xff76B51B),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText('Send Message', white, 18.0),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close, color: white))
                    ],
                  ),
                  customText(
                      'Please fill out the form below and we will get back to you as soon as possible.',
                      white,
                      18.0)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
              decoration: myBoxDecoration(),
              child: Column(
                children: [
                  searchField(nameController, '* Name'),
                  SizedBox(
                    height: 5,
                  ),
                  searchField(emailController, '* Email'),
                  SizedBox(
                    height: 5,
                  ),
                  // searchField(messageController, '* Message'),
                  TextFormField(
                    controller: messageController,
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(5.0, 70.0, 5.0, 10.0),
                      hintText: "* Message",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 1.sw,
                      height: 0.07.sh,
                      child: button(() {}, 'Submit', Color(0xff76B51B))),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('We are ⚡ by tawk.to'),
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }
}
