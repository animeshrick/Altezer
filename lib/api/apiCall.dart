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
      print(response);
      if (response.statusCode == 200) {
        final myjson = jsonDecode(response.body);
        print(myjson);
        print(response.body);
      } else {
        print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  
}

Networkcall networkcallService = new Networkcall();
