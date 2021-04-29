import 'dart:math';

import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/getStateList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String? _countryValue,
      _genderValue,
      _monthDayValue,
      _monthNumberValue,
      _yearValue,
      _stateValue;

  bool isChecked = false;

  var resultHolder = 'Checkbox is UN-CHECKED';

  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      setState(() {
        isChecked = true;
        resultHolder = 'Checkbox is CHECKED';
      });
    } else {
      setState(() {
        isChecked = false;
        resultHolder = 'Checkbox is UN-CHECKED';
      });
    }
  }

  List<CountryList> _countryList = [];
  List<GenderList> _genderList = [];
  List<MonthDayList> _monthDayList = [];
  List<MonthNumberList> _monthNumberList = [];
  List<YearList> _yearList = [];
  List<StateList>? _stateList = [];
  int? random1, random2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    random1 = Random().nextInt(10);
    random2 = Random().nextInt(10);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, top: 35),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                        controller: firstNameController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter First Name  ";
                          } else if (value.trim().isEmpty) {
                            return "Enter First Name  ";
                          }
                        },
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Last Name  ";
                          } else if (value.trim().isEmpty) {
                            return "Enter Last Name  ";
                          }
                        },
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
                        controller: emailController,
                        autofocus: false,
                        // obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email  ";
                          } else if (value.trim().isEmpty) {
                            return "Enter Email  ";
                          }
                        },
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
                        controller: mobileController,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
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
                        child: DropdownButton<String>(
                          value: _countryValue,
                          hint: Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text('Choose your Country-'),
                          ),
                          isExpanded: true,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                                radius: 15,
                                backgroundColor: grey,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: white,
                                )),
                          ),
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              _countryValue = newValue!;
                            });
                            var id = _countryList
                                .where((element) =>
                                    element.countryName == _countryValue)
                                .toList()[0]
                                .countryId;
                            _stateValue = null;
                            _getState(id);
                          },
                          items: _countryList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value.countryName,
                              child: Text(
                                value.countryName,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
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
                        child: DropdownButton<String>(
                          value: _stateValue,
                          isExpanded: true,
                          hint: Padding(
                            padding: EdgeInsets.only(
                              left: 15.0,
                            ),
                            child: Text('Choose your State'),
                          ),
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                                radius: 15,
                                backgroundColor: grey,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: white,
                                )),
                          ),
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              _stateValue = newValue!;
                            });
                          },
                          items: _stateList!
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value.stateName,
                              child: Text(
                                value.stateName,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
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
                              // isExpanded: true,
                              hint: Text('Date'),
                              value: _monthDayValue,
                              icon: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: grey,
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: white,
                                    )),
                              ),
                              style: const TextStyle(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _monthDayValue = newValue!;
                                });
                              },
                              items: _monthDayList.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.monthDay,
                                  child: Text(
                                    value.monthDay,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              }).toList(),
                            ),
                            DropdownButton<String>(
                              // isExpanded: true,
                              value: _monthNumberValue,
                              hint: Text('Month'),
                              icon: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: grey,
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: white,
                                    )),
                              ),
                              style: const TextStyle(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _monthNumberValue = newValue!;
                                });
                              },
                              items: _monthNumberList.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.monthNumber,
                                  child: Text(
                                    value.monthNumber,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              }).toList(),
                            ),
                            DropdownButton<String>(
                              // isExpanded: true,
                              value: _yearValue,
                              hint: Text('Year'),
                              icon: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: grey,
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: white,
                                    )),
                              ),
                              style: const TextStyle(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _yearValue = newValue!;
                                });
                              },
                              items: _yearList.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.year,
                                  child: Text(
                                    value.year,
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
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text('Pick your Gender'),
                          ),
                          value: _genderValue,
                          icon: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                                radius: 15,
                                backgroundColor: grey,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: white,
                                )),
                          ),
                          iconSize: 15,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              _genderValue = newValue!;
                            });
                          },
                          items: _genderList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value.gender,
                              child: Text(
                                value.gender,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),

                      // ------------ qa ----------------
                      Text(
                        'Enter the answer of the problem: $random1+$random2',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Enter your answer',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your answer  ";
                          } else if (value.trim().isEmpty) {
                            return "Enter your answer  ";
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
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
                    activeColor: greenColor,
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
                      child: button(() {
                        clear();
                      }, 'Clear', Colors.green, white)),
                  SizedBox(
                      width: 0.38.sw,
                      height: 0.065.sh,
                      child: button(() {
                        if (_formKey.currentState!.validate()) {
                          if (_countryValue == null)
                            showToast('Please select Country', red);
                          else if (_stateValue == null)
                            showToast('Please select State', red);
                          else if (_monthDayValue == null &&
                              _monthNumberValue == null &&
                              _yearValue == null)
                            showToast('Please select DOB', red);
                          else if (_genderValue == null)
                            showToast('Please select Gender', red);
                        }
                      }, 'Sign Up', Colors.green, white)),
                ],
              ),
              SizedBox(
                height: 0.02.sh,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getData() async {
    showProgress(context);
    final response = await networkcallService.getAllDropdownValue();
    hideProgress(context);
    _countryList = response!.countryList;
    _monthDayList = response.monthDayList;
    _monthNumberList = response.monthNumberList;
    _yearList = response.yearList;
    _genderList = response.genderList;
    setState(() {});
  }

  void _getState(int id) async {
    showProgress(context);
    _stateList = await networkcallService.getStateValue(id.toString());
    hideProgress(context);
    setState(() {});
  }

  void clear() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
    passwordController.clear();
    _countryValue = null;
    // _countryList.clear();
    _stateValue = null;
    // _stateList!.clear();
    _monthDayValue = null;
    // _monthDayList.clear();
    _monthNumberValue = null;
    // _monthNumberList.clear();
    _yearValue = null;
    // _yearList.clear();
    _genderValue = null;
    // _genderList.clear();
    setState(() {});
  }
}
