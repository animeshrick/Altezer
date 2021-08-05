import 'dart:convert';
import 'dart:io';

import 'package:altezar/models/CartUpdateModel.dart';
import 'package:altezar/models/PrdDetailModel2.dart';
import 'package:altezar/models/RegistryItemListByRegIdModel.dart';
import 'package:altezar/models/RegistryListDropdownModel.dart';
import 'package:altezar/models/addedRegListModel.dart';
import 'package:altezar/models/autoPartsListModel.dart';
import 'package:altezar/models/bannerImage.dart';
import 'package:altezar/models/cancelOrderModel.dart';
import 'package:altezar/models/confirmedModel.dart';
import 'package:altezar/models/getAddBankAccList.dart';
import 'package:altezar/models/getAddressList.dart';
import 'package:altezar/models/getAutoPartsCat.dart';
import 'package:altezar/models/getAutoPartsSubCat.dart';
import 'package:altezar/models/getBankBranch.dart';
import 'package:altezar/models/getBankList.dart';
import 'package:altezar/models/getCartBox.dart';
import 'package:altezar/models/getCartOrderDetailsModel.dart';
import 'package:altezar/models/getCategories.dart';
import 'package:altezar/models/getDefAdd.dart';
import 'package:altezar/models/getDeliveryOptions.dart';
import 'package:altezar/models/getGategoryForStores.dart';
import 'package:altezar/models/getLatestDeals.dart';
import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/getProductsData.dart';
import 'package:altezar/models/getQuestions.dart';
import 'package:altezar/models/getResList.dart';
import 'package:altezar/models/getResTypeList.dart';
import 'package:altezar/models/getSortByData.dart';
import 'package:altezar/models/getStateList.dart';
import 'package:altezar/models/getStoreList.dart';
import 'package:altezar/models/getSubCatList.dart';
import 'package:altezar/models/getUserInfo.dart';
import 'package:altezar/models/getdealsList.dart';
import 'package:altezar/models/groceryStateList.dart';
import 'package:altezar/models/groceryStoreList.dart';
import 'package:altezar/models/imgModel.dart';
import 'package:altezar/models/invoiceModel.dart';
import 'package:altezar/models/myOrderModel.dart';
import 'package:altezar/models/orderDetailsModel.dart';
import 'package:altezar/models/orderTrackingModel.dart';
import 'package:altezar/models/pageDetailsModel.dart';
import 'package:altezar/models/paymentModel.dart';
import 'package:altezar/models/productDetailsModel.dart';
import 'package:altezar/models/receiptModel.dart';
import 'package:altezar/models/registryInfoModel.dart';
import 'package:altezar/models/registryListModel.dart';
import 'package:altezar/models/registryTypeCodeModel.dart';
import 'package:altezar/models/shippingCountryStateList.dart';
import 'package:altezar/models/shippingDeliverToHome.dart';
import 'package:altezar/models/shippingDelivertoPickup.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';

import 'MyClient.dart';

class Networkcall {
  static final Networkcall networkcall = new Networkcall._internal();

  Networkcall._internal();

  factory Networkcall() {
    return networkcall;
  }

  /// ------------- prd img ------------------
  Future<UploadImgModel?> getImage({
    required String basedata,
  }) async {
    Map<String, dynamic> data = {
      'basedata': basedata,
    };
    final response =
        await MyClient().post(Uri.parse(imgPrdDetails), body: data);
    final resp = response.body;
    print('$imgPrdDetails --> $data = $resp');
    final myResponse = UploadImgModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ---------- track orders ----------------
  Future<OrderTrackingModel?> getOrderTrackAPICall({
    required String userId,
    required String orderID,
  }) async {
    Map<String, dynamic> data = {
      'UserId': userId,
      'orderNumber': orderID,
    };
    final response =
        await MyClient().post(Uri.parse(orderTracking), body: data);
    final resp = response.body;
    print('$orderTracking --> $data = $resp');
    final myResponse = OrderTrackingModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ---------- recipt ----------------
  Future<List<Transactionslist>> getReciptAPICall({
    required String userId,
  }) async {
    Map<String, dynamic> data = {
      'UserId': userId,
    };
    final response = await MyClient().post(Uri.parse(receiptApi), body: data);
    final resp = response.body;
    // print('$receiptApi --> $data = $resp');
    final myResponse = ReciptModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.transactionslist;
        } else {
          showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------------- getCartSubtotalAndItemCount.ashx ------------------
  Future<List<MyOrderDetail>?> getCartSubtotalAndItemCount({
    required String deliveryCode,
    required String userId,
  }) async {
    Map<String, dynamic> data = {
      'UserId': userId,
      'DeliveryCode': deliveryCode
    };
    final response = await MyClient()
        .post(Uri.parse(getCartSubtotalAndItemCountAPI), body: data);
    final resp = response.body;
    // print('$getCartSubtotalAndItemCountAPI --> $data = $resp');
    final myResponse = CartUpdateModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.updatedcartData;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------Save Update Checkout Shipping --------------
  Future<bool> getSaveUpdateCheckoutShipping({
    required String userID,
    required String deliveryCompanyServiceID,
    required String customerPickupLocationId,
    required String weightTotallbs,
    required String weightTotalCost,
    required String deliveryOptionCode,
    required String customerDeliveryAddressId,
  }) async {
    Map<String, dynamic> data = {
      'UserId': userID,
      'Delivery_Company_Service_ID': deliveryCompanyServiceID,
      'Customer_Pickup_Location_Id': customerPickupLocationId,
      'Weight_Total_lbs': weightTotallbs,
      'Weight_Total_Cost': weightTotalCost,
      'Delivery_Option_Code': deliveryOptionCode,
      'Customer_Delivery_Address_Id': customerDeliveryAddressId,
    };

    final response =
        await MyClient().post(Uri.parse(saveUpdateCheckoutShippig), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('$saveUpdateCheckoutShippig $data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// -------- confirm payment ----------
  Future<List<ConfOrderInfo>?> getConfPayment({
    required String orderNumber,
  }) async {
    Map<String, dynamic> data = {'OrderNumber': orderNumber};
    final response = await MyClient().post(Uri.parse(confpayment), body: data);
    final resp = response.body;
    // print('$confpayment --> $data = $resp');
    final myResponse = ConfirmedPaymentModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.conforderInfo;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------- payment [cod & pay in store] ------------------
  Future<PaymentModel?> getPaymentAPICall({
    required String delCode,
    required String userID,
    required String addID,
  }) async {
    Map<String, dynamic> data = {
      'DeliveryCode': delCode,
      'UserId': userID,
      'addressId': addID
    };
    final response = await MyClient().post(Uri.parse(payment), body: data);
    final resp = response.body;
    // print('$payment --> $data = $resp');
    final myResponse = PaymentModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------- add prd in reg list --------------
  Future<bool> getAddPrdToRegList(
      {required String listId,
      required String prdId,
      required String qty}) async {
    Map<String, dynamic> data = {
      'ListId': listId,
      'ProductId': prdId,
      'Qty': qty
    };

    final response = await MyClient().post(Uri.parse(addItemtoDD), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('$addItemtoDD $data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------- registry list dropdown -------------
  Future<List<RegistryListData>> getRegistryListDropdown(String userId) async {
    try {
      Map<String, dynamic> data = {
        'UserId': userId,
      };
      final response = await MyClient().post(Uri.parse(regListDD), body: data);
      var resp = response.body;
      // print('$regListDD $data -- $resp');
      if (response.statusCode == 200) {
        final myResponse = RegistryListDropdownModel.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.registryListdata;
        } else {
          // showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------- save delivery addrss-----------------
  Future<bool> getAddDeliveryAddres(
      {required String firstName,
      required String compName,
      required String add1,
      required String add2,
      required String area,
      required String city,
      required String parishCode,
      required String zippostalCode,
      required String countryCode,
      required String isDefault,
      required String delivaryPhone,
      required String instruction,
      required String userId}) async {
    Map<String, dynamic> data = {
      'Fullname': firstName,
      'CompanyName': compName,
      'Address1': add1,
      'Address2': add2,
      'Area': area,
      'City': city,
      'ParishCode': parishCode,
      'ZipOrPostalCode': zippostalCode,
      'CountryCode': countryCode,
      'IsDefault': isDefault,
      'DeliveryPhone': delivaryPhone,
      'DeliveryInstructions': instruction,
      'UserId': userId,
    };

    final response =
        await MyClient().post(Uri.parse(addAddressInOrder), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('$addAddressInOrder $data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------- view invoice --------------
  Future<InvoiceModel?> getInvoiceAPICall(
      {required String orderNumber, required String userID}) async {
    Map<String, dynamic> data = {'orderNumber': orderNumber, 'UserId': userID};
    final response = await MyClient().post(Uri.parse(orderInvoice), body: data);
    final resp = response.body;
    print('$orderInvoice --> $data = $resp');
    final myResponse = InvoiceModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /* ------------- get Order Cancel By Item Id ----------------- */
  Future<bool> getOrderCancelByItemId({required String orderLineItemId}) async {
    Map<String, dynamic> data = {'OrderLineItemId': orderLineItemId};

    final response =
        await MyClient().post(Uri.parse(orderCancelByItemId), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('$orderCancelByItemId $data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ---------------order details -----------------
  Future<OrdDetailsModel?> getPlacedOrderDetails(
      {required String orderNumber, required String userId}) async {
    try {
      Map<String, dynamic> data = {
        'orderNumber': orderNumber,
        'UserId': userId,
      };
      final response =
          await MyClient().post(Uri.parse(getOrderDetails), body: data);
      var resp = response.body;
      // print('$getOrderDetails $data -- $resp');
      if (response.statusCode == 200) {
        final myResponse = OrdDetailsModel.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------- cancel order list -----------------
  Future<List<CancelOrders>> getCancelOrder(String orderNumber) async {
    try {
      Map<String, dynamic> data = {
        'orderNumber': orderNumber,
      };
      final response =
          await MyClient().post(Uri.parse(getCancelOrders), body: data);
      var resp = response.body;
      // print('$getCancelOrders $data -- $resp');
      if (response.statusCode == 200) {
        final myResponse = CancelOrderModel.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.cancelorder;
        } else {
          showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------------ get my oders --------------------
  Future<List<MyOrderList>> getMyOrders(String userId) async {
    Map<String, dynamic> data = {'UserId': userId};
    final response = await MyClient().post(Uri.parse(getOrders), body: data);
    final resp = response.body;
    // print('$getOrders --> $data = $resp');
    final myResponse = MyOrderModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.myOrderList;
        } else {
          showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------ add registry items -------------------
  Future<bool> getAddRegistryItems({
    required String regID,
    required String userID,
  }) async {
    Map<String, dynamic> data = {'RegistryId': regID, 'UserId': userID};
    final response = await MyClient().post(Uri.parse(addtoCartAll), body: data);
    var resp = response.body;
    // print('$addtoCartAll $data --- $resp');
    final myResponse = jsonDecode(resp);
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------------- remove registry products------------------
  Future<bool> getRemoveRegistryPoductsAPICall({
    required String registryItemId,
  }) async {
    Map<String, dynamic> data = {
      'RegistryItemId': registryItemId,
    };
    final response =
        await MyClient().post(Uri.parse(deleteRegistryProducts), body: data);
    var resp = response.body;
    // print('$deleteRegistryProducts $data --- $resp');
    final myResponse = jsonDecode(resp);
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------------- remove registry ------------------
  Future<bool> getRemoveRegistryAPICall({
    required String regID,
    required String userID,
  }) async {
    Map<String, dynamic> data = {'RegistryId': regID, 'UserId': userID};
    final response =
        await MyClient().post(Uri.parse(deleteRegistry), body: data);
    var resp = response.body;
    // print('$deleteRegistry $data --- $resp');
    final myResponse = jsonDecode(resp);
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------- new added registry list ------------
  Future<AddRegListModel?> getNewAddedRegListAPICall(
      {required String registryId,
      required String pageIndex,
      required String userID}) async {
    Map<String, dynamic> data = {
      'RegistryId': registryId,
      'pageIndex': pageIndex,
      'UserId': userID
    };
    final response =
        await MyClient().post(Uri.parse(userListofRegistry), body: data);
    final resp = response.body;
    // print('$userListofRegistry --> $data = $resp');
    final myResponse = AddRegListModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------------- add registry ------------------
  Future<bool> getAddRegistryAPICall({
    required String typeID,
    required String name,
    required String isPrivate,
    required String eventDate,
    required String benifitName,
    required String add,
    required String userID,
  }) async {
    Map<String, dynamic> data = {
      'TypeId': typeID,
      'Name': name,
      'IsPrivate': isPrivate,
      'EventDate': eventDate,
      'BenefitName': benifitName,
      'ShippingAddress': add,
      'UserId': userID
    };
    final response = await MyClient().post(Uri.parse(addRegistry), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('$addRegistry $data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// -------------------- registry info -------------
  Future<List<RegistryInfo?>> getViewRegistryInfo(String registryId) async {
    Map<String, dynamic> data = {'RegistryId': registryId};
    final response = await MyClient().post(Uri.parse(registryInfo), body: data);
    final resp = response.body;
    // print('$registryInfo --> $data = $resp');
    final myResponse = RegistryInfoModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.registryInfo;
        } else {
          showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------- registry list info -------------
  Future<List<ListOfRegistryItem?>> getRegistryListInfo(
      String registryId, String pageIndex) async {
    Map<String, dynamic> data = {
      'RegistryId': registryId,
      'pageIndex': pageIndex
    };
    final response =
        await MyClient().post(Uri.parse(registryListInfo), body: data);
    final resp = response.body;
    // print('$registryListInfo --> $data = $resp');
    final myResponse = RegistryItemListByRegIdModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.listOfRegistryItems;
        } else {
          showToast(myResponse.message, red);
          return myResponse.listOfRegistryItems;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------- registry list ------------
  Future<List<RegistryList?>> getRegistryListAPICall(String registryId) async {
    Map<String, dynamic> data = {'SearchVal': registryId};
    final response = await MyClient().post(Uri.parse(registryList), body: data);
    final resp = response.body;
    // print('$registryList --> $data = $resp');
    final myResponse = RegistryListModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.registryList;
        } else {
          showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// -------------- registry type code ---------------
  Future<List<ListType?>> getListCodeTypeAPICall() async {
    // Map<String, dynamic> data = {'SearchVal': searVal};
    final response = await MyClient().get(
      Uri.parse(registryListTypeCode),
    );
    final resp = response.body;
    final myResponse = ListTypeModel.fromJson(jsonDecode(resp));
    // print('$registryListTypeCode --> $data = $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.listType;
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

  /// ----------- increase prd to cart -------------------
  Future<bool> getIncreasedCartPrd(String qty, String productCartItemId) async {
    Map<String, dynamic> data = {
      'qty': qty,
      'productCartItemId': productCartItemId
    };
    final response =
        await MyClient().post(Uri.parse(addPrdQuantity), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('addPrdQuantity -- $addPrdQuantity');
    // print('$data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// -------------- apply cupon code --------------
  Future<bool> getApplyCuponCode(String cuponCode, String userId) async {
    Map<String, dynamic> data = {'couponCode': cuponCode, 'UserId': userId};
    final response = await MyClient().post(Uri.parse(cuponCodeAPI), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('cuponCodeAPI -- $cuponCodeAPI');
    // print('$data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------- update default address --------------
  Future<bool> getUpdateAddressDefault(String userID, String addressID) async {
    Map<String, dynamic> data = {'UserId': userID, 'addressId': addressID};

    final response =
        await MyClient().post(Uri.parse(updateAddress), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('update default address -- $updateAddress');
    // print('$data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------- add note to seller --------------
  Future<bool> getAddNotestoSeller(
      String note, String productCartItemId) async {
    Map<String, dynamic> data = {
      'note': note,
      'productCartItemId': productCartItemId
    };

    final response = await MyClient().post(Uri.parse(sellerNote), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('sellerNote -- $sellerNote');
    // print('$data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------- remove cart product --------------
  Future<bool> getRemoveCartProduct(
      String userID, String productCartItemId) async {
    Map<String, dynamic> data = {
      'UserId': userID,
      'productCartItemId': productCartItemId
    };

    final response =
        await MyClient().post(Uri.parse(removeCartItem), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);

    print('removeCartItem -- $removeCartItem $data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------------------- get shippingoption DelivertoHome ---------------
  Future<DeliverToHome?> getShippingAeliverToHome(String userID) async {
    Map<String, dynamic> data = {'UserId': userID};
    final response =
        await MyClient().post(Uri.parse(delivertoHome), body: data);
    final resp = response.body;
    final myResponse = DeliverToHome.fromJson(jsonDecode(resp));
    // print('$delivertoHome --> $data = $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------------------- get shippingOption DelivertoPickup ---------------

  Future<DeliverToPickup?> getShippingAeliverToPickup(String userID) async {
    Map<String, dynamic> data = {'UserId': userID};
    final response =
        await MyClient().post(Uri.parse(delivertoPickup), body: data);
    final resp = response.body;
    // print('$delivertoPickup --> $data = $resp');
    final myResponse = DeliverToPickup.fromJson(jsonDecode(resp));

    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------- get default address  --------
  Future<List<DeaultAddress>?> getDefaultAddAPICall(String userID) async {
    Map<String, dynamic> data = {'UserId': userID};
    final response =
        await MyClient().post(Uri.parse(defaultAddress), body: data);
    final resp = response.body;
    final myResponse = GetDefaultAddress.fromJson(jsonDecode(resp));
    print('$defaultAddress --> $data = $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.deaultAddress;
        } else {
          showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------- shippping address list --------
  Future<List<ShippingAddressList>?> getAddressListAPICall(
      String userID) async {
    Map<String, dynamic> data = {'UserId': userID};
    final response = await MyClient().post(Uri.parse(addressList), body: data);
    final resp = response.body;
    final myResponse = GetAddressList.fromJson(jsonDecode(resp));
    // print('$addressList --> $data = $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.shippingAddressList;
        } else {
          // showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------------- banner image ----------------
  Future<BannerImage?> getBannerImageAPICall(String storeId) async {
    Map<String, dynamic> data = {'StoreId': storeId};
    final response =
        await MyClient().post(Uri.parse(bannerImageAPI), body: data);
    final resp = response.body;
    final myResponse = BannerImage.fromJson(jsonDecode(resp));
    // print('$bannerImageAPI --> $data = $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
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

  /// ---------------- add address ----------------------
  Future<bool> getAddAddressAPICall(
    String userId,
    String fullname,
    String companyName,
    String address1,
    String address2,
    String area,
    String city,
    String stateCode,
    String zipCode,
    String countryCode,
    String isDefault,
    String deliveryPhone,
    String deliveryInstructions,
  ) async {
    Map<String, dynamic> data = {
      'UserId': userId,
      'Fullname': fullname,
      'CompanyName': companyName,
      'Address1': address1,
      'Address2': address2,
      'Area': area,
      'City': city,
      'ParishCode': stateCode,
      'ZipOrPostalCode': zipCode,
      'CountryCode': countryCode,
      'IsDefault': isDefault,
      'DeliveryPhone': deliveryPhone,
      'DeliveryInstructions': deliveryInstructions,
    };
    final response =
        await MyClient().post(Uri.parse(addShippingAddress), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('addShippingAddress -- $addShippingAddress');
    // print('$data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------- shipping country & state list -------------------
  Future<GetShippingCountryandstatelist?>
      getShippingCountryStateAPICall() async {
    final response = await MyClient().get(Uri.parse(shippingCountryState));
    var resp = response.body;
    final myResponse =
        GetShippingCountryandstatelist.fromJson(jsonDecode(resp));
    // print('shippingCountryState -- $shippingCountryState');
    // print('$resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
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

  ///  ---------------------- edit bank detals ---------------
  //   Future<List<BankDetail>?> getEditedBankAccDetailsAPICall(String userId,String cusBankAccId) async{
  //       Map<String, dynamic> data = {'UserId': userId,'Customer_Bank_Account_Id':cusBankAccId};
  //   final response =
  //       await MyClient().post(Uri.parse(editBankDetails), body: data);
  //   var resp = response.body;
  //   final myResponse = GetEditBankAccDetails.fromJson(jsonDecode(resp));
  //   print('$editBankDetails --> $resp');
  //   print('daata ---- $data');
  //   try {
  //     if (response.statusCode == 200) {
  //       if (myResponse.status == success) {
  //         return myResponse.bankDetails;
  //       } else {
  //         return showToast(myResponse.message, red);
  //       }
  //     } else {
  //       throw response.body;
  //     }
  //   } on SocketException {
  //     showToast(internetError, red);
  //     throw internetError;
  //   }
  // }

  ///  ---------------------- added bank list ---------------
  Future<List<AddBanklist>> getAddBankListAPICall(String userId) async {
    Map<String, dynamic> data = {'UserId': userId};
    final response = await MyClient().post(Uri.parse(getbankList), body: data);
    var resp = response.body;
    final myResponse = GetAddBankAccList.fromJson(jsonDecode(resp));
    // print('$getbankList --> $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.banklist;
        } else {
          showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------- save bank details ---------------
  Future<bool?> saveBankDetailsAPICall(
      String accountNickname,
      String nameOnAccount,
      String accountNumber,
      String accountBankId,
      String DL_Or_TRN_Number,
      String accountStateCode,
      String accountCountryCode,
      String customerBankAccountId,
      String isDefaultAccount,
      String accountBranchId,
      String userId,
      String currentEmail,
      String currentPhoneNo) async {
    Map<String, dynamic> data = {
      'AccountNickname': accountNickname,
      'NameOnAccount': nameOnAccount,
      'AccountNumber': accountNumber,
      'AccountBankId': accountBankId,
      'DL_Or_TRN_Number': DL_Or_TRN_Number,
      'AccountStateCode': accountStateCode,
      'AccountCountryCode': accountCountryCode,
      'CustomerBankAccountId': customerBankAccountId,
      'IsDefaultAccount': isDefaultAccount,
      'AccountBranchId': accountBranchId,
      'UserId': userId,
      'CurrentEmailAddress': currentEmail,
      'CurrentPhoneNumber': currentPhoneNo
    };
    final response =
        await MyClient().post(Uri.parse(addBankDetails), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('update bank details -- $addBankDetails $data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(myResponse['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------ get bank branch-----------------------------
  Future<List<Branchlist>?> getBankBranchListAPICall(String bankId) async {
    Map<String, dynamic> data = {'BankId': bankId};
    final response =
        await MyClient().post(Uri.parse(getBankBranch), body: data);
    var resp = response.body;
    final myResponse = GetBankBranchList.fromJson(jsonDecode(resp));
    // print('$getBankBranch --> $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.branchlist;
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

  /// ------------ get banks-----------------------------
  Future<List<Banklist>?> getBankListAPICall() async {
    final response = await MyClient().get(Uri.parse(getBanks));
    var resp = response.body;
    final myResponse = GetBankList.fromJson(jsonDecode(resp));
    // print('$getBanks --> $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.banklist;
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

  /// -------------------------- update password ----------------------
  Future<bool?> getUpdatePasswordAPICall({
    String? userId,
    String? currentPwd,
    String? newPwd,
    String? confNewPwd,
    String? email,
    String? currentEmail,
    String? currentPhone,
  }) async {
    Map<String, dynamic> data = {
      'UserId': userId,
      'currentPwd': currentPwd,
      'NewPwd': newPwd,
      'ConfirmNewPwd': confNewPwd,
      'email': email,
      'CurrentEmailAddress': currentEmail,
      'CurrentPhoneNumber': currentPhone
    };
    final response =
        await MyClient().post(Uri.parse(updateUserPassword), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print('updateUserPassword -- $updateUserPassword');
    // print(' $data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------------------ update profile -----------------------
  Future<bool?> getUpdateUserInfoAPICall(
      {required String userId,
      required String fname,
      required String lnamae,
      required String email,
      required String sex,
      required String phoneNo,
      required String country,
      required String date,
      required String month,
      required String year,
      required String q1Id,
      required String q2Id,
      required String q3Id,
      required String a1,
      required String a2,
      required String a3,
      required String currentEmail,
      required String currentPhoneNo}) async {
    Map<String, dynamic> data = {
      'UserId': userId,
      'firstname': fname,
      'lastname': lnamae,
      'email': email,
      'sex': sex,
      'phone': phoneNo,
      'country': country,
      'dobDay': date,
      'dobMonth': month,
      'dobYear': year,
      'Question1Id': q1Id,
      'Question2Id': q2Id,
      'Question3Id': q3Id,
      'Answer1': a1,
      'Answer2': a2,
      'Answer3': a3,
      'CurrentEmailAddress': currentEmail,
      'CurrentPhoneNumber': currentPhoneNo
    };
    final response =
        await MyClient().post(Uri.parse(updateUserInfo), body: data);
    var resp = response.body;
    final myResponse = jsonDecode(resp);
    // print(' $updateUserInfo $data --- $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse['status'] == success) {
          showToast(myResponse['message'], greenColor);
          return true;
        } else {
          showToast(myResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ---------------- get questions ----------------
  Future<GetQuestions?> getQuestionsAPICall() async {
    final response = await MyClient().get(Uri.parse(getQuestion));
    var resp = response.body;
    final myResponse = GetQuestions.fromJson(jsonDecode(resp));
    // print('getQuestion -- $getQuestion');
    // print('$resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
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

  /// ---------------- get user info -------------------
  Future<GetUserInfo?> getUserInfoAPICall(String userId) async {
    Map<String, dynamic> data = {'UserId': userId};
    final response = await MyClient().post(Uri.parse(getUserInfo), body: data);
    var resp = response.body;
    // print('$getUserInfo $data + $resp');
    final myResponse = GetUserInfo.fromJson(jsonDecode(resp));

    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        return null;
      }
    } on SocketException {
      showToast(internetError, red);
      return null;
    }
  }

  /// ---------------------- get CartOrderDetails ------------------
  Future<GetCartOrderDetails?> getCartOrderDetailsAPICall(String userId) async {
    Map<String, dynamic> data = {'UserId': userId};
    final response =
        await MyClient().post(Uri.parse(getCartOrderDetails), body: data);
    var resp = response.body;
    final myResponse = GetCartOrderDetails.fromJson(jsonDecode(resp));
    print('xyz $getCartOrderDetails -- $data + $resp');
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse;
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

  /// ------------------ get delivery options -----------------
  Future<List<DeliveryOption>?> getDeliveryOptionsAPICall() async {
    final response = await MyClient().get(Uri.parse(getDeliveryOption));
    final resp = response.body;
    // print('$getDeliveryOption   $resp');
    final myResponse = DeliveryOptionModel.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.deliveryOptions;
        } else {
          showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ---------------- get cart box -----------------------------
  Future<List<CartBoxData>?> getCartBoxAPICall(String userId) async {
    // print('getCartBox $getCartBox');
    Map<String, dynamic> data = {'UserId': userId};
    final response = await MyClient().post(Uri.parse(getCartBox), body: data);
    var resp = response.body;
    // print(resp);
    // print(data);
    final myResponse = CartBox.fromJson(jsonDecode(resp));
    try {
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.cartBoxData;
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

  /// ----------------- GetCategoryForStore --------------------
  Future<List<StoreCatListElement>?> getCategoryForStoreAPICall(
      String storeId) async {
    // print('GetCategoryForStore --- $getCategoryForStore');
    try {
      Map<String, dynamic> data = {'StoreId': storeId};
      // print(data);
      final response =
          await MyClient().post(Uri.parse(getCategoryForStore), body: data);
      var resp = response.body;
      // print('GetCategoryForStore body -- $resp');
      final myResponse = StoreCatList.fromJson(jsonDecode(resp));
      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.storeCatList;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------------------- add to cart --------------------------
  Future<bool?> addToCartAPICall(
    String productId,
    String clientId,
    String orderType,
    String selectedStyle,
    String mtoInfo,
    String qty,
    String mtoDelivaryDate,
    String mtoImgPath,
    String userId,
    {String? img,}
  ) async {
    try {
      Map<String, dynamic> data = {
        'product_id': productId,
        'client_id': clientId,
        'order_Type': orderType,
        'Selected_Size_Color_Style': selectedStyle,
        'MTO_Information': mtoInfo,
        'Qty': qty,
        'MTO_DeliveryDate': mtoDelivaryDate,
        'MTO_Image_Path': mtoImgPath,
        'YJUserId': userId,
        'basedata': img??''
      };
      print('param- $data');
      final response = await MyClient().post(Uri.parse(addtoCart), body: data);
      final resp = response.body;
      print('$addtoCart $data $resp');
      final jsonResponse = jsonDecode(resp);
      if (response.statusCode == 200) {
        if (jsonResponse['status'] == success) {
          cartBox();
          showToast(jsonResponse['message'], greenColor);
          return true;
        } else {
          showToast(jsonResponse['message'], red);
          return false;
        }
      } else {
        showToast(json.decode(response.body)['message'], red);
        return false;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ----------------- get all prd details ---------------------
  Future<List<Productlist>?> getprdDetails(
      String catID,
      String searchVal,
      String subCatId,
      String sortCode,
      String pageIndex,
      String storeId) async {
    try {
      Map<String, dynamic> data = {
        'catId': catID.toString(),
        'SearchVal': searchVal.toString(),
        'SubCatId': subCatId.toString(),
        'sortCode': sortCode.toString(),
        'pageIndex': pageIndex.toString(),
        'retailClientId': storeId,
      };
      final response =
          await MyClient().post(Uri.parse(getDetailsOfPages), body: data);
      final resp = response.body;
      // print(' $getDetailsOfPages $data $resp');
      final myResponse = ProductDetails.fromJson(jsonDecode(resp));

      if (response.statusCode == 200) {
        if (myResponse.status == success) {
          return myResponse.productlist;
        } else {
          showToast('No product found', red);
          return [];
        }
      } else {
        showToast(myResponse.message, red);
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// -------------------- get prd details ----------------
  Future<ProdDetailModel?>? getAllPrdDetails(
      String prdTypeId, String prdId) async {
    try {
      Map<String, dynamic> data = {
        'ProductTypeId': prdTypeId,
        'ProductId': prdId
      };
      final response =
          await MyClient().post(Uri.parse(getProductDetails), body: data);
      var resp = response.body;
      // print(' get all prd details $getProductDetails -- $data -- $resp');
      if (response.statusCode == 200) {
        final myResponse = ProdDetailModel.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse;
        } else {
          showToast(myResponse.message, red);
          return null;
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
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
          showToast(myResponse.message, red);
          return null;
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
          showToast(myResponse.message, red);
          return null;
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
  Future<List<StoreList>> getStoreListAPICall(
      String stateId, String searchVal) async {
    try {
      Map<String, dynamic> data = {
        'StateId': stateId,
        'searchVal': searchVal,
      };
      final response =
          await MyClient().post(Uri.parse(getStoreList), body: data);
      var resp = response.body;
      // print('$getStoreList - $data - $resp');
      if (response.statusCode == 200) {
        final myResponse = GetStoreList.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.storedataList;
        } else {
          showToast('No product found', red);
          return [];
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
  Future<List<DealsListData>> getDealsAPICall(
      String catId, String pageIndex) async {
    try {
      Map<String, dynamic> data = {
        'CatId': catId,
        'pageIndex': pageIndex,
      };
      final response = await MyClient().post(Uri.parse(getDeals), body: data);
      var resp = response.body;
      // print('$getDeals - $data - $resp');
      if (response.statusCode == 200) {
        final myResponse = GetDealsList.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.dealList;
        } else {
          showToast('No product found', red);
          return [];
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

  Future<List<ResTypelist>> getResTypeListAPICall() async {
    try {
      // print(' res type list - $getResType');
      final response = await MyClient().get(Uri.parse(getResType));
      var resp = response.body;
      // print(' res type list - $resp');
      if (response.statusCode == 200) {
        final myResponse = GetResType.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.resTypelist;
        } else {
          showToast(myResponse.message, red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// --------------------- get res list ----------------------
  Future<List<RestShopList>>? getResListAPICall(
      String stateId, String searchVal, String resturantTypeId) async {
    try {
      Map<String, dynamic> data = {
        'StateId': stateId,
        'searchVal': searchVal,
        'resturantTypeId': resturantTypeId,
      };
      final response = await MyClient().post(Uri.parse(getResList), body: data);
      var resp = response.body;
      // print('$getResList - $data - $resp');
      if (response.statusCode == 200) {
        final myResponse = GetRestShopList.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.restList;
        } else {
          showToast('No product found', red);
          return [];
        }
      } else {
        throw response.body;
      }
    } on SocketException {
      showToast(internetError, red);
      throw internetError;
    }
  }

  /// ------------------ get auto part cat -------------

  Future<List<AutoPartsCategory>?> getPartsCatAPICall() async {
    try {
      // print('get auto parts - $getAutoCat');
      final response = await MyClient().get(Uri.parse(getAutoCat));
      var resp = response.body;
      if (response.statusCode == 200) {
        final myResponse = GetAutoPartsCat.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.autoPartsCategory;
        } else {
          showToast(myResponse.message, red);
          return [];
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
      // print('get auto parts - $getAutoSubCat');
      Map<String, dynamic> data = {'CatId': catId};
      final response =
          await MyClient().post(Uri.parse(getAutoSubCat), body: data);
      var resp = response.body;
      // print(resp);
      if (response.statusCode == 200) {
        final myResponse = GetAutoPartsSubCat.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.autoPartsSubcategory;
        } else {
          showToast('No sub-category available', red);
          return [];
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
    try {
      Map<String, dynamic> data = {'StateId': stateId, 'searchVal': searchVal};
      final response =
          await MyClient().post(Uri.parse(getGroceryStoreList), body: data);
      var resp = response.body;
      // print('$getGroceryStoreList- $data  $resp');
      if (response.statusCode == 200) {
        final myResponse = GetGroceryStore.fromJson(jsonDecode(resp));
        if (myResponse.status == success) {
          return myResponse.groceryStoreList;
        } else {
          showToast('No product found', red);
          return [];
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
      final response =
          await MyClient().post(Uri.parse(getProducts), body: data);
      var resp = response.body;
      print('$getProducts - $data - $resp');
      if (response.statusCode == 200) {
        final myResponse = GetProducts.fromJson(jsonDecode((resp)));
        if (myResponse.status == success) {
          return myResponse.prdListData;
        } else {
          showToast('No product found', red);
          return [];
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
      Map<String, dynamic> data = {
        'txtSearchVal': textSearchVal,
        'PartsCatID': partsCatId,
        'PartsSubCatID': partsSubCatId,
        'sortCode': sortCode,
        'pageIndex': pageIndex,
      };

      final response =
          await MyClient().post(Uri.parse(getAutoPartListApi), body: data);
      var resp = response.body;
      print('$getAutoPartListApi - $data- $resp');
      if (response.statusCode == 200) {
        final myresponse = GetAutoPartsList.fromJson(jsonDecode(resp));
        if (myresponse.status == success) {
          return myresponse.autoPartsList;
        } else {
          showToast('No product found', red);
          return [];
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
          showToast(myResponse.message, red);
          return null;
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
          showToast(myResponse.message, red);
          return [];
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
        print("response.body get sub cat ${response.body}");
        final myResponse = GetSubCatList.fromJson(jsonDecode(response.body));
        if (myResponse.status == success) {
          return myResponse.dataList;
        } else {
          showToast('No sub-category available', red);
          return [];
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
      final response = await MyClient().post(Uri.parse(register), body: data);
      print('$register $data $response');
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

class Final {}

Networkcall networkcallService = new Networkcall();
