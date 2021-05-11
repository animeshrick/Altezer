import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:altezar/models/autoPartsListModel.dart';
import 'package:altezar/models/getAutoPartsCat.dart';
import 'package:altezar/models/getAutoPartsSubCat.dart';
import 'package:altezar/models/getCategories.dart';
import 'package:altezar/models/getLatestDeals.dart';
import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/getProductsData.dart';
import 'package:altezar/models/getResTypeList.dart';
import 'package:altezar/models/getSortByData.dart';
import 'package:altezar/models/getStateList.dart';
import 'package:altezar/models/getStoreList.dart';
import 'package:altezar/models/getSubCatList.dart';
import 'package:altezar/models/getdealsList.dart';
import 'package:altezar/models/groceryStateList.dart';
import 'package:altezar/models/groceryStoreList.dart';
import 'package:altezar/models/productDetails.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';

import 'MyClient.dart';

class Networkcall {
  static final Networkcall networkcall = new Networkcall._internal();

  Networkcall._internal();

  factory Networkcall() {
    return networkcall;
  }

  /// -------------------- get prd details ----------------
  Future<GetRestList?>? getAllPrdDetails(String prdTypeId, String prdId) async {
    print(' get all prd details $getProductDetails');
    try {
      Map<String, dynamic> data = {
        'ProductTypeId': prdTypeId,
        'ProductId': prdId
      };
      final response =
          await MyClient().post(Uri.parse(getProductDetails), body: data);
      var resp = response.body;
      print(resp);
      if (response.statusCode == 200) {
        final myResponse = GetRestList.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse;
        }
      }
    } on SocketException {}
  }

  /// -------------- get sort value ------------------
  Future<List<GetSortByData>?> getSortByDataAPICall() async {
    // print('get sort value $getSortByData');
    try {
      final response = await MyClient().get(Uri.parse(getSortByData));
      var resp = response.body;
      // print('response.body of get sort value - $resp');
      if (response.statusCode == 200) {
        final myResponse = GetSort.fromJson(jsonDecode((resp)));
        if (myResponse.status == success) {
          return myResponse.sortList;
        } else {
          showToast('myResponse.message', red);
        }
      } else {
        // print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------------------- grocery state list -------------------------
  Future<List<GetGroceryStateList>?> getGroceryStateListAPICall() async {
    // print('grocery state $getGroceryStateList');
    try {
      final response = await MyClient().get(Uri.parse(getGroceryStateList));
      var resp = response.body;
      // print(' body - $resp');
      if (response.statusCode == 200) {
        final myResponse = GetGroceryState.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.groceryStateList;
        } else {
          return showToast(myResponse.message, red);
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------- get store list -------------------
  Future<List<StoreList>?> getStoreListAPICall(
      String stateId, String searchVal) async {
    try {
      // print('get store list -- $getStoreList');
      Map<String, dynamic> data = {
        'StateId': stateId,
        'searchVal': searchVal,
      };
      final response =
          await MyClient().post(Uri.parse(getStoreList), body: data);
      var resp = response.body;
      // print('store list body -- $resp');
      if (response.statusCode == 200) {
        final myResponse = GetStoreList.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.storedataList;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------- get deals list -------------------
  Future<List<DealsListData>?> getDealsAPICall(
      String catId, String pageIndex) async {
    try {
      // print('get deals list -- $getDeals');
      Map<String, dynamic> data = {
        'CatId': catId,
        'pageIndex': pageIndex,
      };
      final response = await MyClient().post(Uri.parse(getDeals), body: data);
      var resp = response.body;
      // print('store deals body -- $resp');
      if (response.statusCode == 200) {
        final myResponse = GetDealsList.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.dealList;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------------- get rest type list ----------------------

  Future<List<ResTypelist>?> getResTypeListAPICall() async {
    try {
      print(' res type list - $getResType');
      final response = await MyClient().get(Uri.parse(getResType));
      var resp = response.body;
      print(' res type list - $resp');
      if (response.statusCode == 200) {
        final myResponse = GetResType.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.resTypelist;
        } else {
          return showToast(myResponse.message, red);
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }
/*
  /// --------------------- get res list ----------------------
  Future getResListAPICall(
      String stateId, String searchVal, String resturantTypeId) async {
    try {
      print('get res list $getResList');
      Map<String, dynamic> data = {
        'StateId': stateId,
        'searchVal': searchVal,
        'resturantTypeId': resturantTypeId,
      };
      final response = await MyClient().post(Uri.parse(getResList), body: data);
      var resp = response.body;
      // if (response.statusCode == 200) {
      //   final myResponse = GetAutoPartsCat.fromJson(jsonDecode(resp));
      //   if (myResponse.status == success) {
      //     return myResponse.autoPartsCategory;
      //   } else {
      //     return showToast(myResponse.message, red);
      //   }
      // } else {
      //   throw response.body;
      // }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }
*/
  /// ------------------ get auto part cat -------------

  Future<List<AutoPartsCategory>?> getPartsCatAPICall() async {
    try {
      print('get auto parts - $getAutoCat');
      final response = await MyClient().get(Uri.parse(getAutoCat));
      var resp = response.body;
      if (response.statusCode == 200) {
        final myResponse = GetAutoPartsCat.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.autoPartsCategory;
        } else {
          return showToast(myResponse.message, red);
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------------ get auto part sub cat -------------
  Future<List<AutoPartsSubcategory>?> getPartsSubCatAPICall(
      String catId) async {
    try {
      print('get auto parts - $getAutoSubCat');
      Map<String, dynamic> data = {'CatId': catId};
      final response =
          await MyClient().post(Uri.parse(getAutoSubCat), body: data);
      var resp = response.body;
      print(resp);
      if (response.statusCode == 200) {
        final myResponse = GetAutoPartsSubCat.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.autoPartsSubcategory;
        } else {
          return showToast(myResponse.message, red);
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ---------------- grocery store list -----------------
  Future<List<GetGroceryStoreList>?> getGroceryStoreListAPICall(
      String stateId, String searchVal) async {
    // print('grocery state $getGroceryStoreList');
    try {
      Map<String, dynamic> data = {'StateId': stateId, 'searchVal': searchVal};
      // print('param- $data');
      final response =
          await MyClient().post(Uri.parse(getGroceryStoreList), body: data);
      var resp = response.body;
      // print(' grocerybody - $resp');
      if (response.statusCode == 200) {
        final myResponse = GetGroceryStore.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.groceryStoreList;
        } else {
          return showToast(myResponse.message, red);
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------- get products -----------------------
  Future<List<ProductListData>?> getProductsAPICall(
      String catID,
      String searchVal,
      String subCatId,
      String sortCode,
      String pageIndex) async {
    Map<String, dynamic> data = {
      'catId': catID.toString(),
      'SearchVal': searchVal.toString(),
      'SubCatId': subCatId.toString(),
      'sortCode': sortCode.toString(),
      'pageIndex': pageIndex.toString(),
    };
    try {
      // print('param $data');
      final response =
          await MyClient().post(Uri.parse(getProducts), body: data);
      var resp = response.body;
      // print('get products resp -- $resp');
      if (response.statusCode == 200) {
        final myResponse = GetProducts.fromJson(jsonDecode((resp)));
        if (myResponse.status == success) {
          return myResponse.prdListData;
        } else {
          showToast(myResponse.message, red);
          throw myResponse.message;
        }
      } else {
        // print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------------------- get all latest deals -------------------
  Future<List<LatestDealsList>?> getAllLatestDealsAPICall() async {
    try {
      //print('get latest deals --- $getLatestDeals');
      final response = await MyClient().get(Uri.parse(getLatestDeals));
      var resp = response.body;
      //print('latest deals body -- $resp');
      if (response.statusCode == 200) {
        final myResponse = GetLatestDeals.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          //print('data exist');
          return myResponse.latestDealsList;
        } else {
          //print('data not exist');
          showToast(myResponse.message, red);
        }
      } else {
        // print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// -------------- get auto part list ------------------
  Future<List<AutoPartsList>?> getAutoPartList(
    String textSearchVal,
    String partsCatId,
    String partsSubCatId,
    String sortCode,
    String pageIndex,
  ) async {
    try {
      print('get auto part list -- $getAutoPartListApi');
      Map<String, dynamic> data = {
        'textSearchVal': textSearchVal,
        'PartsCatID': partsCatId,
        'PartsSubCatID': partsSubCatId,
        'sortCode': sortCode,
        'pageIndex': pageIndex,
      };
      final response =
          await MyClient().post(Uri.parse(getAutoPartListApi), body: data);
      var resp = response.body;
      print('get auto part list body --- $resp');
      if (response.statusCode == 200) {
        final myresponse = GetAutoPartsList.fromJson(jsonDecode(resp));
        if (myresponse.status == success) {
          return myresponse.autoPartsList;
        } else {
          return showToast(myresponse.message, red);
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------- get all dropdown values -----------------------
  Future<GetLists?> getAllDropdownValue() async {
    // print('getAllDropdownValue $getallDropdownlist');
    try {
      final response = await MyClient().get(Uri.parse(getallDropdownlist));
      if (response.statusCode == 200) {
        final myResponse = GetLists.fromJson(jsonDecode(response.body));
        // print(response.body);
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast('myResponse.message --- failed', red);
        }
      } else {
        // print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------- state values -----------------------
  Future<List<StateList>?> getStateValue(String countryId) async {
    // print('getStateValue $stateList');
    try {
      Map<String, dynamic> data = {'countryId': countryId.toString()};
      final response = await MyClient().post(Uri.parse(stateList), body: data);
      // print(response);
      if (response.statusCode == 200) {
        final myResponse = GetStateList.fromJson(jsonDecode(response.body));
        // print(response.body);
        if (myResponse.status == success) {
          return myResponse.stateList;
        } else {
          showToast('myResponse.message --- failed', red);
        }
      } else {
        // print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// -------------- get categories ----------------
  Future<List<CategoriesList>?> getCategoriesAPICall() async {
    // print('get categories --  $getCategories');
    try {
      final response = await MyClient().get(Uri.parse(getCategories));
      if (response.statusCode == 200) {
        // print("response.body get categories ${response.body}");
        final myResponse = GetCategories.fromJson(jsonDecode(response.body));
        if (myResponse.status == success) {
          return myResponse.catList;
        } else {
          showToast('myResponse.message --- failed', red);
        }
      } else {
        // print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------- get sub cat  -----------------------
  Future<List<GetSubCateProductsList>?> getSubCatAPICall(String catId) async {
    // print('get sub cat -  $getSubCategories');
    try {
      Map<String, dynamic> data = {'CatId': catId.toString()};
      final response =
          await MyClient().post(Uri.parse(getSubCategories), body: data);
      if (response.statusCode == 200) {
        // print("response.body get sub cat ${response.body}");
        final myResponse = GetSubCatList.fromJson(jsonDecode(response.body));
        if (myResponse.status == success) {
          return myResponse.dataList;
        } else {
          showToast('myResponse.message --- failed', red);
        }
      } else {
        // print('have err');
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

/* _____________________________ AUTH ______________________________________*/

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
      // print('register $register');
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
      // print(data);
      final response = await MyClient().post(Uri.parse(register), body: data);
      // print(response);
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
        // print('have err');
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
      // print(' login  $login');
      Map<dynamic, dynamic> data = {
        'Email': email,
        'IsChecked': isChecked.toString(),
        'password': password,
        'confirmpassword': confirmPassword,
      };
      // print(jsonEncode(data));
      final response = await MyClient().post(Uri.parse(login), body: data);
      // print(response.body);
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
        // print('have err');
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
      // print('forgot email - $forgotEmail');
      Map<String, dynamic> data = {
        'Firstname': firstName,
        'Lastname': lastName,
        'PhoneNumber': phoneNumber,
      };
      // print(data);
      final response =
          await MyClient().post(Uri.parse(forgotEmail), body: data);
      if (response.statusCode == 200) {
        var myjson = jsonDecode(response.body);
        // print(myjson);
        if (myjson['status'] == success) {
          // print('status ${myjson['status']}');
          return myjson;
        } else {
          // print('err ${myjson['message']}');
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
      // print('forgot password $forgotPassword');
      Map<String, dynamic> data = {'Email': email};
      var response =
          await MyClient().post(Uri.parse(forgotPassword), body: data);
      // print(response.body);
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
