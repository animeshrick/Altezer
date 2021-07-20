import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/autoPartsListModel.dart';
import 'package:altezar/models/getAutoPartsCat.dart';
import 'package:altezar/models/getAutoPartsSubCat.dart';
import 'package:altezar/models/getCartBox.dart';
import 'package:altezar/models/getSortByData.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/home/cart/cart.dart';
import 'package:altezar/view/home/productDetails.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AutoParts extends StatefulWidget {
  @override
  _AutoPartsState createState() => _AutoPartsState();
}

class _AutoPartsState extends State<AutoParts> {
  TextEditingController searchController = TextEditingController();

  String? _autoCatVal, _autoSubCatVal, _sortingValue;
  String? _autoCatId, _autoSubCatId, _sortId;

  List<AutoPartsCategory>? _autoPartsCategoryList;
  List<AutoPartsSubcategory>? _autoPartsSubCategoryList;

  List<GetSortByData> _sortingDataList = [];
  final _listContr = ScrollController();
  int _pageIndex = 0;
  var _autoPartsList = <AutoPartsList>[].obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _getSortData();
      cartBox();
      _autoPartsData();
    });

    _listContr.addListener(() {
      if (_listContr.position.pixels == _listContr.position.maxScrollExtent &&
          _autoCatId != null) {
        print('contr- ${_listContr.position.pixels}');
        _pageIndex++;
        _autoPartsData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: appbarColor,
          title: Row(
            children: [
              IconButton(
                  onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
              // FlatButton.icon(
              //     padding: EdgeInsets.zero,
              //     onPressed: () {
              //       Get.back();
              //     },
              //     color: white,
              //     icon: CircleAvatar(
              //         radius: 15,
              //         backgroundColor: grey,
              //         child: Icon(
              //           Icons.home,
              //           color: white,
              //         )),
              //     label: customText("Home", black, 15.0)),
              SizedBox(
                width: 0.2.sw,
              ),
              Image.asset(
                appbarImg,
                height: 0.1.sh,
              ),
            ],
          ),
        ),
        body: Obx(
          () => Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  controller: _listContr,
                  child: Column(
                    children: [
                      Image.asset(autoParts),
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
                              value: _autoCatVal,
                              hint: Text('Parts Category'),
                              items: _autoPartsCategoryList?.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(
                                    value.name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _autoCatVal = value!;
                                });
                                _autoCatId = _autoPartsCategoryList!
                                    .where((element) =>
                                        element.name == _autoCatVal)
                                    .toList()
                                    .first
                                    .productCategorySub1Id
                                    .toString();
                                print('_autoCatId  $_autoCatId');
                                _autoPartsList.clear();
                                _pageIndex = 0;
                                _getSubAutoCat(_autoCatId!);
                              },
                            ),
                          ),
                        ),
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
                              value: _autoSubCatVal,
                              hint: Text('Parts Sub-Category'),
                              items: _autoPartsSubCategoryList?.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.subname,
                                  child: Text(
                                    value.subname,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _autoSubCatVal = value!;
                                });
                                _autoSubCatId = _autoPartsSubCategoryList!
                                    .where((element) =>
                                        element.subname == _autoSubCatVal)
                                    .toList()
                                    .first
                                    .productCategorySub2Id
                                    .toString();
                                print('_autoSubCatId  $_autoSubCatId');
                                _pageIndex = 0;
                                _autoPartsList.clear();
                                _autoPartsData();
                              },
                            ),
                          ),
                        ),
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
                              value: _sortingValue, //'Sort By',
                              hint: Text('Choose a sorting option'),
                              items: _sortingDataList.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.sortName,
                                  child: Text(
                                    value.sortName,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _sortingValue = value!;
                                });
                                _sortId = _sortingDataList
                                    .where((element) =>
                                        element.sortName == _sortingValue)
                                    .toList()
                                    .first
                                    .sortId
                                    .toString();
                                print('_sortId  $_sortId');
                                _autoPartsList.clear();
                                _pageIndex = 0;
                                _autoPartsData();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      searchField(searchController,
                          'Search Product Name, Brand etc ...'),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          height: 0.07.sh,
                          width: 1.sw,
                          child: button(() {
                            // print('x');
                            _autoPartsList.clear();
                            _autoPartsData();
                          }, 'Search', Color(0xffEC971F), white)),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 1.sw,
                        child: ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          separatorBuilder: (_, __) => SizedBox(
                            height: 5,
                          ),
                          itemCount: _autoPartsList.length,
                          itemBuilder: (_, int i) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => ProductDetailsPage(
                                      prdTypeId: '2',
                                      prdId: '${_autoPartsList[i].yjProductId}',
                                    ));
                              },
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "$imgBaseUrl${_autoPartsList[i].productImageUrl}",
                                        width: 0.3.sw,
                                        height: 0.2.sh,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
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
                                            Text(
                                                '${_autoPartsList[i].productName}',
                                                // overflow:
                                                //     TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue)),
                                            Text('${_autoPartsList[i].price}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: priceTextColor)),
                                            _autoPartsList[i].size != null
                                                ? Text(
                                                    '${_autoPartsList[i].size} | By: ${_autoPartsList[i].sellerName}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: grey))
                                                : Text(
                                                    ' | By: ${_autoPartsList[i].sellerName}',
                                                    // overflow: TextOverflow
                                                    //     .ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: grey)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                button(() {
                                                  // print(
                                                  //     'frf ${list[i].yjProductId}');
                                                  Get.to(
                                                      () => ProductDetailsPage(
                                                            prdTypeId: '2',
                                                            prdId:
                                                                '${_autoPartsList[i].yjProductId}',
                                                          ));
                                                }, 'Details', greenColor,
                                                    white),
                                                sp.isLogin() == true
                                                    ? cartButton(() {
                                                        _addToCart(
                                                            '${_autoPartsList[i].yjProductId}',
                                                            '${_autoPartsList[i].clientId}',
                                                            'AutoParts',
                                                            '',
                                                            '',
                                                            1.toString(),
                                                            '',
                                                            '',
                                                            sp
                                                                .getUserId()
                                                                .toString());
                                                      }, 'Add', priceTextColor,
                                                        white)
                                                    : cartButton(
                                                        () => gotoLoginPage(),
                                                        'Add',
                                                        priceTextColor,
                                                        white),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
                Obx(() {
                  if (cartData.length > 0 && sp.isLogin() == true) {
                    var data = cartData.first;
                    return SizedBox(
                        height: 0.06.sh,
                        child: RaisedButton.icon(
                          color: Color(0xff5BC0DE),
                          onPressed: () {
                            gotoCart();
                          },
                          icon: Icon(Icons.shopping_cart_outlined),
                          label: Text(
                              'Order Cart *(${data.orderCartCount})* || JMD\$${data.subtotal}'),
                        ));
                  }
                  return SizedBox(
                      height: 0.06.sh,
                      child: RaisedButton.icon(
                        color: Color(0xff5BC0DE),
                        onPressed: () {
                          gotoLoginPage();
                        },
                        icon: Icon(Icons.shopping_cart_outlined),
                        label: Text('Order Cart *(0)* || \$0.0'),
                      )
                      // label: Text('Order Cart *(${_cartData.exc})* || \$0.0')),
                      );
                })
              ],
            ),
          ),
        ));
  }

  void _getData() async {
    showProgress(context);
    final autoCatResult = await networkcallService.getPartsCatAPICall();
    hideProgress(context);
    if (autoCatResult != null) {
      setState(() {
        _autoPartsCategoryList = autoCatResult;
      });
    }
  }

  void _getSubAutoCat(String autoCatId) async {
    showProgress(context);
    _autoPartsSubCategoryList =
        (await networkcallService.getPartsSubCatAPICall(autoCatId))!;
    hideProgress(context);
    _autoPartsData();
    setState(() {});
  }

  void _getSortData() async {
    showProgress(context);
    final sortResult = await networkcallService.getSortByDataAPICall();
    hideProgress(context);
    if (sortResult != null) {
      setState(() {
        _sortingDataList = sortResult;
      });
    }
    setState(() {});
  }

  void _autoPartsData() async {
    showProgress(context);
    var res = (await networkcallService.getAutoPartList(
        searchController.text,
        _autoCatId ?? '0',
        _autoSubCatId ?? '0',
        _sortId ?? '0',
        _pageIndex.toString()))!;
    _autoPartsList.addAll(res);
    hideProgress(context);
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
