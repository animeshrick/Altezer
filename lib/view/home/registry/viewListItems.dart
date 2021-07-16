import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/RegistryItemListByRegIdModel.dart';
import 'package:altezar/models/registryInfoModel.dart';
import 'package:altezar/models/registryListModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/home/autoParts/autoParts.dart';
import 'package:altezar/view/home/cart/cart.dart';
import 'package:altezar/view/home/deal/deals.dart';
import 'package:altezar/view/home/food/food.dart';
import 'package:altezar/view/home/grocery/grocery.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../productDetails.dart';

class ViewListItems extends StatefulWidget {
  final int registryID;

  const ViewListItems({Key? key, required this.registryID}) : super(key: key);
  @override
  _ViewListItemsState createState() => _ViewListItemsState();
}

class _ViewListItemsState extends State<ViewListItems> {
  bool isLogin = true;

  TextEditingController searchController = TextEditingController();

  var _regInfoList = <RegistryInfo?>[].obs;
  var _regListInfoList = <ListOfRegistryItem?>[].obs;
  RxBool isShowMessage = false.obs;

  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _registryInfo();
      _registryListInfo();
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
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_regInfoList.length > 0)
                      customText(
                          '${_regInfoList[0]!.registryName} || Total items : ${_regInfoList[0]!.totalItems} || \nList/Registry Type : ${_regInfoList[0]!.registryType}',
                          black,
                          22.0),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 1.sw,
                      child: ElevatedButton.icon(
                        label: Text('Add all to cart'),
                        icon: Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          _addAlltoCart();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: white,
                            onPrimary: black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        // child: Text('Save'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    isShowMessage.value
                        ? Center(
                            child: customText('Data not available', red, 20),
                          )
                        : SizedBox(
                            width: 1.sw,
                            child: ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              separatorBuilder: (_, __) => SizedBox(
                                height: 10,
                              ),
                              itemCount: _regListInfoList.length,
                              itemBuilder: (_, int i) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => ProductDetailsPage(
                                          prdTypeId: '2',
                                          prdId:
                                              '${_regListInfoList[i]!.yjProductId}',
                                        ));
                                  },
                                  child: Card(
                                    // color: grey,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 10, 10),
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                "$imgBaseUrl${_regListInfoList[i]!.productImageUrl}",
                                            height: 0.25.sh,
                                            width: 0.25.sw,
                                            // width: 1.sw,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.network(imageNotFound),
                                          ),
                                          SizedBox(
                                            width: 0.07.sw,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                customText(
                                                    '${_regListInfoList[i]!.productName}',
                                                    buttonColor,
                                                    16.0),
                                                customText(
                                                    '${_regListInfoList[i]!.price} | ${_regListInfoList[i]!.inStockOrOutOfStock}',
                                                    greenColor,
                                                    16.0),
                                                customText(
                                                    'By : ${_regListInfoList[i]!.sellerName}',
                                                    grey,
                                                    16.0),
                                                customText(
                                                    'Qty: ${_regListInfoList[i]!.qty}',
                                                    black,
                                                    16.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        _removeRegistryItems(
                                                            pid: _regListInfoList[
                                                                    i]!
                                                                .registryItemId
                                                                .toString());
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          primary:
                                                              removeBtnColor,
                                                          onPrimary: white,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      child: Text('Remove'),
                                                    ),
                                                    ElevatedButton.icon(
                                                      label: Text('Add'),
                                                      icon: Icon(Icons
                                                          .shopping_cart_outlined),
                                                      onPressed: () {
                                                        _addToCart(
                                                            '${_regListInfoList[i]!.yjProductId}',
                                                            '${_regListInfoList[i]!.clientId}',
                                                            'Products',
                                                            '',
                                                            '',
                                                            1.toString(),
                                                            '',
                                                            '',
                                                            sp
                                                                .getUserId()
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
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  void _registryInfo() async {
    showProgress(context);
    _regInfoList.value = await networkcallService
        .getViewRegistryInfo(widget.registryID.toString());
    hideProgress(context);
  }

  void _registryListInfo() async {
    showProgress(context);
    _regListInfoList.value = await networkcallService.getRegistryListInfo(
        widget.registryID.toString(), '0');
    hideProgress(context);
    if (_regListInfoList.length == 0) {
      isShowMessage.value = true;
    } else
      isShowMessage.value = false;
  }

  void _removeRegistryItems({required String pid}) async {
    showProgress(context);
    var res = await networkcallService.getRemoveRegistryPoductsAPICall(
        registryItemId: pid);
    hideProgress(context);
    if (res) {
      _registryListInfo();
    }
  }

  void _addAlltoCart() async {
    showProgress(context);
    var res = await networkcallService.getAddRegistryItems(
        regID: widget.registryID.toString(), userID: sp.getUserId().toString());
    hideProgress(context);
    if (res) {
      _registryListInfo();
      cartBox();
    }
  }

  void _addToCart(
      String prdID,
      String clientId,
      String orderType,
      String selectedStyle,
      String mtoInfo,
      String qty,
      String mtoDelivaryDate,
      String mtoImgPath,
      String userId) async {
    showProgress(context);
    var data = await networkcallService.addToCartAPICall(
        prdID,
        clientId,
        orderType,
        selectedStyle,
        mtoInfo,
        qty,
        mtoDelivaryDate,
        mtoImgPath,
        userId);
    hideProgress(context);
  }
}
