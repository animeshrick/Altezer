import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/getStateList.dart';
import 'package:altezar/utils/const.dart';

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
        // final myjson = jsonDecode(response.body);
        final myResponse = GetLists.fromJson(jsonDecode(response.body));
        print(response.body);
        if (myResponse.status == success) {
          // return myResponse.;
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
}

Networkcall networkcallService = new Networkcall();
