import 'dart:math';

import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/getStateList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'intro.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
  String? stateId, countryId, dateId, monthId, yearId, genderID;

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
        padding: const EdgeInsets.only(right: 30, left: 30, top: 35),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                        keyboardType: TextInputType.emailAddress,

                        controller: emailController,
                        autofocus: false,
                        // obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email ";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) return 'Invalid email';
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
                        keyboardType: TextInputType.number,
                        controller: mobileController,
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            validator: (value) =>
                                value == null ? 'Enter your Country' : null,
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
                              countryId = _countryList
                                  .where((element) =>
                                      element.countryName == _countryValue)
                                  .toList()[0]
                                  .countryId
                                  .toString();
                              print('countryId $countryId');
                              _stateValue = null;
                              _getState(countryId!);
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            validator: (value) =>
                                value == null ? 'Enter your State' : null,
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
                              stateId = _stateList!
                                  .where((element) =>
                                      element.stateName == _stateValue)
                                  .toList()
                                  .first
                                  .stateId
                                  .toString();
                              print('stateId $stateId');
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            validator: (value) => value == null
                                ? 'Enter your Date of birth'
                                : null,
                            // isExpanded: true,
                            hint: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text('Date'),
                            ),
                            value: _monthDayValue,
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
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                _monthDayValue = newValue!;
                              });
                              dateId = _monthDayList
                                  .where((element) =>
                                      element.monthDay == _monthDayValue)
                                  .toList()
                                  .first
                                  .monthDayId
                                  .toString();
                                  print('dateId $dateId');
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
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Card(
                        color: Colors.grey[300],
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            validator: (value) => value == null
                                ? 'Enter your month of birth'
                                : null,
                            // isExpanded: true,
                            value: _monthNumberValue,
                            hint: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text('Month'),
                            ),
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
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                _monthNumberValue = newValue!;
                              });
                              monthId = _monthNumberList
                                  .where((element) =>
                                      element.monthNumber == _monthNumberValue)
                                  .toList()
                                  .first
                                  .monthNumberId
                                  .toString();
                                  print('monthId $monthId');
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
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Card(
                        color: Colors.grey[300],
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            validator: (value) => value == null
                                ? 'Enter your year of birth'
                                : null,
                            // isExpanded: true,
                            value: _yearValue,
                            hint: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text('Year'),
                            ),
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
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                _yearValue = newValue!;
                              });
                              yearId = _yearList
                                  .where(
                                      (element) => element.year == _yearValue)
                                  .toList()
                                  .first
                                  .yearId
                                  .toString();
                                  print('yearId $yearId');
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            // isExpanded: true,
                            validator: (value) =>
                                value == null ? 'Enter your Gender' : null,
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
                              genderID = _genderList
                                  .where((element) =>
                                      element.gender == _genderValue)
                                  .toList()
                                  .first
                                  .genderId
                                  .toString();
                                  print('genderID $genderID');
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
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),

                      // ------------ qa ----------------
                      Text(
                        'Enter the answer of the question: $random1+$random2',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Enter your answer',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your answer  ";
                          } else if ((random1! + random2!) != int.parse(value))
                            return 'Incorrect answer';
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
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  Flexible(
                    child: Text(
                      'Accept our Terms,Condition & Privacy',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
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
                      }, 'Clear', green, white)),
                  SizedBox(
                      width: 0.38.sw,
                      height: 0.065.sh,
                      child: button(() {
                        if (_formKey.currentState!.validate()) {
                          if (_countryValue == null)
                            showToast('Please select Country', red);
                          else if (_stateValue == null)
                            showToast('Please select State', red);
                          else if (_monthDayValue == null ||
                              _monthNumberValue == null ||
                              _yearValue == null)
                            showToast('Please select DOB', red);
                          else if (_genderValue == null)
                            showToast('Please select Gender', red);
                          else if (!isChecked)
                            showToast(
                                'Please accept terms and conditions', red);
                          else {
                            _newUserRegistration(
                              firstNameController.text,
                              lastNameController.text,
                              mobileController.text,
                              emailController.text,
                              countryId!,
                              stateId!,
                              dateId!,
                              monthId!,
                              yearId!,
                              genderID!,
                              /* '669',
                            '23',
                            '1024',
                            '1050',
                            '1090',
                            '1106',*/
                            );
                          }
                        }
                      }, 'Sign Up', green, white)),
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

  void _newUserRegistration(
      String firstName,
      String lastName,
      String phone,
      String email,
      String country,
      String state,
      String day,
      String month,
      String year,
      String gender) async {
    // print('call');
    try {
      setState(() {
        isLoading = true;
      });
      String result = await networkcallService.registerUser(
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          genderId: gender,
          countryId: country,
          stateId: state,
          dayId: day,
          monthId: month,
          yearId: year);
      setState(() {
        isLoading = false;
      });
      if (result.isNotEmpty) {
        // showToast("Registation Done !", greenColor);
        // Get.offAll(Intro());
        _showMyDialog(result);
      }
    } catch (e) {
      isLoading = false;
      print(e);
      setState(() {});
      showToast(e, red);
    }
  }

  void _showMyDialog(String result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: customText('Registation done successfully !', green, 18.0),
          content: Container(
            height: 0.4.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                ),
                customText(result, black, 20.0),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Get.offAll(Intro(
                  isChecked: false,
                ));
              },
            ),
          ],
        );
      },
    );
  }

  void _getData() async {
    // showProgress(context);
    final response = await networkcallService.getAllDropdownValue();
    // hideProgress(context);
    _countryList = response!.countryList;
    _monthDayList = response.monthDayList;
    _monthNumberList = response.monthNumberList;
    _yearList = response.yearList;
    _genderList = response.genderList;
    setState(() {});
  }

  void _getState(String id) async {
    showProgress(context);
    _stateList = await networkcallService.getStateValue(id);
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
