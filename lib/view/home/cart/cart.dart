import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/editedBankAcc.dart';
import 'package:altezar/models/getAddressList.dart';
import 'package:altezar/models/getCartOrderDetailsModel.dart';
import 'package:altezar/models/getDefAdd.dart';
import 'package:altezar/models/getDeliveryOptions.dart';
import 'package:altezar/models/getLists.dart';
import 'package:altezar/models/shippingCountryStateList.dart';
import 'package:altezar/models/shippingDeliverToHome.dart';
import 'package:altezar/models/shippingDelivertoPickup.dart';
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
  TextEditingController phnCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();
  TextEditingController updateQty = TextEditingController();
  String? _optionValue,
      _optionId,
      _countryValue,
      countryId,
      _stateValue,
      _stateId;
  var _optionDataList = <DeliveryOption>[].obs;
  bool isAddressShow = false;
  Rx<GetCartOrderDetails> _cartData = GetCartOrderDetails(
      message: '', status: '', cartProductList: [], orderDetails: []).obs;
  // List<CountryList> _countryList = [];
  var _shippingCountryList = <ShippingCountryList>[].obs;
  var _shippingStateList = <ShippingStateList>[].obs;
  final _formKey = GlobalKey<FormState>();
  var _addList = <ShippingAddressList>[].obs;
  var _defAdd = <DeaultAddress>[].obs;
  var _shippingHomeData = DeliverToHome(
          message: '', shippingOptionsHome: [], status: '', infoHome: "")
      .obs;
  var _shippingPickupData = DeliverToPickup(
          message: '', shippingOptionsPickup: [], status: '', infoPickup: "")
      .obs;

  var _pickAddress = 0.obs;
  var homeRadio = 0.obs;
  var pickupRadio = 0.obs;
  var _isDefaultAccount = false.obs;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _shippingCountryState();
      _shippingAddList();
    });
    _getCartPrdDetails();
    _shippingAddList();
    _defaultAddress();
    _homeShippingDelivary();
    _pickupShippingDelivary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: detailsPageAppBar()),
        body: Form(
          key: _formKey,
          child: Obx(() {
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

                      ///  --------------- deliver to home -----------
                      if (_optionId == '1524')
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                  'Your shipping address : ', black, 16.0,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                height: 10,
                              ),
                              _defAdd.length == 0
                                  ? customText(
                                      'You must have alteast one address to deliver.',
                                      red,
                                      16.0)
                                  :

                                  /// ------- default address ------------
                                  SizedBox(
                                      width: 1.sw,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          // primary: true,
                                          separatorBuilder: (_, __) => SizedBox(
                                                height: 10,
                                              ),
                                          itemCount: _defAdd.length,
                                          itemBuilder: (_, int i) {
                                            return Text(
                                                '${_defAdd[i].customerShippingAddress}');
                                          }),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        _addAddress();
                                      },
                                      child: customText(
                                        'Add Address  ||',
                                        blue,
                                        16.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  InkWell(
                                      onTap: () {
                                        _showAddressList();
                                      },
                                      child: customText(
                                        '  Change Address',
                                        blue,
                                        16.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              /// --------------- shipping home value ------
                              customText(
                                  'Please Select A Shipping Cost Option :\n',
                                  black,
                                  16.0),

                              SizedBox(
                                width: 1.sw,
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    separatorBuilder: (_, __) => SizedBox(
                                          height: 10,
                                        ),
                                    itemCount: _shippingHomeData
                                        .value.shippingOptionsHome.length,
                                    itemBuilder: (_, int i) {
                                      return Row(
                                        children: [
                                          Radio(
                                            onChanged: (val) {
                                              homeRadio.value = val as int;
                                              print('id- ${homeRadio.value}');
                                              setState(() {});
                                            },
                                            groupValue: homeRadio.value,
                                            value: _shippingHomeData
                                                .value
                                                .shippingOptionsHome[i]
                                                .deliveryCompanyServiceId,
                                          ),
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          '🚚 ${_shippingHomeData.value.shippingOptionsHome[i].serviceName} ${_shippingHomeData.value.shippingOptionsHome[i].shippingCost}',
                                                      style: TextStyle(
                                                          color: black,
                                                          fontSize: 17)),
                                                  TextSpan(
                                                      text:
                                                          '  ${_shippingHomeData.value.shippingOptionsHome[i].leadTime}',
                                                      style: TextStyle(
                                                          color: green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),

                              customText('${_shippingHomeData.value.infoHome}',
                                  red, 18.0,
                                  fontWeight: FontWeight.bold)
                            ],
                          ),
                        ),

                      ///  --------------- deliver to pickup location -----------
                      if (_optionId == '1525')
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                'Your shipping address : ',
                                black,
                                16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _defAdd.length == 0
                                  ? customText(
                                      'You must have alteast one address to deliver.',
                                      red,
                                      16.0)
                                  :

                                  /// ------- default address ------------
                                  SizedBox(
                                      width: 1.sw,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          // primary: true,
                                          separatorBuilder: (_, __) => SizedBox(
                                                height: 10,
                                              ),
                                          itemCount: _defAdd.length,
                                          itemBuilder: (_, int i) {
                                            return Text(
                                                '${_defAdd[i].customerShippingAddress}');
                                          }),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        _addAddress();
                                      },
                                      child: customText(
                                        'Add Address  ||',
                                        blue,
                                        16.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  InkWell(
                                      onTap: () {
                                        _showAddressList();
                                      },
                                      child: customText(
                                        '  Change Address',
                                        blue,
                                        16.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              /// --------------- shipping pickup value ------

                              customText(
                                  'Please Select Your Pickup Location:\n',
                                  black,
                                  16.0),
                              _shippingPickupData.value.shippingOptionsPickup!
                                          .length ==
                                      0
                                  ? SizedBox(
                                      width: 1.sw,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          primary: false,
                                          separatorBuilder: (_, __) => SizedBox(
                                                height: 10,
                                              ),
                                          itemCount: _shippingPickupData.value
                                              .shippingOptionsPickup!.length,
                                          itemBuilder: (_, int i) {
                                            return Row(
                                              children: [
                                                Radio(
                                                  onChanged: (val) {
                                                    pickupRadio.value =
                                                        val as int;
                                                    print(
                                                        'id- ${pickupRadio.value}');
                                                    // setState(() {});
                                                  },
                                                  groupValue: pickupRadio.value,
                                                  value: _shippingPickupData
                                                      .value
                                                      .shippingOptionsPickup![i]
                                                      .deliveryCompanyId,
                                                ),
                                                Flexible(
                                                    child: customText(
                                                        '🚚 ${_shippingPickupData.value.shippingOptionsPickup![i].serviceName} ${_shippingPickupData.value.shippingOptionsPickup![i].customerPickUpLocation} ${_shippingPickupData.value.shippingOptionsPickup![i].shippingCost}',
                                                        black,
                                                        16.0)),
                                              ],
                                            );
                                          }),
                                    )
                                  : customText(
                                      'No Pickup Location Available', red, 16.0,
                                      fontWeight: FontWeight.bold),
                              customText(
                                  '${_shippingPickupData.value.infoPickup}',
                                  red,
                                  18.0,
                                  fontWeight: FontWeight.bold)
                            ],
                          ),
                        ),

                      /// ------------------------
                      // if (isAddressShow)
                      //   InkWell(
                      // onTap: () {
                      //   _addAddress();
                      // },
                      //     child: Container(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           customText(
                      //               'Your shipping address :', black, 16.0),
                      //           customText(
                      //               'You must have alteast one address to deliver.',
                      //               red,
                      //               16.0),
                      //           customText('Add Address', blue, 16.0),
                      //         ],
                      //       ),
                      //     ),
                      // ),

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
                            _orderDetails.subtotal != null
                                ? customText(
                                    'Subtotal for ${_orderDetails.orderCartCount} items: JMD\$${_orderDetails.subtotal}',
                                    black,
                                    18.0,
                                    fontWeight: FontWeight.w400)
                                : customText('Subtotal for 0 items: JMD\$0.00',
                                    black, 18.0),
                            SizedBox(
                              height: 5,
                            ),
                            _orderDetails.subtotal != null
                                ? customText(
                                    'Service fees: JMD\$${_orderDetails.serviceFee}',
                                    black,
                                    14.0,
                                    fontWeight: FontWeight.bold)
                                : customText(
                                    'Service fees: JMD\$0.00', black, 18.0),
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
                            _orderDetails.totalCost != null
                                ? customText(
                                    'Total Order: JMD\$${_orderDetails.totalCost}',
                                    Color(0xffFF0000),
                                    20.0,
                                    fontWeight: FontWeight.bold)
                                : customText('Total Order: JMD\$0.00',
                                    Color(0xffFF0000), 20.0,
                                    fontWeight: FontWeight.bold),
                            SizedBox(
                              height: 5,
                            ),
                            _orderDetails.totalCostInUsd != null
                                ? customText(
                                    'Total in USD: \$${_orderDetails.totalCostInUsd}',
                                    black,
                                    18.0,
                                    fontWeight: FontWeight.w400)
                                : customText(
                                    'Total in USD: \$0.00', black, 18.0,
                                    fontWeight: FontWeight.w400),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                                width: 0.8.sw,
                                child: searchField(
                                    cuponCode, 'Enter coupon Code')),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                height: 0.07.sh,
                                width: 0.8.sw,
                                child: button(() {
                                  applyCuponCode();
                                }, 'Apply', grey, white)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.network(imageNotFound),
                                          ),
                                        ),
                                        _prdDetailsList[i].productName == null
                                            ? Text('No product name available')
                                            : customText(
                                                '${_prdDetailsList[i].productName}',
                                                blue,
                                                16),
                                        _prdDetailsList[i].price == null
                                            ? Text('No price available')
                                            : customText(
                                                '${_prdDetailsList[i].price}',
                                                green,
                                                16),
                                        _prdDetailsList[i].price == null
                                            ? Text('No quantity available')
                                            : customText(
                                                'Quantity - ${_prdDetailsList[i].quantity}',
                                                green,
                                                16),
                                        InkWell(
                                            onTap: () {
                                              _qtyUpdateBox();
                                            },
                                            child: customText(
                                                'Change Quantity', blue, 16,
                                                fontWeight: FontWeight.bold)),
                                        _prdDetailsList[i].shippingInfo == null
                                            ? Text('No Shipping Info available')
                                            : customText(
                                                '${_prdDetailsList[i].shippingInfo}',
                                                green,
                                                16),
                                        _prdDetailsList[i].sellerName == null
                                            ? Text('No sellerName available')
                                            : customText(
                                                '${_prdDetailsList[i].sellerName}',
                                                grey,
                                                16),
                                        InkWell(
                                            onTap: () {
                                              removeCartItem();
                                            },
                                            child: customText('Delete', red, 16,
                                                fontWeight: FontWeight.bold)),
                                        InkWell(
                                          onTap: () => _sellerNotes(),
                                          child: customText(
                                              'Add note to seller', blue, 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        _prdDetailsList[i].notes != null
                                            ? customText(
                                                '${_prdDetailsList[i].notes}',
                                                black,
                                                16)
                                            : SizedBox(
                                                height: 10,
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                      SizedBox(
                        height: 35,
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
          }),
        ));
  }

  void _getData() async {
    _optionDataList.value =
        (await networkcallService.getDeliveryOptionsAPICall())!;
  }

  void _getCartPrdDetails() async {
    _cartData.value = (await networkcallService
        .getCartOrderDetailsAPICall(sp.getUserId().toString()))!;
  }

  void _shippingCountryState() async {
    var shippingData =
        await networkcallService.getShippingCountryStateAPICall();
    _shippingCountryList.value = shippingData!.shippingcountryList;
    _shippingStateList.value = shippingData.shippingstateList;
  }

  void _shippingAddList() async {
    _addList.value = (await networkcallService
        .getAddressListAPICall(sp.getUserId().toString()))!;
 
  }

  void _defaultAddress() async {
    _defAdd.value = (await networkcallService
        .getDefaultAddAPICall(sp.getUserId().toString()))!;
  }

  void _homeShippingDelivary() async {
    _shippingHomeData.value = (await networkcallService
        .getShippingAeliverToHome(sp.getUserId().toString()))!;
  }

  void _pickupShippingDelivary() async {
    var result = await networkcallService
        .getShippingAeliverToPickup(sp.getUserId().toString());
    if (result != null) {
      _shippingPickupData.value = result;
    }
  }

  void _shippingAddress() async {
    showProgress(context);
    var data = await networkcallService.getAddAddressAPICall(
        sp.getUserId().toString(),
        nameCtrl.text,
        companyCtrl.text,
        add1Ctrl.text,
        add2Ctrl.text,
        areaCtrl.text,
        addCtrl.text,
        _stateId.toString(),
        zipCtrl.text,
        countryId.toString(),
        _isDefaultAccount.value == false ? '0' : '1',
        phnCtrl.text,
        noteCtrl.text);
    hideProgress(context);
    if (data) {
      nameCtrl.clear();
      companyCtrl.clear();
      add1Ctrl.clear();
      add2Ctrl.clear();
      areaCtrl.clear();
      addCtrl.clear();
      zipCtrl.clear();
      phnCtrl.clear();
      noteCtrl.clear();
      _stateValue = null;
      _countryValue = null;
      _isDefaultAccount.value = false;

      _defaultAddress();
      Get.back();
    }
  }

  void addNotetoSeller() async {
    showProgress(context);
    var data = await networkcallService.getAddNotestoSeller(
        noteCtrl.text.toString(),
        _cartData.value.cartProductList.first.productCartItemId.toString());
    hideProgress(context);
    if (data) {
      noteCtrl.clear();
      _getCartPrdDetails();
      Get.back();
    }
  }

  void removeCartItem() async {
    showProgress(context);
    var data = await networkcallService.getRemoveCartProduct(
        sp.getUserId().toString(),
        _cartData.value.cartProductList.first.productCartItemId.toString());
    hideProgress(context);
    if (data) {
      _getCartPrdDetails();
    }
  }

  void updateAddressDefault() async {
    showProgress(context);
    var data = await networkcallService.getUpdateAddressDefault(
        sp.getUserId().toString(), _pickAddress.value.toString());
    hideProgress(context);
    if (data) {
      _defaultAddress();
      Get.back();
    }
  }

  void cartQtyUpdate() async {
    showProgress(context);
    var cartQty = await networkcallService.getIncreasedCartPrd(updateQty.text,
        _cartData.value.cartProductList.first.productCartItemId.toString());
    hideProgress(context);
    if (cartQty) {
      updateQty.clear();
      _getCartPrdDetails();
      Get.back();
    }
  }

  void applyCuponCode() async {
    showProgress(context);
    var _cupon = await networkcallService.getApplyCuponCode(
        cuponCode.text, sp.getUserId().toString());
    hideProgress(context);
    if (_cupon) {
      cuponCode.clear();
      _getCartPrdDetails();
    }
  }

  Future<void> _qtyUpdateBox() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Quantity :'),
          content: StatefulBuilder(
            builder: (context, mState) {
              return Container(
                height: 0.2.sh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText('Enter quantity :', black, 16.0,
                        fontWeight: FontWeight.bold),
                    searchField(updateQty, 'Enter quantity'),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save and Close'),
              onPressed: () {
                cartQtyUpdate();
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
      },
    );
  }

  Future<void> _sellerNotes() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a note to seller :'),
          content: StatefulBuilder(
            builder: (context, mState) {
              return Container(
                height: 0.2.sh,
                child: Column(
                  children: [
                    customText(
                        'Enter A Quick Note To The Seller About Your Order :',
                        black,
                        16.0,
                        fontWeight: FontWeight.bold),
                    searchField(noteCtrl, 'Add a note'),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save and Close'),
              onPressed: () {
                addNotetoSeller();
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
      },
    );
  }

  Future<void> _showAddressList() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chnage Shipping Address'),
          content: StatefulBuilder(
            builder: (context, mState) {
              return Obx(() => SizedBox(
                    width: 1.sw,
                    child: SizedBox(
                      width: 1.sw,
                      child: ListView.separated(
                          shrinkWrap: true,
                          // primary: true,
                          separatorBuilder: (_, __) => SizedBox(
                                height: 10,
                              ),
                          itemCount: _addList.length,
                          itemBuilder: (_, int i) {
                            return Row(
                              children: [
                                Radio(
                                  onChanged: (val) {
                                    _pickAddress.value = val as int;
                                    print('id- ${_pickAddress.value}');
                                    mState(() {});
                                  },
                                  groupValue: _pickAddress.value,
                                  value: _addList[i].userAddressId,
                                ),
                                Flexible(
                                  child: customText(
                                      '${_addList[i].customerShippingAddress}',
                                      black,
                                      16.0),
                                ),
                              ],
                            );
                          }),
                    ),
                  ));
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save and Close'),
              onPressed: () {
                updateAddressDefault();
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
      },
    );
  }

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
                                padding: EdgeInsets.only(left: 8.0),
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
                              mState(() {
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
                    searchField(zipCtrl, 'ZIP Code'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(phnCtrl, 'Enter Phone Number'),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    searchField(noteCtrl, 'Enter note'),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (nameCtrl.text.isEmpty) {
                    getSnackbar(
                      'Enter Country',
                      red,
                    );
                  } else if (add1Ctrl.text.isEmpty) {
                    getSnackbar(
                      'Enter Address',
                      red,
                    );
                  } else if (add2Ctrl.text.isEmpty) {
                    getSnackbar(
                      'Enter Address',
                      red,
                    );
                  } else if (addCtrl.text.isEmpty) {
                    getSnackbar(
                      'Enter City/Town/District',
                      red,
                    );
                  } else if (areaCtrl.text.isEmpty) {
                    getSnackbar(
                      'Enter your area',
                      red,
                    );
                  } else if (zipCtrl.text.isEmpty) {
                    getSnackbar(
                      'ZIP code missing',
                      red,
                    );
                  } else if (noteCtrl.text.isEmpty) {
                    getSnackbar(
                      'Phone number can\'t be empty',
                      red,
                    );
                  } else if (_stateValue!.isEmpty) {
                    getSnackbar(
                      'Select your state',
                      red,
                    );
                  } else if (_countryValue!.isEmpty) {
                    getSnackbar(
                      'Select your country',
                      red,
                    );
                  } else {
                    _shippingAddress();
                  }
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
