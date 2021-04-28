import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  String dropdownValue = 'One';
  bool isChecked = false;

  var resultHolder = 'Checkbox is UN-CHECKED';

  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      // Put your code here which you want to execute on CheckBox Checked event.
      setState(() {
        isChecked = true;
        resultHolder = 'Checkbox is CHECKED';
      });
    } else {
      // Put your code here which you want to execute on CheckBox Un-Checked event.
      setState(() {
        isChecked = false;
        resultHolder = 'Checkbox is UN-CHECKED';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText('Your Bank Account(s) Details', greenColor, 25.0),
            SizedBox(
              height: 15,
            ),
            customText(
                'We will transfer the money from the sale of your items to your bank account',
                black,
                18.0),
            SizedBox(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                // text: 'Hello ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'You Currently Do Not Have Any Bank Account On File',
                      style: TextStyle(color: priceTextColor, fontSize: 18)),
                  TextSpan(
                      text: ' Add bank Account(s)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: buttonColor,
                          fontSize: 18)),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            customText('Your Information', greenColor, 18.0),
            SizedBox(
              height: 15,
            ),
            Text(
              "First Name:",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: firstNameController,
              autofocus: false,
              // obscureText: true,
              decoration: InputDecoration(
                hintText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              "Last Name:",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: lastNameController,
              autofocus: false,
              // obscureText: true,
              decoration: InputDecoration(
                hintText: 'Last Name:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 0.02.sh,
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
              // obscureText: true,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              "Phone Number:",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              // initialValue: '+91 5346',
              controller: phoneController,
              autofocus: false,
              // obscureText: false,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            // ----------------------- country -----------------------
            Text(
              'Country',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Card(
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Country - ',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: CircleAvatar(
                        backgroundColor: grey,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: white,
                        )),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    // underline: Container(
                    //   height: 2,
                    //   color: Colors.deepPurpleAccent,
                    // ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            // ----------------------- State -----------------------
            Text(
              'State',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Card(
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'State - ',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: CircleAvatar(
                        backgroundColor: grey,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: white,
                        )),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    // underline: Container(
                    //   height: 2,
                    //   color: Colors.deepPurpleAccent,
                    // ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            // ----------------------- dOB -----------------------
            Text(
              'DOB',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Card(
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: CircleAvatar(
                        backgroundColor: grey,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: white,
                        )),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    // underline: Container(
                    //   height: 2,
                    //   color: Colors.deepPurpleAccent,
                    // ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: CircleAvatar(
                        backgroundColor: grey,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: white,
                        )),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    // underline: Container(
                    //   height: 2,
                    //   color: Colors.deepPurpleAccent,
                    // ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: CircleAvatar(
                        backgroundColor: grey,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: white,
                        )),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    // underline: Container(
                    //   height: 2,
                    //   color: Colors.deepPurpleAccent,
                    // ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            // ----------------------- Gender -----------------------
            Text(
              'Gender',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Card(
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Gender - ',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: CircleAvatar(
                        backgroundColor: grey,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: white,
                        )),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    // underline: Container(
                    //   height: 2,
                    //   color: Colors.deepPurpleAccent,
                    // ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),

            // ------------ qa ----------------
            Text(
              'Question 1 :',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            dropDownWidget('Question 1'),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              "Answer :",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              // controller: passwordcontroller,
              autofocus: false,

              decoration: InputDecoration(
                hintText: 'Answer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              'Question 2 :',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            dropDownWidget('Question 2'),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              "Answer :",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              // controller: passwordcontroller,
              autofocus: false,

              decoration: InputDecoration(
                hintText: 'Answer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              'Question 3 :',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            dropDownWidget('Question 3'),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              "Answer :",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              // controller: passwordcontroller,
              autofocus: false,

              decoration: InputDecoration(
                hintText: 'Answer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            SizedBox(
                height: 0.07.sh,
                width: 1.sw,
                child: button(() {}, 'Update Info', greenColor, white)),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              "Current Password :",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: passwordcontroller,
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '* * * * * *',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              "New Password :",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              controller: newPasswordController,
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '* * * * * *',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            SizedBox(
                height: 0.07.sh,
                width: 1.sw,
                child: button(() {}, 'Update Password', greenColor, white)),
          ],
        ),
      ),
    );
  }
}
