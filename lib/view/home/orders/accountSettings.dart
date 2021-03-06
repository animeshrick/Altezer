import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getAddBankAccList.dart';
import 'package:altezar/models/getBankBranch.dart';
import 'package:altezar/models/getBankList.dart';
import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/getQuestions.dart';
import 'package:altezar/models/getStateList.dart';
import 'package:altezar/models/getUserInfo.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  TextEditingController emailcontroller =
      TextEditingController(text: sp.getUserEmail());
  TextEditingController firstNameController =
      TextEditingController(text: sp.getFirstName());
  TextEditingController lastNameController =
      TextEditingController(text: sp.getLastName());
  TextEditingController phoneController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confnewPasswordController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController ans1Controller = TextEditingController();
  TextEditingController ans2Controller = TextEditingController();
  TextEditingController ans3Controller = TextEditingController();
  TextEditingController accNameController = TextEditingController();
  TextEditingController accNickNameController = TextEditingController();
  TextEditingController accNumberController = TextEditingController();
  TextEditingController repetaccNumberController = TextEditingController();
  TextEditingController driverLicenseNumberController = TextEditingController();
  List<CountryList> _countryList = [];
  List<GenderList> _genderList = [];
  List<MonthDayList> _monthDayList = [];
  List<MonthNumberList> _monthNumberList = [];
  List<YearList> _yearList = [];
  List<Question> _qs1List = [];
  List<Question> _qs2List = [];
  List<Question> _qs3List = [];

  List<StateList>? _stateList = [];
  String currentPhone = '';
  String currentEmail = '';

  RxBool isShow = false.obs;
  var _addBankList = <AddBanklist>[].obs;
  var _userInfo = GetUserInfo(
      message: '',
      status: '',
      userInfo: UserInfo(
        address1: '',
        address2: '',
        city: '',
        countryId: '',
        countryName: '',
        dayName: '',
        dob: '',
        dobDay: '',
        dobMonth: '',
        dobYear: '',
        firstName: '',
        firstQuestion: '',
        firstQuestionAnswer: '',
        firstQuestionId: '',
        genderName: '',
        lastName: '',
        monthName: '',
        password: '',
        phoneNumber: '',
        postalCode: '',
        requiredResetFlag: '',
        secondQuestion: '',
        secondQuestionAnswer: '',
        secondQuestionId: '',
        sexCode: '',
        stateName: '',
        stateParishCode: '',
        thirdQuestion: '',
        thirdQuestionAnswer: '',
        thirdQuestionId: '',
        userId: '',
        userName: '',
        yearName: '',
      )).obs;
  var _bankData = <Banklist>[].obs;
  var _branchData = <Branchlist>[].obs;
  var _questions = GetQuestions(
      message: '', status: '', question1: [], question2: [], question3: []).obs;

  String? dropdownValueCountry,
      dropdownValueDate,
      dropdownValueMonth,
      dropdownValueYear,
      dropdownValueGender,
      qs1Value,
      qs2Value,
      qs3Value,
      bankValue,
      bankBranchValue,
      _stateValue,
      countryValue;

  String? countryId,
      dateId,
      monthId,
      yearId,
      genderID,
      qs1Id,
      qs2Id,
      qs3Id,
      bankID,
      branchID,
      stateId;

  final _formKey = GlobalKey<FormState>();
  var _defaultBank = 0.obs;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _getQuestions();
      _getBanks();
      _getState();
      _bankList();
      // _userInfo();
      // _userInfoUpdate();
      // _saveBank();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
        child: Obx(() {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  isShow.value
                      ? SizedBox(
                          width: 1.sw,
                          child: ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              separatorBuilder: (_, __) => SizedBox(
                                    height: 15,
                                  ),
                              itemCount: _addBankList.length,
                              itemBuilder: (_, int index) {
                                var data = _addBankList[index];
                                // print('hello');
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          data.accountInfo != null
                                              ? Text('${data.accountInfo}')
                                              : customText(
                                                  'Your bank account have some issues !',
                                                  red,
                                                  16),
                                          if (data.accountInfo != null)
                                            TextButton(
                                                onPressed: () {
                                                  addBank(data);
                                                },
                                                child: customText(
                                                    'Edit your account',
                                                    blue,
                                                    16))
                                        ],
                                      ),
                                      leading: Radio(
                                        onChanged: (val) {
                                          _defaultBank.value = val as int;
                                          print('id- ${_defaultBank.value}');
                                          setState(() {});
                                        },
                                        groupValue: _defaultBank.value,
                                        value: data.customerBankAccountId,
                                      ),
                                    ),
                                    // Text('${data.accountInfo}'),
                                  ],
                                );
                              }),
                        )
                      : customText(
                          'You Currently Do Not Have Any Bank Account On File',
                          red,
                          18,
                          fontWeight: FontWeight.bold),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      addBank(null);
                    },
                    child: Text(
                      'Add bank Account(s)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blue,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 25,
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValueCountry,
                          isExpanded: true,
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
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueCountry = newValue!;
                            });
                            countryId = _countryList
                                .where((element) =>
                                    element.countryName == dropdownValueCountry)
                                .toList()[0]
                                .countryId
                                .toString();
                            print('country id = $countryId');
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
                  ),
                  SizedBox(
                    height: 0.02.sh,
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
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValueDate,
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
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValueDate = newValue!;
                              });
                              dateId = _monthDayList
                                  .where((element) =>
                                      element.monthDay == dropdownValueDate)
                                  .toList()
                                  .first
                                  .monthDayId
                                  .toString();
                              print('dateId --$dateId');
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

                        /// -------------- month --------------
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValueMonth,
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
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValueMonth = newValue!;
                              });
                              monthId = _monthNumberList
                                  .where((element) =>
                                      element.monthNumber == dropdownValueMonth)
                                  .toList()
                                  .first
                                  .monthNumberId
                                  .toString();
                              print('month id  -- $monthId');
                            },
                            items: _monthNumberList.map((value) {
                              // print(
                              //     'value- ${value.monthNumber}\n length- ${_monthNumberList.length}');
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
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValueYear,
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
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValueYear = newValue!;
                              });
                              yearId = _yearList
                                  .where((element) =>
                                      element.year == dropdownValueYear)
                                  .toList()
                                  .first
                                  .yearId
                                  .toString();
                              print("year id == $yearId");
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValueGender,
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
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueGender = newValue!;
                            });
                            genderID = _genderList
                                .where((element) =>
                                    element.gender == dropdownValueGender)
                                .toList()
                                .first
                                .genderId
                                .toString();
                            print('gender id = $genderID');
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
                  Card(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: qs1Value,
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
                          iconSize: 24,
                          elevation: 16,
                          hint: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text('Question No 1'),
                          ),
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              qs1Value = newValue!;
                            });
                            qs1Id = _qs1List
                                .where(
                                    (element) => element.question == qs1Value)
                                .toList()
                                .first
                                .questionId
                                .toString();
                            print('qs1 id = $qs1Id');
                          },
                          items: _qs1List.map((value) {
                            return DropdownMenuItem<String>(
                              value: value.question,
                              child: Text(
                                value.question,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
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
                    controller: ans1Controller,
                    autofocus: false,
                    decoration: InputDecoration(
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
                  Card(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: qs2Value,
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
                          iconSize: 24,
                          elevation: 16,
                          hint: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text('Question No 2'),
                          ),
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              qs2Value = newValue!;
                            });
                            qs2Id = _qs2List
                                .where(
                                    (element) => element.question == qs2Value)
                                .toList()
                                .first
                                .questionId
                                .toString();
                            print('qs2 id = $qs2Id');
                          },
                          items: _qs2List.map((value) {
                            return DropdownMenuItem<String>(
                              value: value.question,
                              child: Text(
                                value.question,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
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
                    controller: ans2Controller,
                    autofocus: false,
                    decoration: InputDecoration(
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
                  Card(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: qs3Value,
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
                          iconSize: 24,
                          elevation: 16,
                          hint: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text('Question No 3'),
                          ),
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              qs3Value = newValue!;
                            });
                            qs3Id = _qs3List
                                .where(
                                    (element) => element.question == qs3Value)
                                .toList()
                                .first
                                .questionId
                                .toString();
                            print('qs3 id = $qs3Id');
                          },
                          items: _qs3List.map((value) {
                            return DropdownMenuItem<String>(
                              value: value.question,
                              child: Text(
                                value.question,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
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
                    controller: ans3Controller,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  SizedBox(
                      height: 0.07.sh,
                      width: 1.sw,
                      child: button(() {
                        if (_formKey.currentState!.validate()) {
                          if (firstNameController.text.isEmpty) {
                            showToast("Enter first name", red);
                          } else if (lastNameController.text.isEmpty) {
                            showToast("Enter last name", red);
                          } else if (emailcontroller.text.isEmpty) {
                            showToast("Enter email", red);
                          } else if (phoneController.text.isEmpty) {
                            showToast("Enter phone number", red);
                          } else if (ans1Controller.text.isEmpty) {
                            showToast("Enter answer1", red);
                          } else if (ans2Controller.text.isEmpty) {
                            showToast("Enter answer2", red);
                          } else if (ans3Controller.text.isEmpty) {
                            showToast("Enter answer3", red);
                          } else if (dropdownValueCountry == null) {
                            showToast("Enter answer3", red);
                          } else if (dropdownValueDate == null) {
                            showToast("Enter answer3", red);
                          } else if (dropdownValueMonth == null) {
                            showToast("Enter answer3", red);
                          } else if (dropdownValueYear == null) {
                            showToast("Enter answer3", red);
                          } else if (dropdownValueGender == null) {
                            showToast("Enter answer3", red);
                          } else {
                            _userInfoUpdate();
                          }
                        }
                      }, 'Update Info', greenColor, white)),
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
                  Text(
                    "Confirm New Password :",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    controller: confnewPasswordController,
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
                      child: button(() {
                        if (_formKey.currentState!.validate()) {
                          if (passwordcontroller.text.isEmpty) {
                            showToast("Enter current password", red);
                          } else if (newPasswordController.text.isEmpty) {
                            showToast("Enter new password", red);
                          } else if (confnewPasswordController.text.isEmpty) {
                            showToast("Enter confirm new password", red);
                          } else {
                            _updatePwd(
                                sp.getUserId().toString(),
                                passwordcontroller.text,
                                newPasswordController.text,
                                confnewPasswordController.text,
                                emailcontroller.text,
                                currentEmail,
                                currentPhone);
                          }
                        }
                      }, 'Update Password', greenColor, white)),
                ],
              ),
            ),
          );
        }));
  }

  void _getUserInfo() async {
    var result =
        await networkcallService.getUserInfoAPICall(sp.getUserId().toString());
    if (result != null) {
      _userInfo.value = result;
      var data = _userInfo.value.userInfo;

      ans1Controller.text = data.firstQuestionAnswer;
      ans2Controller.text = data.secondQuestionAnswer;
      ans3Controller.text = data.thirdQuestionAnswer;
      phoneController.text = data.phoneNumber;
      currentPhone = data.phoneNumber;
      currentEmail = data.userName;
/*
      print('countryName -${data.countryName}');
      print('dayName -${data.dayName}');
      print('monthName -${data.monthName}');
      print('yearName -${data.yearName}');
      print('genderName -${data.genderName}');
      print('firstQuestion -${data.firstQuestion}');
      print('secondQuestion -${data.secondQuestion}');
      print('thirdQuestion -${data.thirdQuestion}');

      print('countryId -${data.countryId}');
      print('dobDay -${data.dobDay}');
      print('dobMonth -${data.dobMonth}');
      print('dobYear -${data.dobYear}');
      print('sexCode -${data.sexCode}');
      print('firstQuestionId -${data.firstQuestionId}');
      print('secondQuestionId -${data.secondQuestionId}');
      print('thirdQuestionId -${data.thirdQuestionId}');
*/
      dropdownValueCountry = data.countryName;
      dropdownValueDate =
          data.dayName.toString(); // == '' ? '01' : data.dayName.toString();
      dropdownValueMonth = data.monthName
          .toString(); // == '' ? '01' : data.monthName.toString();
      dropdownValueYear = data.yearName;
      dropdownValueGender = data.genderName;
      qs1Value = data.firstQuestion;
      qs2Value = data.secondQuestion;
      qs3Value = data.thirdQuestion;

      countryId = data.countryId;
      dateId = data.dobDay;
      monthId = data.dobMonth;
      yearId = data.dobYear;
      genderID = data.sexCode;
      qs1Id = data.firstQuestionId;
      qs2Id = data.secondQuestionId;
      qs3Id = data.thirdQuestionId;

      setState(() {});
    }
  }

  Future _getData() async {
    // showProgress(context);
    final response = await networkcallService.getAllDropdownValue();
    // hideProgress(context);
    _countryList = response!.countryList;
    _monthDayList = response.monthDayList;
    _monthNumberList = response.monthNumberList;
    _yearList = response.yearList;
    _genderList = response.genderList;
    _getUserInfo();
    setState(() {});
  }

  void _getQuestions() async {
    _questions.value = (await networkcallService.getQuestionsAPICall())!;
    _qs1List = _questions.value.question1;
    _qs2List = _questions.value.question2;
    _qs3List = _questions.value.question3;
  }

  void _userInfoUpdate() async {
    showProgress(context);
    print(qs3Id.toString());
    print(qs2Id.toString());
    print(qs1Id.toString());
    var _updateInfo = await networkcallService.getUpdateUserInfoAPICall(
      a1: ans1Controller.text,
      a2: ans2Controller.text,
      a3: ans3Controller.text,
      country: countryId.toString(),
      currentEmail: currentEmail,
      currentPhoneNo: currentPhone,
      date: dateId.toString(),
      email: emailcontroller.text,
      fname: firstNameController.text,
      lnamae: lastNameController.text,
      month: monthId.toString(),
      phoneNo: phoneController.text,
      q1Id: qs1Id.toString(),
      q2Id: qs2Id.toString(),
      q3Id: qs3Id.toString(),
      sex: genderID.toString(),
      userId: sp.getUserId().toString(),
      year: yearId.toString(),
    );
    hideProgress(context);
    if (_updateInfo!) {
      sp.setUserEmail(emailcontroller.text);
      sp.setLastName(lastNameController.text);
      sp.setFirstName(firstNameController.text);
    }
  }

  void _updatePwd(String userId, String pwd, String newPwd, String confnewPwd,
      String email, String curEmail, String currPhone) async {
    showProgress(context);
    var _chgPwd = await networkcallService.getUpdatePasswordAPICall(
        userId: userId,
        currentPwd: pwd,
        newPwd: newPwd,
        confNewPwd: confnewPwd,
        email: email,
        currentEmail: curEmail,
        currentPhone: currPhone);
    hideProgress(context);
    if (_chgPwd!) {
      Get.back();
    }
  }

  Future _getBanks() async {
    _bankData.value = (await networkcallService.getBankListAPICall())!;
  }

  Future _getBankBranch() async {
    _branchData.value =
        (await networkcallService.getBankBranchListAPICall(bankID.toString()))!;
  }

  void _getState() async {
    _stateList = await networkcallService.getStateValue(668.toString());
    setState(() {});
  }

  void _saveBank({required String custBankId}) async {
    showProgress(context);
    var result = await networkcallService.saveBankDetailsAPICall(
        accNickNameController.text,
        accNameController.text,
        accNumberController.text,
        bankID.toString(),
        driverLicenseNumberController.text,
        stateId.toString(),
        '668',
        custBankId,
        _isDefaultAccount.value == false ? '0' : '1',
        branchID.toString(),
        sp.getUserId().toString(),
        currentEmail,
        currentPhone);
    hideProgress(context);
    if (result!) {
      Get.back();
      showProgress(context);
      await _bankList();
      hideProgress(context);
    }
  }

  // void _editBank() async {
  //   var _bankData = await networkcallService.getAddAddressAPICall(
  //       sp.getUserId().toString(), 0.toString());
  // }

  Future _bankList() async {
    showProgress(context);
    _addBankList.value = await networkcallService
        .getAddBankListAPICall(sp.getUserId().toString());
    hideProgress(context);
    if (_addBankList.length > 0) {
      _addBankList.value =
          _addBankList.where((element) => element.accountInfo != null).toList();
      isShow.value = true;
    } else {
      isShow.value = false;
    }
  }

  var _isDefaultAccount = false.obs;
  Future<void> addBank(AddBanklist? data) async {
    bankValue = null;
    bankBranchValue = null;
    _stateValue = null;
    _isDefaultAccount.value = false;
    accNameController.clear();
    accNickNameController.clear();
    accNumberController.clear();
    repetaccNumberController.clear();
    driverLicenseNumberController.clear();
    if (data != null) {
      accNameController.text = data.nameOnAccount;
      bankValue = data.bankName;
      accNickNameController.text = data.nickName;
      accNumberController.text = data.accountNumber;
      repetaccNumberController.text = data.accountNumber;
      driverLicenseNumberController.text = data.driverLicensenOrIdNumber;
      _stateValue = data.customerParish;
      stateId = _stateList!
          .where((element) => element.stateName == _stateValue)
          .toList()
          .first
          .stateId
          .toString();
      bankID = _bankData
          .where((element) => element.bankname == bankValue)
          .toList()
          .first
          .customerBankId
          .toString();
      // print('bankID = $bankID \n${data.bankBranchName}');
      await _getBankBranch();
      bankBranchValue = data.bankBranchName;
      branchID = _branchData
          .where((element) => element.branchName == bankBranchValue)
          .toList()
          .first
          .customerBankBranchId
          .toString();
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Bank Account Info'),
          content: StatefulBuilder(builder: (context, mState) {
            return Obx(() {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    accNameController.text.isEmpty
                        ? searchField(accNameController, 'Name on Account')
                        : readonlysearchField(
                            accNameController, 'Name on Account', true),
                    SizedBox(
                      height: 10,
                    ),

                    /// --------- bank ----------
                    bankValue == null && bankID == null
                        ? Card(
                            margin: EdgeInsets.zero,
                            color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: bankValue,
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
                                  hint: Text('Select your bank'),
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    mState(() {
                                      bankValue = newValue!;
                                      _branchData.clear();
                                      bankBranchValue = null;
                                    });
                                    bankID = _bankData
                                        .where((element) =>
                                            element.bankname == bankValue)
                                        .toList()
                                        .first
                                        .customerBankId
                                        .toString();
                                    print('bankID = $bankID');
                                    _getBankBranch();
                                  },
                                  items: _bankData.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.bankname,
                                      child: Text(
                                        value.bankname,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        : Card(
                            margin: EdgeInsets.zero,
                            color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: bankValue,
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
                                  hint: Text('Select your bank'),
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: null,
                                  items: _bankData.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.bankname,
                                      child: Text(
                                        value.bankname,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    searchField(accNickNameController, 'Account Nickname'),
                    SizedBox(
                      height: 10,
                    ),

                    /// ------------- branch --------------
                    bankBranchValue == null && branchID == null
                        ? Card(
                            margin: EdgeInsets.zero,
                            color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: bankBranchValue,
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
                                  hint: Text('Select branch'),
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    mState(() {
                                      bankBranchValue = newValue!;
                                    });
                                    branchID = _branchData
                                        .where((element) =>
                                            element.branchName ==
                                            bankBranchValue)
                                        .toList()
                                        .first
                                        .customerBankBranchId
                                        .toString();
                                    print('customerBankBranchId = $branchID');
                                  },
                                  items: _branchData.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.branchName,
                                      child: Text(
                                        value.branchName,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        : Card(
                            margin: EdgeInsets.zero,
                            color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: bankBranchValue,
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
                                  hint: Text('Select branch'),
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: null,
                                  items: _branchData.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.branchName,
                                      child: Text(
                                        value.branchName,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    accNumberController.text.isEmpty
                        ? searchField(accNumberController, 'Account number')
                        : readonlysearchField(
                            accNumberController, 'Account number', true),
                    SizedBox(
                      height: 10,
                    ),
                    repetaccNumberController.text.isEmpty
                        ? searchField(
                            repetaccNumberController, 'Re-enter account number')
                        : readonlysearchField(repetaccNumberController,
                            'Re-enter account number', true),
                    SizedBox(
                      height: 10,
                    ),
                    driverLicenseNumberController.text.isEmpty
                        ? searchField(driverLicenseNumberController,
                            'Driver License Number/TRN')
                        : readonlysearchField(driverLicenseNumberController,
                            'Driver License Number/TRN', true),
                    SizedBox(
                      height: 10,
                    ),

                    /// --------------------- state -----------
                    Card(
                      margin: EdgeInsets.zero,
                      color: Colors.grey[300],
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            validator: (value) =>
                                value == null ? 'Enter your State' : null,
                            value: _stateValue,
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
                            hint: Text('Choose your Reside State'),
                            iconSize: 24,
                            elevation: 16,
                            isExpanded: true,
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
                              print('styate id --- $stateId');
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
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    /// ------------ country 668 -------------
                    Card(
                      margin: EdgeInsets.zero,
                      color: Colors.grey[300],
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: countryValue,
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
                            hint: Text('Jamaica'),
                            iconSize: 24,
                            elevation: 16,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.black),
                            onChanged: null,
                            /* (String? newValue) {
                              setState(() {
                                bankBranchValue = newValue!;
                              });
                              bankBranchValue = _branchData
                                  .where((element) =>
                                      element.branchName == bankBranchValue)
                                  .toList()
                                  .first
                                  .customerBankBranchId
                                  .toString();
                              print('customerBankBranchId = $bankBranchValue');
                            }, */
                            items: _branchData.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.branchName,
                                child: Text(
                                  value.branchName,
                                  style: TextStyle(fontSize: 18),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _isDefaultAccount.value,
                            onChanged: (val) {
                              _isDefaultAccount.value = val!;
                            }),
                        customText('Set as Primary Account', black, 16)
                      ],
                    ),
                  ],
                ),
              );
            });
          }),
          actions: <Widget>[
            TextButton(
              child: const Text('Save and Close'),
              onPressed: () {
                /*if (data == null) {
                  print('null ?');
                  print('data $data');
                  _saveBank(custBankId: '0');
                } else */
                // print('else ${data!.customerBankAccountId.toString()}');
                if (accNumberController.text != repetaccNumberController.text) {
                  showToast('The bank account numbers not matched', red);
                } else if (branchID == null) {
                  showToast('Select a bank branch', red);
                } else if (bankID == null) {
                  showToast('Select a bank', red);
                } else if (stateId == null) {
                  showToast('Select a state', red);
                } else {
                  // print('else ${data.customerBankAccountId.toString()}');
                  _saveBank(
                      custBankId: data == null
                          ? '0'
                          : data.customerBankAccountId.toString());
                }
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
