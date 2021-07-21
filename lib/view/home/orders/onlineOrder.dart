import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/cancelOrderModel.dart';
import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/getStateList.dart';
import 'package:altezar/models/myOrderModel.dart';
import 'package:altezar/models/orderDetailsModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'invoice.dart';

class OnlineOrder extends StatefulWidget {
  @override
  _OnlineOrderState createState() => _OnlineOrderState();
}

class _OnlineOrderState extends State<OnlineOrder> {
  var _cancelOrders = <CancelOrders>[].obs;
  var _orderResullt =
      OrdDetailsModel(message: '', status: '', orderDetails: [], orderInfo: [])
          .obs;
  var _orderList = <MyOrderList>[].obs;
  RxBool isShow = false.obs;
  RxBool cancelBtnHide = false.obs;

  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController compCtrl = TextEditingController();
  TextEditingController add1Ctrl = TextEditingController();
  TextEditingController add2Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController areaCtrl = TextEditingController();
  TextEditingController zipCtrl = TextEditingController();
  TextEditingController phnCtrl = TextEditingController();
  TextEditingController insCtrl = TextEditingController();

  String? _countryValue, _stateValue;
  String? stateId, countryId;

  List<CountryList> _countryList = [];
  List<StateList>? _stateList = [];
  bool valueFirst = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getMyOrders();
      _getData();
      _getState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              isShow.value
                  ? Card(
                      child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: customText('No orders found', red, 20),
                    ))
                  : SizedBox(
                      child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => SizedBox(
                        height: 5,
                      ),
                      itemCount: _orderList.length,
                      itemBuilder: (_, int i) {
                        /*_orderList[i].totalItems == 0
                            ? Text('')
                            :  */
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 1.sw,
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color: blue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: customText(
                                          'Order ${_orderList[i].productOrderId}',
                                          black,
                                          15.0),
                                    ),
                                  ),
                                ),
                                customText(
                                    'Order# :${_orderList[i].productOrderId}',
                                    black,
                                    15.0),
                                customText(
                                    'Order Date : ${_orderList[i].timeStamp}',
                                    black,
                                    15.0),
                                customText('Items: ${_orderList[i].totalItems}',
                                    black, 15.0),
                                customText(
                                    'Sub Total: ${_orderList[i].subTotal}',
                                    black,
                                    15.0),
                                customText(
                                    'Payment Method: ${_orderList[i].paymentMethod}',
                                    black,
                                    15.0),
                                _orderList[i].totalItems == 0
                                    ? customInkWellText(
                                        () {}, 'Track Delivery', blue, 15.0)
                                    : customInkWellText(
                                        () {}, 'Track Delivery', blue, 15.0),
                                _orderList[i].totalItems != 0
                                    ? _orderList[i].orderStatusCode == 1511
                                        ? customText(
                                            '${_orderList[i].orderStatus}',
                                            grey,
                                            15.0,
                                            fontWeight: FontWeight.bold)
                                        : customInkWellText(() {
                                            _orderCancel(
                                                _orderList[i].productOrderId);
                                          }, 'Cancel order', blue, 15)
                                    : customText('Cancel order', blue, 15.0,
                                        fontWeight: FontWeight.bold),
                                _orderList[i].totalItems == 0
                                    ? ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            primary: red,
                                            onPrimary: white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Text('Details'),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          // _seeDetails();
                                          _orderDetails(
                                              _orderList[i]
                                                  .productOrderId
                                                  .toString(),
                                              _orderList[i].orderStatus);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: red,
                                            onPrimary: white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Text('Details'),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    ))
            ],
          ),
        ));
  }

  void _getData() async {
    // showProgress(context);
    final response = await networkcallService.getAllDropdownValue();
    // hideProgress(context);
    _countryList = response!.countryList;
    setState(() {});
  }

  void _getState() async {
    // showProgress(context);
    _stateList = await networkcallService.getStateValue('668');
    // hideProgress(context);
    
    setState(() {});
  }

  void getMyOrders() async {
    showProgress(context);
    _orderList.value =
        await networkcallService.getMyOrders(sp.getUserId().toString());
    if (_orderList.length == 0) {
      isShow.value = true;
    } else {
      isShow.value = false;
    }
    hideProgress(context);
  }

  void _orderDetails(orderNo, String orderStatus) async {
    showProgress(context);
    _orderResullt.value = (await networkcallService.getPlacedOrderDetails(
        userId: sp.getUserId().toString(), orderNumber: orderNo))!;
    hideProgress(context);
    _seeDetails(orderStatus);
  }

  void _orderCancel(orderNo) async {
    showProgress(context);
    _cancelOrders.value =
        await networkcallService.getCancelOrder(orderNo.toString());
    hideProgress(context);
    getMyOrders();
  }

  void _cancelPrdById({required String itemId}) async {
    showProgress(context);
    var res = await networkcallService.getOrderCancelByItemId(
        orderLineItemId: itemId);
    hideProgress(context);
    if (res) {
      cancelBtnHide.value = true;
      Get.back();
    }
  }

  void saveDeliAdd() async {
    showProgress(context);
    var res = await networkcallService.getAddDeliveryAddres(
        add1: add1Ctrl.text,
        add2: add2Ctrl.text,
        area: areaCtrl.text,
        city: cityCtrl.text,
        compName: compCtrl.text,
        countryCode: '668',
        delivaryPhone: phnCtrl.text,
        firstName: fNameCtrl.text,
        instruction: insCtrl.text,
        isDefault: valueFirst == false ? '0' : '1',
        parishCode: stateId.toString(),
        userId: sp.getUserId().toString(),
        zippostalCode: zipCtrl.text);
    hideProgress(context);
    if (res) {
      add1Ctrl.clear();
      add2Ctrl.clear();
      areaCtrl.clear();
      cityCtrl.clear();
      compCtrl.clear();
      phnCtrl.clear();
      fNameCtrl.clear();
      insCtrl.clear();
      zipCtrl.clear();
      countryId = null;
      _countryValue = null;
      stateId = null;
      _stateValue = null;
      Get.back();
    }
  }

  Future<void> _seeDetails(String orderStatus) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Customer Online Order List'),
          content: Obx(() => SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 1.sw,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customText('Customer Online Order List', black, 18,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        height: 10,
                      ),
                      customText(
                          'Order Number: ${_orderResullt.value.orderDetails[0].productOrderId}',
                          greenColor,
                          15),
                      customText(
                          'Sub total: ${_orderResullt.value.orderDetails[0].subTotal}',
                          greenColor,
                          15),
                      customText(
                          'Shipping & Handling: ${_orderResullt.value.orderDetails[0].shippingTotal}',
                          greenColor,
                          15),
                      customText(
                          'Service Fee: ${_orderResullt.value.orderDetails[0].serviceFee}',
                          greenColor,
                          15),
                      customText(
                          'Cupon Discount: ${_orderResullt.value.orderDetails[0].totalCouponDiscount}',
                          greenColor,
                          15),
                      customText(
                          'Sales Tax: ${_orderResullt.value.orderDetails[0].orderTaxTotal}',
                          greenColor,
                          15),
                      customText(
                          'Total: ${_orderResullt.value.orderDetails[0].orderFinalTotal}',
                          greenColor,
                          15),
                      customText(
                          'Order Date: ${_orderResullt.value.orderDetails[0].timeStamp}',
                          greenColor,
                          15),
                      customText(
                          'Delivery Option: ${_orderResullt.value.orderDetails[0].deliveryOption}',
                          greenColor,
                          15),
                      customText(
                          'Delivery Info: ${_orderResullt.value.orderDetails.first.deliveyInfo}',
                          greenColor,
                          15),
                      InkWell(
                        onTap: () {
                          _addDeliveryAddress();
                        },
                        child: customUnderlineText(
                            'Add a Delivery Address', blue, 15),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => InvoicePage(
                              ordNo: _orderResullt
                                  .value.orderDetails[0].productOrderId
                                  .toString()));
                        },
                        child: customUnderlineText('View Invoice', blue, 15),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          separatorBuilder: (_, __) => SizedBox(
                                height: 5,
                              ),
                          itemCount: _orderResullt.value.orderInfo.length,
                          itemBuilder: (_, int i) {
                            // print('len --- ${_orderResullt.value.orderInfo.length}');
                            var _orderInfoList = _orderResullt.value.orderInfo;
                            return _orderInfoList.length != 0
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(),
                                      Card(
                                        color: Colors.white70,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Center(
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "$imgBaseUrl${_orderInfoList[i].productImageUrl}",
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Text("img error"),
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage:
                                                        imageProvider,
                                                  ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              customText(
                                                  '${_orderInfoList[i].productName}',
                                                  blue,
                                                  15,
                                                  fontWeight: FontWeight.bold),
                                              customText(
                                                  '${_orderInfoList[i].price} | ${_orderInfoList[i].inStockOrOutOfStock}',
                                                  greenColor,
                                                  15),
                                              customRichText(
                                                  'For Sale By: ',
                                                  '${_orderInfoList[i].sellerNameMobile}',
                                                  black,
                                                  grey),
                                              customText(
                                                  'Quantity: ${_orderInfoList[i].quantity}',
                                                  grey,
                                                  15),
                                              customRichText(
                                                  'Status: ',
                                                  '${_orderInfoList[i].itemOrderStatus}',
                                                  Colors.orange,
                                                  black),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              _orderInfoList[i]
                                                          .itemStatusCode !=
                                                      1566
                                                  ?
                                                  // if (!orderStatus.toLowerCase().contains('cancel'))
                                                  SizedBox(
                                                      width: 1.sw,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          _cancelPrdById(
                                                              itemId: _orderInfoList[
                                                                      i]
                                                                  .productOrderLineItemId
                                                                  .toString());
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            primary: red,
                                                            onPrimary: white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10))),
                                                        child:
                                                            Text('Cancel Item'),
                                                      ),
                                                    )
                                                  : customText(
                                                      'Item cancelled by Customer',
                                                      red,
                                                      18),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : customText('No data available', red, 20);
                          }),
                    ],
                  ),
                ),
              )),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addDeliveryAddress() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Save Address'),
            content: StatefulBuilder(
              builder: (context, mState) {
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textField(fNameCtrl, 'Enter First-Name'),
                        textField(compCtrl, 'Enter Company-Name'),
                        textField(add1Ctrl, 'Enter Address1'),
                        textField(add2Ctrl, 'Enter Address2'),
                        textField(cityCtrl, 'Enter City'),
                        textField(areaCtrl, 'Enter Area'),
                        textField(zipCtrl, 'Enter Postal or Zip-Code'),
                        textField(phnCtrl, 'Enter Phone-Number'),
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
                                  child: Text('Jamaica'),
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
                                  _getState();
                                },
                                items: []),
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
                        textField(insCtrl, 'Enter Instructions'),
                        Row(
                          children: [
                            Flexible(
                              child: customText(
                                  'Check to make this your current order shipping address :',
                                  red,
                                  15.0),
                            ),
                            SizedBox(
                              width: 0.23.sw,
                            ),
                            Checkbox(
                              onChanged: (val) {
                                mState(() {
                                  valueFirst = val!;
                                });
                              },
                              value: valueFirst,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Save and Close'),
                onPressed: () {
                  saveDeliAdd();
                },
              ),
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
