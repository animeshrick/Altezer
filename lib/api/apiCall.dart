import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:altezar/models/getCategories.dart';
import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/getStateList.dart';
import 'package:altezar/models/getSubCatList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';

import 'MyClient.dart';

class Networkcall {
  static final Networkcall networkcall = new Networkcall._internal();

  Networkcall._internal();

  factory Networkcall() {
    return networkcall;
  }

  /// --------------------- getall dropdown values -----------------------
  Future<GetLists?> getAllDropdownValue() async {
    print('getAllDropdownValue $getallDropdownlist');
    try {
      final response = await MyClient().get(Uri.parse(getallDropdownlist));
      print(response);
      if (response.statusCode == 200) {
        final myResponse = GetLists.fromJson(jsonDecode(response.body));
        print(response.body);
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast('myResponse.message --- failed', red);
        }
      } else {
        print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------- state values -----------------------
  Future<List<StateList>?> getStateValue(String countryId) async {
    print('getStateValue $stateList');
    try {
      Map<String, dynamic> data = {'countryId': countryId.toString()};
      final response = await MyClient().post(Uri.parse(stateList), body: data);
      print(response);
      if (response.statusCode == 200) {
        // final myjson = jsonDecode(response.body);
        final myResponse = GetStateList.fromJson(jsonDecode(response.body));
        print(response.body);
        if (myResponse.status == success) {
          return myResponse.stateList;
        } else {
          showToast('myResponse.message --- failed', red);
        }
      } else {
        print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// -------------- get categories ----------------
  Future<List<CategoriesList>?> getCategoriesAPICall() async {
    print('get categories --  $getCategories');
    try {
      final response = await MyClient().get(Uri.parse(getCategories));
      if (response.statusCode == 200) {
        print("response.body get categories ${response.body}");
        final myResponse = GetCategories.fromJson(jsonDecode(response.body));
        if (myResponse.status == success) {
          return myResponse.catList;
        } else {
          showToast('myResponse.message --- failed', red);
        }
      } else {
        print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------- get sub cat  -----------------------
  Future<List<GetSubCateProductsList>?> getSubCatAPICall(String catId) async {
    print('get sub cat -  $getSubCategories');
    try {
      Map<String, dynamic> data = {'CatId': catId.toString()};
      final response =
          await MyClient().post(Uri.parse(getSubCategories), body: data);
      if (response.statusCode == 200) {
        print("response.body get sub cat ${response.body}");
        final myResponse = GetSubCatList.fromJson(jsonDecode(response.body));
        if (myResponse.status == success) {
          return myResponse.dataList;
        } else {
          showToast('myResponse.message --- failed', red);
        }
      } else {
        print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// -------------------- register ----------------------
  Future<String> registerUser({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? genderId,
    String? countryId,
    String? stateId,
    String? dayId,
    String? monthId,
    String? yearId,
  }) async {
    try {
      print('register $register');
      Map<String, dynamic> data = {
        'Firstname': firstName,
        'Lastname': lastName,
        'PhoneNumber': phone,
        'Email': email,
        'Gender': genderId,
        'Day': dayId,
        'Month': monthId,
        'Year': yearId,
        'Country': countryId,
        'state': stateId
      };
      print(data);
      final response = await MyClient().post(Uri.parse(register), body: data);
      print(response);
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        // showToast(myjson['message'], grey);
        if (myjson['status'] == success) {
          return myjson['message'];
        } else {
          showToast(myjson['message'], red);
          return '';
        }
      } else {
        print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ---------------------- login api----------------------
  Future loginAPICall(
      {String? email,
      bool? isChecked,
      String? password,
      String? confirmPassword}) async {
    try {
      print(' login  $login');
      Map<dynamic, dynamic> data = {
        'Email': email,
        'IsChecked': isChecked.toString(),
        'password': password,
        'confirmpassword': confirmPassword,
      };
      print(jsonEncode(data));
      final response = await MyClient().post(Uri.parse(login), body: data);
      print(response.body);
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        // showToast(myjson['message'], grey);
        if (myjson['status'] == success) {
          //if (isChecked!) {
          sp.saveUserDetails(myjson['data']);
          //}
          return myjson;
        } else {
          if (isChecked!) showToast(myjson['message'], red);
          return myjson;
        }
      } else {
        print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------------- forgot email ------------------------
  Future forgotEmailAPICall({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    try {
      print('forgot email - $forgotEmail');
      Map<String, dynamic> data = {
        'Firstname': firstName,
        'Lastname': lastName,
        'PhoneNumber': phoneNumber,
      };
      print(data);
      final response =
          await MyClient().post(Uri.parse(forgotEmail), body: data);
      if (response.statusCode == 200) {
        var myjson = jsonDecode(response.body);
        print(myjson);
        if (myjson['status'] == success) {
          print('status ${myjson['status']}');
          return myjson;
        } else {
          print('err ${myjson['message']}');
          showToast(myjson['message'], red);
        }
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ---------------- forgot password -----------------------
  Future forgotPasswordAPICall({String? email}) async {
    try {
      print('forgot password $forgotPassword');
      Map<String, dynamic> data = {'Email': email};
      var response =
          await MyClient().post(Uri.parse(forgotPassword), body: data);
      print(response.body);
      if (response.statusCode == 200) {
        var myjson = jsonDecode(response.body);
        if (myjson['status'] == success) {
          return myjson;
        } else {
          showToast(myjson['message'], red);
          return myjson;
        }
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }
}

Networkcall networkcallService = new Networkcall();
