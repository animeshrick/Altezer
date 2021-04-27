import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:altezar/utils/const.dart';

import 'MyClient.dart';

class Networkcall {
  static final Networkcall networkcall = new Networkcall._internal();

  Networkcall._internal();

  factory Networkcall() {
    return networkcall;
  }

  ///------------------------------register---------------
  // Future<bool> register(
  //     {name, email, phoneNo, address, latitude, longitude, password}) async {
  //   Map<String, dynamic> params = {
  //     'name': name,
  //     'email': email,
  //     'phone_no': phoneNo,
  //     'address': address,
  //     'latitude': latitude,
  //     'longitude': longitude,
  //     'password': password
  //   };
  //   final response = await http.post(Uri.parse(registerUrl), body: params);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     final myjson = jsonDecode(response.body);
  //     showToast(myjson['message'], Colors.red);
  //     if (myjson['status'] == success) {
  //       sharePrefereceInstance.saveUserDetail(myjson['data']);
  //       return true;
  //     } else {
  //       showToast("msg err", red);
  //       return false;
  //     }
  //   } else {
  //     // showToast(response.body, Colors.red);
  //     showToast('The provided credentials are incorrect.', red);
  //     return false;
  //   }
  // }

  ///demoApi
  Future demo(name) async {
    print(stateList);
    try {
      Map<String, dynamic> params = {'Name': name};
      final response =
          await MyClient().post(Uri.parse(stateList), body: params);
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        // showToast(myjson['message'], Colors.red);
        print(myjson);
      } else {
        showToast("msg err", red);
      }
    } catch (e) {
      showToast(e, red);
    }
  }

  /// --------------------- getall dropdown values -----------------------
  Future getAllDropdownValue() async {
    print(getallDropdownlist);
    try {
      final response = await MyClient().get(Uri.parse(getallDropdownlist));
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        print(myjson);
      } else {
        print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  // Future<List<CategoriesModelData>> getShopCategories() async {
  //   print(categoriesUrl);
  //   try {
  //     final response = await MyClient().get(Uri.parse(categoriesUrl));
  //     // print('getShopCategories response.body + ${response.body}');
  //     if (response.statusCode == 200) {
  //       final myJson = jsonDecode(response.body);
  //       CategoriesModel model = CategoriesModel.fromJson(myJson);
  //       if (model.status == success) {
  //         return model.dataList;
  //       } else
  //         throw myJson;
  //     } else {
  //       print('have err');
  //       throw response.body;
  //     }
  //   } on SocketException {
  //     showToast(internetError, red);
  //     throw internetError;
  //   }
  // }
}

Networkcall networkcallService = new Networkcall();
