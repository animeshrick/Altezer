import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var passwordcontroller = TextEditingController();
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

  var emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Alterz! Sign Up',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.purple,
                      fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Text(
                "First Name:",
                style: TextStyle(
                  fontSize: 18,
                ),
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
                height: 0.02.sh,
              ),
              Text(
                "Last Name:",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: emailcontroller,
                autofocus: false,
                obscureText: true,
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
                obscureText: true,
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
                controller: emailcontroller,
                autofocus: false,
                obscureText: false,
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
                'Enter the answer of the problem: 7+3',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextFormField(
                // initialValue: '+91 5346',
                controller: emailcontroller,
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Enter your answer',
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      toggleCheckbox(value!);
                    },
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                  Text(
                    'Accept our Terms, Condition & Privacy',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 0.38.sw,
                      height: 0.065.sh,
                      child: button(() {}, 'Clear', Colors.green, white)),
                  SizedBox(
                      width: 0.38.sw,
                      height: 0.065.sh,
                      child: button(() {}, 'Sign Up', Colors.green, white)),
                ],
              ),
              SizedBox(
                height: 0.09.sh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
