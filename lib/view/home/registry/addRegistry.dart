import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/addedRegListModel.dart';
import 'package:altezar/models/registryListModel.dart';
import 'package:altezar/models/registryTypeCodeModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/home/autoParts/autoParts.dart';
import 'package:altezar/view/home/cart/cart.dart';
import 'package:altezar/view/home/deal/deals.dart';
import 'package:altezar/view/home/food/food.dart';
import 'package:altezar/view/home/grocery/grocery.dart';
import 'package:altezar/view/home/registry/viewListItems.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../productDetails.dart';

class AddRegistry extends StatefulWidget {
  @override
  _AddRegistryState createState() => _AddRegistryState();
}

class _AddRegistryState extends State<AddRegistry> {
  bool valueFirst = false;
  bool isLogin = true;
  TextEditingController searchController = TextEditingController();
  TextEditingController listNameController = TextEditingController();
  TextEditingController benefitNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context, StateSetter mState) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      mState(() {
        selectedDate = picked;
      });
  }

  var showRegistry =
      AddRegListModel(listOrRegistry: [], status: '', message: '').obs;
  // var newAddedRegistryList = <ListOrRegistry?>[].obs;
  var registryList = <RegistryList?>[].obs;
  // var registryTypeList = <ListType?>[].obs;
  List<ListType?> registryTypeList = [];
  String? _registryTypeId, _registryType;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getregistryList();
      cartBox();
      getRegistryType();
      _newRegList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: isLogin,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isLogin)
              FlatButton.icon(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    // Get.to(Intro());
                    // await networkcallService.getAllDropdownValue();
                  },
                  color: white,
                  icon: Icon(Icons.person),
                  label: Text('Sign In')),
            if (isLogin)
              SizedBox(
                width: 0.02.sw,
              ),
            Image.asset(
              appbarImg,
              height: 0.1.sh,
            ),
            Obx(() {
              // print('x');
              if (cartData.length > 0 && sp.isLogin() == true) {
                var data = cartData.first;
                return Flexible(
                  child: FlatButton.icon(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.to(() => CartPage());
                      },
                      color: white,
                      icon: Icon(Icons.shopping_cart_outlined),
                      label: Text('${data.orderCartCount}')),
                );
              }
              return Flexible(
                child: FlatButton.icon(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      gotoLoginPage();
                    },
                    color: white,
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: Text('0')),
              );
            })
          ],
        ),
        backgroundColor: appbarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: appbarColor,
                child: Row(
                  children: [
                    tabbarButton(() {
                      // Get.to(OnTapStore());
                    }, 'Quick Links :', white, 15.0),
                    tabbarButton(() {
                      Get.to(Deals());
                    }, 'Deals', Color(0xffDC7633), 15.0),
                    tabbarButton(() {
                      Get.to(Grocery());
                    }, 'Grocery', Color(0xff9457B0), 15.0),
                    tabbarButton(() {
                      Get.to(Food());
                    }, 'Food', Color(0xff2ECC71), 15.0),
                    tabbarButton(() {
                      Get.to(AutoParts());
                    }, 'Auto Parts', Color(0xffEC7063), 15.0),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 0.08.sh,
                      width: 1.sw,
                      child: button(() {
                        _addRegistry();
                      }, 'Create New List or Registry', buttonColor, white)),
                  SizedBox(
                    height: 15,
                  ),

                  /// ------------ added registry list ------------

                  SizedBox(
                      width: 1.sw,
                      child: Obx(() => showRegistry
                                  .value.listOrRegistry.length !=
                              0
                          ? ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (_, int i) {
                                return Card(
                                  color: grey,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                ' ${showRegistry.value.listOrRegistry[i].registryName} | Total items-${showRegistry.value.listOrRegistry[i].totalItems} | '),
                                            showRegistry.value.listOrRegistry[i]
                                                        .totalItems ==
                                                    '0'
                                                ? customInkWellText(() {
                                                    _showEmptyAlert();
                                                  }, 'View All', blue, 15)
                                                : TextButton(
                                                    onPressed: () {
                                                      Get.to(() => ViewListItems(
                                                          registryID: int.parse(
                                                              showRegistry
                                                                  .value
                                                                  .listOrRegistry[
                                                                      i]
                                                                  .registryId)));
                                                    },
                                                    child: Text('View All',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)))
                                          ],
                                        ),
                                        Text(
                                            'Registry-ID : ${showRegistry.value.listOrRegistry[i].registryId}'),
                                        Text(
                                            'Registry-type : ${showRegistry.value.listOrRegistry[i].registryType}'),
                                        Text(
                                            'Event Date : ${showRegistry.value.listOrRegistry[i].eventDate}'),
                                        Text(
                                            'Benifit Name : ${showRegistry.value.listOrRegistry[i].benefitName}'),
                                        Text(
                                            'Shipping Addrss : ${showRegistry.value.listOrRegistry[i].shippingAddress}'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        if (showRegistry.value.listOrRegistry[i]
                                                .listitemdata !=
                                            null)
                                          SizedBox(
                                            width: 1.sw,
                                            child: ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: showRegistry
                                                    .value
                                                    .listOrRegistry[i]
                                                    .listitemdata!
                                                    .length,
                                                itemBuilder: (_, int j) {
                                                  var listdata = showRegistry
                                                      .value
                                                      .listOrRegistry[i]
                                                      .listitemdata![j];
                                                  return Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                15, 0, 5, 0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.to(() =>
                                                                ProductDetailsPage(
                                                                  prdTypeId:
                                                                      '1',
                                                                  prdId:
                                                                      '${showRegistry.value.listOrRegistry[i].listitemdata![j].productId}',
                                                                ));
                                                          },
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                "$imgBaseUrl${listdata.productImageUrl}",
                                                            height: 0.25.sh,
                                                            width: 0.25.sw,
                                                            placeholder: (context,
                                                                    url) =>
                                                                Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.network(
                                                                    imageNotFound),
                                                          ),
                                                        ),
                                                      ),
                                                      customText(
                                                          '[Qty - ${listdata.qty}] ',
                                                          black,
                                                          15),
                                                      customText(
                                                          'Price- ${listdata.price}',
                                                          black,
                                                          15),
                                                      IconButton(
                                                          onPressed: () {
                                                            _removeRegistryItems(
                                                                pid: listdata
                                                                    .registryItemId);
                                                          },
                                                          icon: Icon(
                                                              Icons.close,
                                                              color: red))
                                                    ],
                                                  );
                                                }),
                                          ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  primary: red),
                                              onPressed: () {
                                                _deleteRegistry(showRegistry
                                                    .value
                                                    .listOrRegistry[i]
                                                    .registryId
                                                    .toString());
                                              },
                                              child: Text('Delete'),
                                            ),
                                            showRegistry.value.listOrRegistry[i]
                                                        .totalItems ==
                                                    '0'
                                                ? customInkWellText(() {
                                                    _showEmptyAlert();
                                                  }, 'Add list items to cart',
                                                    blue, 15)
                                                : TextButton(
                                                    style: TextButton.styleFrom(
                                                        primary: buttonColor),
                                                    onPressed: () {
                                                      _addAlltoCart(i);
                                                    },
                                                    child: Text(
                                                        'Add list items to cart'),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) => SizedBox(
                                    height: 10,
                                  ),
                              itemCount: showRegistry.value.listOrRegistry
                                  .length /*newAddedRegistryList.length*/)
                          : Center(
                              child: customText(
                                  'You have no list/registry', black, 15)))),
                  SizedBox(
                    height: 15,
                  ),
                  customText('Find List or Registry', black, 25.0),
                  SizedBox(
                    height: 15,
                  ),
                  searchField(
                      searchController, 'Search here your list or registry'),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 0.08.sh,
                      width: 1.sw,
                      child: button(() {
                        getregistryList();
                      }, 'Search', buttonColor, white)),
                  SizedBox(
                    height: 15,
                  ),
                  customText('List Information', black, 20.0),
                  Divider(),
                  Obx(() => SizedBox(
                        width: 1.sw,
                        child: ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => SizedBox(
                            height: 5,
                          ),
                          itemCount: registryList.length,
                          itemBuilder: (_, int i) {
                            return registryList.length == 0
                                ? customText('data not found', red, 20)
                                : Card(
                                    color: Colors.white24,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText(
                                              'Registry-ID : ${registryList[i]!.registryId}',
                                              black,
                                              16.0),
                                          customText(
                                              'Name : ${registryList[i]!.registryName}',
                                              black,
                                              16.0),
                                          customText(
                                              'Type : ${registryList[i]!.registryType}',
                                              black,
                                              16.0),
                                          customText(
                                              'Owner : ${registryList[i]!.fullname}',
                                              black,
                                              16.0),
                                          customText(
                                              'Benefit : ${registryList[i]!.benefitName}',
                                              black,
                                              16.0),
                                          customText(
                                              'Event Date : ${registryList[i]!.eventDate}',
                                              black,
                                              16.0),
                                          customText(
                                              'Shipping Address : ${registryList[i]!.shippingAddress}',
                                              black,
                                              16.0),
                                          customInkWellText(() {
                                            Get.to(() => ViewListItems(
                                                  registryID: registryList[i]!
                                                      .registryId,
                                                ));
                                          }, 'View List Items', buttonColor,
                                              18.0)
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addRegistry() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            scrollable: true,
            title: Text('Create New List or Registry'),
            content: StatefulBuilder(
              builder: (context, mState) {
                // print('$_registryType \n ${registryTypeList.length}');
                return SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      customText('List/Registry Type :', black, 15.0),
                      Card(
                        color: Color(0xffEDEDED),
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
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: customText('', black, 18.0),
                            ),
                            value: _registryType,
                            items: registryTypeList.map((value) {
                              return DropdownMenuItem<String>(
                                value: value!.registryTypeName,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    value.registryTypeName!,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              mState(() {
                                _registryType = value!;
                              });
                              _registryTypeId = registryTypeList
                                  .where((element) =>
                                      element!.registryTypeName ==
                                      _registryType)
                                  .toList()
                                  .first!
                                  .codeId
                                  .toString();
                              print('_registryTypeId - $_registryTypeId');
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      customText('List/Registry Name :', black, 15.0),
                      searchField(listNameController, 'List/Registry Name'),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          customText('Make it private :', black, 15.0),
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
                      SizedBox(
                        height: 15,
                      ),
                      customText('Benefit name :', black, 15.0),
                      searchField(benefitNameController, 'Benefit name'),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customText('Event Date :', black, 15.0),
                          SizedBox(
                            width: 40,
                          ),
                          Text("${selectedDate.toLocal()}".split(' ')[0]),
                          IconButton(
                            onPressed: () => _selectDate(context, mState),
                            icon: Icon(Icons.calendar_today),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      customText('Shipping Address :', black, 15.0),
                      searchField(addressController, 'Shipping Address '),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Save and Close'),
                onPressed: () {
                  if (listNameController.text.isEmpty) {
                    showToast('Please enter a Name', red);
                  } else if (benefitNameController.text.isEmpty) {
                    showToast('Please enter benefit Name', red);
                  } else if (_registryTypeId == null) {
                    showToast('Please select a Type', red);
                  } else {
                    _saveNewRegistry();
                  }
                },
              ),
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addAlltoCart(int i) async {
    showProgress(context);
    var res = await networkcallService.getAddRegistryItems(
        regID: showRegistry.value.listOrRegistry[i].registryId.toString(),
        userID: sp.getUserId().toString());
    hideProgress(context);
    if (res) {
      getregistryList();
      cartBox();
    }
  }

  void getRegistryType() async {
    showProgress(context);
    registryTypeList = await networkcallService.getListCodeTypeAPICall();
    hideProgress(context);
  }

  void getregistryList() async {
    showProgress(context);
    registryList.value =
        await networkcallService.getRegistryListAPICall(searchController.text);
    hideProgress(context);
  }

  void _newRegList() async {
    showProgress(context);
    showRegistry.value = (await networkcallService.getNewAddedRegListAPICall(
      pageIndex: '0',
      userID: sp.getUserId().toString(),
      registryId:
          _registryTypeId.toString() == '' ? '0' : _registryTypeId.toString(),
    ))!;
    hideProgress(context);
    getregistryList();
  }

  void _saveNewRegistry() async {
    showProgress(context);
    var resullt = await networkcallService.getAddRegistryAPICall(
      add: addressController.text,
      benifitName: benefitNameController.text,
      eventDate: selectedDate.toString(),
      isPrivate: valueFirst == false ? '0' : '1',
      name: listNameController.text,
      typeID: _registryTypeId.toString(),
      userID: sp.getUserId().toString(),
    );
    _newRegList();
    hideProgress(context);
    if (resullt) {
      Get.back();
      addressController.clear();
      benefitNameController.clear();
      listNameController.clear();
      _registryTypeId = null;
      _registryType = null;
      selectedDate = DateTime.now();
      valueFirst = false;
    }
  }

  void _deleteRegistry(String regiD) async {
    showProgress(context);
    var result = await networkcallService.getRemoveRegistryAPICall(
        regID: regiD, userID: sp.getUserId().toString());
    hideProgress(context);
    if (result) {
      _newRegList();
    }
  }

  void _removeRegistryItems({required String pid}) async {
    showProgress(context);
    var res = await networkcallService.getRemoveRegistryPoductsAPICall(
        registryItemId: pid);
    hideProgress(context);
    if (res) {
      _newRegList();
    }
  }

  Future<void> _showEmptyAlert() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                customText('No product avaiable here.', red, 16),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
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
