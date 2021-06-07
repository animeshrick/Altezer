import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/autoPartsListModel.dart';
import 'package:altezar/models/getAutoPartsCat.dart';
import 'package:altezar/models/getAutoPartsSubCat.dart';
import 'package:altezar/models/getCartBox.dart';
import 'package:altezar/models/getSortByData.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
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
  var _cartData = <CartBoxData>[].obs;

  List<GetSortByData> _sortingDataList = [];
  final _listContr = ScrollController();
  int _pageIndex = 0;

  Future<List<AutoPartsList>?>? _autoPartsFuture;

  @override
  void initState() {
    super.initState();
    // _autoPartsFuture =
    //     networkcallService.getAutoPartList('', '0', '0', '0', '0');
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _getSortData();
      _cartBox();
    });

    _getProductData();

    _listContr.addListener(() {
      if (_listContr.position.atEdge && _autoCatId != null) {
        print('contr- ${_listContr.position.pixels}');
        _pageIndex++;
        _getProductData();
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
      body: Container(
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
                                .where((element) => element.name == _autoCatVal)
                                .toList()
                                .first
                                .productCategorySub1Id
                                .toString();
                            print('_autoCatId  $_autoCatId');
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
                            _getProductData();
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
                            _getProductData();
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  searchField(
                      searchController, 'Search Product Name, Brand etc ...'),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 0.07.sh,
                      width: 1.sw,
                      child: button(() {
                        _getProductData();
                      }, 'Search', Color(0xffEC971F), white)),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<AutoPartsList>?>(
                      future: _autoPartsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var list = snapshot.data;

                          return ListView.separated(
                              separatorBuilder: (_, __) => SizedBox(
                                    height: 20,
                                  ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: list!.length,
                              itemBuilder: (_, i) {
                                return InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                "$imgBaseUrl${list[i].productImageUrl}",
                                            width: 0.3.sw,
                                            height: 0.2.sh,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.network(imageNotFound),
                                          ),
                                          SizedBox(
                                            width: 0.1.sw,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text('${list[i].productName}',
                                                    // overflow:
                                                    //     TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.blue)),
                                                Text('${list[i].price}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: priceTextColor)),
                                                Text(
                                                    '${list[i].size} | By: ${list[i].sellerName}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.green)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    button(() {
                                                      Get.to(() =>
                                                          ProductDetailsPage(
                                                            prdTypeId: '1',
                                                            prdId:
                                                                '${list[i].yjProductId}',
                                                          ));
                                                    }, 'Details', greenColor,
                                                        white),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    sp.isLogin() == true
                                                        ? cartButton(() {
                                                            _addToCart(
                                                                '${list[i].yjProductId}',
                                                                '${list[i].clientId}',
                                                                'AutoParts',
                                                                '',
                                                                '',
                                                                1.toString(),
                                                                '',
                                                                '',
                                                                sp
                                                                    .getUserId()
                                                                    .toString());
                                                          },
                                                            'Add',
                                                            priceTextColor,
                                                            white)
                                                        : cartButton(
                                                            () =>
                                                                gotoLoginPage(),
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
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                              child:
                                  customText('${snapshot.error}', red, 20.0));
                        } else
                          return Center(
                            child: CupertinoActivityIndicator(
                              radius: 25,
                            ),
                          );
                      })
                ],
              ),
            )),
            Obx(() {
              if (_cartData.length > 0 && sp.isLogin() == true) {
                var data = _cartData.first;
                print('this is me ${sp.getUserId().toString()}');
                return SizedBox(
                    height: 0.06.sh,
                    child: RaisedButton.icon(
                      color: Color(0xff5BC0DE),
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart_outlined),
                      label: Text(
                          'Order Cart *(${data.orderCartCount})* || JMD\$${data.subtotal}'),
                    )
                    // label: Text('Order Cart *(${_cartData.exc})* || \$0.0')),
                    );
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
    );
  }

  void _getData() async {
    final autoCatResult = await networkcallService.getPartsCatAPICall();
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
    setState(() {});
  }

  void _getSortData() async {
    final sortResult = await networkcallService.getSortByDataAPICall();
    if (sortResult != null) {
      setState(() {
        _sortingDataList = sortResult;
      });
    }
    setState(() {});
  }

  void _getProductData() async {
    _autoPartsFuture = networkcallService.getAutoPartList(
        searchController.text,
        _autoCatId ?? '0',
        _autoSubCatId ?? '0',
        _sortId ?? '0',
        _pageIndex.toString());
    setState(() {});
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
    if (data == true) {
      _cartBox();
    }
  }

  void _cartBox() async {
    if (sp.getUserId() != null)
      _cartData.value = (await networkcallService
          .getCartBoxAPICall(sp.getUserId().toString()))!;
    print('l ${_cartData.length}');
  }
}
