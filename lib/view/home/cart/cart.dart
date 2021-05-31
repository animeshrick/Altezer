import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getCartOrderDetailsModel.dart';
import 'package:altezar/models/getDeliveryOptions.dart';
import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/shippingCountryStateList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  TextEditingController cuponCode = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController companyCtrl = TextEditingController();
  TextEditingController add1Ctrl = TextEditingController();
  TextEditingController add2Ctrl = TextEditingController();
  TextEditingController addCtrl = TextEditingController();
  TextEditingController areaCtrl = TextEditingController();
  TextEditingController zipCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();
  String? _optionValue, _optionId, _countryValue, countryId,_stateValue,_stateId;
  var _optionDataList = <DeliveryOption>[].obs;
  bool isAddressShow = false;
  Rx<GetCartOrderDetails> _cartData = GetCartOrderDetails(
      message: '', status: '', cartProductList: [], orderDetails: []).obs;
  // List<CountryList> _countryList = [];
  var _shippingCountryList = <ShippingCountryList>[].obs;
  var _shippingStateList = <ShippingStateList>[].obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
    _shippingCountryState();
    });
    _getCartPrdDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: detailsPageAppBar()),
        body: Obx(() {
          if (_cartData.value.status == '')
            return Center(
              child: CupertinoActivityIndicator(
                radius: 50,
              ),
            );
          else {
            var _prdDetailsList = _cartData.value.cartProductList;
            var _orderDetails = _cartData.value.orderDetails.first;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText('Delivery Options :', red, 20.0),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      color: Color(0xffEDEDED),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            elevation: 16,
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: grey,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: white,
                                  size: 30,
                                )),
                            isExpanded: true,
                            value: _optionValue, //'Delivery Option'
                            hint: Text('Delivery Option'),
                            items: _optionDataList.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.deliveryName,
                                child: Text(
                                  value.deliveryName,
                                  style: TextStyle(fontSize: 18),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              if (value!.toLowerCase().contains('deliver to'))
                                isAddressShow = true;
                              else
                                isAddressShow = false;

                              setState(() {
                                _optionValue = value;
                              });
                              _optionId = _optionDataList
                                  .where((element) =>
                                      element.deliveryName == _optionValue)
                                  .toList()
                                  .first
                                  .deliveryId
                                  .toString();

                              print('_optionId  $_optionId');
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (isAddressShow)
                      InkWell(
                        onTap: () {
                          _addAddress();
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                  'Your shipping address :', black, 16.0),
                              customText(
                                  'You must have alteast one address to deliver.',
                                  red,
                                  16.0),
                              customText('Add Address', blue, 16.0),
                            ],
                          ),
                        ),
                      ),

                    /// order details --------------------------------------------
                   
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: black)),
                      child: Column(
                        children: [
                          customText(
                              'Debit & Credit card Accepted', black, 18.0,
                              fontWeight: FontWeight.w400),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                card1,
                                height: 50,
                                width: 50,
                              ),
                              Image.asset(
                                card2,
                                height: 50,
                                width: 50,
                              ),
                              Image.asset(
                                card3,
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customText(
                              'Subtotal for ${_orderDetails.orderCartCount} items: JMD\$${_orderDetails.subtotal}',
                              black,
                              18.0,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 5,
                          ),
                          customText(
                              'Service fees: JMD\$${_orderDetails.serviceFee}',
                              black,
                              14.0,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 5,
                          ),
                          customText(
                              'Shipping and handling: JMD\$${_orderDetails.shippingCost}',
                              black,
                              18.0,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 5,
                          ),
                          customText(
                              'All taxes: JMD\$${_orderDetails.salesTax}',
                              black,
                              18.0,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 15,
                          ),
                          customText(
                              'Total Order: JMD\$${_orderDetails.totalCost}',
                              Color(0xffFF0000),
                              20.0,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 5,
                          ),
                          customText(
                              'Total in USD: \$${_orderDetails.totalCostInUsd}',
                              black,
                              18.0,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                              width: 0.8.sw,
                              child: searchField(cuponCode, 'Enter Code')),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 0.07.sh,
                              width: 0.8.sw,
                              child: button(() {}, 'Apply', grey, white)),
                          SizedBox(
                            height: 15,
                          ),
                          customText(
                              '\$200.00 JMD Minimum Required To Pay With Card',
                              Color(0xffFF0000),
                              18.0,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 0.8.sw,
                            height: 0.09.sh,
                            child: button(
                                () {},
                                'Logon to xyz.com to pay with card',
                                Colors.blue,
                                white),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Why ?',
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                )),
                          ),
                          customText('OR', black, 20.0,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 0.8.sw,
                            height: 0.09.sh,
                            child: button(() {}, 'Pick-up and Pay-in-store',
                                Colors.orange, white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          customText('OR', black, 20.0,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 0.8.sw,
                            height: 0.09.sh,
                            child: button(() {}, 'Pay cash on delivary',
                                Colors.green, white),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Learn More',
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(checkout),
                              Image.asset(strip)
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    _prdDetailsList.length == 0
                        ? Center(
                            child: customText('Your cart is empty', red, 25.0,
                                fontWeight: FontWeight.w400),
                          )
                        :

                        /// prd list -------------------------------------------------
                        ListView.separated(
                            separatorBuilder: (_, __) => SizedBox(
                                  height: 12,
                                ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _prdDetailsList.length,
                            itemBuilder: (_, i) {
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Center(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$imgBaseUrl${_prdDetailsList[i].productImageUrl}",
                                          height: 0.2.sh,
                                          width: 0.3.sw,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.network(imageNotFound),
                                        ),
                                      ),
                                      customText(
                                          '${_prdDetailsList[i].productName}',
                                          blue,
                                          16),
                                      customText(
                                          '${_prdDetailsList[i].price} for quantity of ${_prdDetailsList[i].quantity}',
                                          green,
                                          16),
                                      customText('Change Quantity', blue, 16),
                                      customText(
                                          '${_prdDetailsList[i].shippingInfo}',
                                          green,
                                          16),
                                      customText(
                                          '${_prdDetailsList[i].sellerName}',
                                          grey,
                                          16),
                                      customText('Delete', red, 16),
                                      customText(
                                          'Add note to seller', blue, 16),
                                    ],
                                  ),
                                ),
                              );
                            }),
                    SizedBox(
                      height: 25,
                    ),
                    customText(
                        '© 2021 - YeahJamaica.com a Product of CITS Jamaica Limited',
                        black,
                        18.0,
                        fontWeight: FontWeight.w400),
                  ],
                ),
              ),
            );
          }
        }));
  }

  void _getData() async {
    _optionDataList.value =
        (await networkcallService.getDeliveryOptionsAPICall())!;
  }

  void _getCartPrdDetails() async {
    _cartData.value = (await networkcallService
        .getCartOrderDetailsAPICall(sp.getUserId().toString()))!;
  }

  // void _getDropDownData() async {
  //   // showProgress(context);
  //   final response = await networkcallService.getAllDropdownValue();
  //   // hideProgress(context);
  //   _countryList = response!.countryList;
  //   // _monthDayList = response.monthDayList;
  //   // _monthNumberList = response.monthNumberList;
  //   // _yearList = response.yearList;
  //   // _genderList = response.genderList;
  //   setState(() {});
  // }

  void _shippingCountryState() async {
    var shippingData =
        await networkcallService.getShippingCountryStateAPICall();
    _shippingCountryList.value = shippingData!.shippingcountryList;
    _shippingStateList.value = shippingData.shippingstateList;
  }

  var _isDefaultAccount = false.obs;
  Future<void> _addAddress() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Address'),
          content: StatefulBuilder(builder: (context, mState) {
            return Obx(() {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
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
                            countryId = _shippingCountryList
                                .where((element) =>
                                    element.shippingCountry == _countryValue)
                                .toList()[0]
                                .countryId
                                .toString();
                            print('countryId --->$countryId');
                          },
                          items: _shippingCountryList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value.shippingCountry,
                              child: Padding(
                                padding:  EdgeInsets.only(left:8.0),
                                child: Text(
                                  value.shippingCountry,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(nameCtrl, 'Enter Full Name'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(companyCtrl, 'Company Name(Optional)'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(add1Ctrl, 'Enter Address1'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(add2Ctrl, 'Enter Address2'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(addCtrl, 'City/Town/Dist'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(areaCtrl, 'Area'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      color: Color(0xffEDEDED),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            elevation: 16,
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: grey,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: white,
                                  size: 30,
                                )),
                            isExpanded: true,
                            value: _stateValue, 
                            hint: Text('Parish/State/Province'),
                            items: _shippingStateList.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.shippingState,
                                child: Text(
                                  value.shippingState,
                                  style: TextStyle(fontSize: 18),
                                ),
                              );
                            }).toList(),
                           onChanged: (String? newValue) {
                            setState(() {
                              _stateValue = newValue!;
                            });
                            _stateId = _shippingStateList
                                .where((element) =>
                                    element.shippingState == _stateValue)
                                .toList()[0]
                                .parishOrStateId
                                .toString();
                            print('_stateId --->$_stateId');
                          },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(zipCtrl, 'ZIP COde'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(noteCtrl, 'Enter ote'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _isDefaultAccount.value,
                            onChanged: (val) {
                              _isDefaultAccount.value = val!;
                            }),
                        customText('Make your default address', black, 16)
                      ],
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                  ],
                ),
              );
            });
          }),
          actions: <Widget>[
            TextButton(
              child: const Text('Save and Close'),
              onPressed: () {},
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
