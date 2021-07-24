import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getCategories.dart';
import 'package:altezar/models/getLatestDeals.dart';
import 'package:altezar/models/getProductsData.dart';
import 'package:altezar/models/getSortByData.dart';
import 'package:altezar/models/getSubCatList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/auths/intro.dart';
import 'package:altezar/view/auths/signUp.dart';
import 'package:altezar/view/home/grocery/grocery.dart';
import 'package:altezar/view/home/productDetails.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  TextEditingController searchController = TextEditingController();

  var _swiperController = SwiperController();
  String? _categoriesName, _subCatName, _sortingValue; //value
  String? _catId, _subCatId, _sortId;
  List<CategoriesList> _catList = [];
  List<GetSubCateProductsList> _subCatList = [];
  List<GetSortByData> _sortingDataList = [];
  // List<ProductListData> list = [];

  var _prdList = <ProductListData>[].obs;
  // Future<List<ProductListData>?>? _prodFuture;
  Future<List<LatestDealsList>?>? _latestDealsFuture;
  final _listContr = ScrollController();
  int _pageIndex = 0;

  @override
  void dispose() {
    print('dispose');
    super.dispose();
    _swiperController.dispose();
    searchController.dispose();
    _listContr.dispose();
  }

  @override
  void initState() {
    super.initState();
    _latestDealsFuture = networkcallService.getAllLatestDealsAPICall();
    _catList.add(CategoriesList(prdId: 0, prdName: 'All Category'));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _getSortData();
    });

    _listContr.addListener(() {
      if (_listContr.position.pixels == _listContr.position.maxScrollExtent &&
          _catId != null) {
        print('contr- ${_listContr.position.pixels}');
        _pageIndex++;
        _getProductData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          _categoriesName = null;
          _catId = null;
          _subCatName = null;
          _subCatId = null;
          _sortingValue = null;
          _sortId = null;
          searchController.clear();
          _latestDealsFuture = networkcallService.getAllLatestDealsAPICall();
          _catList.add(CategoriesList(prdId: 0, prdName: 'All Category'));
          _getData();
          _getSortData();
          setState(() {});
        },
        child: SingleChildScrollView(
          controller: _listContr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
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
                      value: _categoriesName, //'Shoping Category',
                      hint: Text('All Category'),
                      items: _catList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.prdName,
                          child: Text(
                            value.prdName,
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _categoriesName = value!;
                          // list = [];
                          //  _prodFuture. = null;---------
                        });

                        _catId = _catList
                            .where(
                                (element) => element.prdName == _categoriesName)
                            .toList()
                            .first
                            .prdId
                            .toString();
                        _subCatName = null;
                        _subCatId = null;
                        _pageIndex = 0;
                        print('_catId - $_catId');
                        if (_catId == '32' && sp.isLogin() != true)
                          Get.to(() => Intro(
                                isChecked: false,
                              ));
                        else
                        
                        _catId == '22'
                            ? Get.to(() => Grocery())?.then((value) {
                                _catId = null;
                                _categoriesName = null;
                                setState(() {});
                              })
                            : _getSubCat();
                        //_getProductData();
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
                      value: _subCatName, //'Sub Category',
                      hint: Text('Sub Category'),
                      items: _subCatList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.prdName,
                          child: Text(
                            value.prdName,
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _subCatName = value!;
                        });
                        _subCatId = _subCatList
                            .where((element) => element.prdName == _subCatName)
                            .toList()
                            .first
                            .prdCatSubId
                            .toString();
                        _pageIndex = 0;
                        print('_subCatId  $_subCatId');
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
                      hint: Text('Sort By'),
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
                            .where(
                                (element) => element.sortName == _sortingValue)
                            .toList()
                            .first
                            .sortId
                            .toString();
                        _pageIndex = 0;
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
              TextFormField(
                controller: searchController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Search by Product name,brand, etc ......',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 0.07.sh,
                  width: 1.sw,
                  child: button(() async {
                    // list.clear();
                    if (_catId == null) {
                      _catId = '0';
                    }
                    showProgress(context);
                    _pageIndex = 0;
                    await _getProductData();
                    hideProgress(context);
                  }, 'Search', Color(0xffEC971F), white)),
              SizedBox(
                height: 20,
              ),
              if (_catId == null && searchController.text == '')
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(banner1),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Latest Deals/Coupons',
                          style: TextStyle(
                              color: grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 0.1.sh,
                        width: 1.sw,
                        child: FutureBuilder<List<LatestDealsList>?>(
                            future: _latestDealsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List? list = snapshot.data!;

                                return Container(
                                  padding: EdgeInsets.only(top: 12),
                                  // width: 1.sw,
                                  height: 0.19.sh,
                                  child: Swiper(
                                      controller: _swiperController,
                                      scrollDirection: Axis.horizontal,
                                      duration: 2000,
                                      itemCount: list.length,
                                      autoplay: true,
                                      viewportFraction: 0.2,
                                      itemBuilder: (_, i) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(() => ProductDetailsPage(
                                                  prdId: list[i]
                                                      .latestyjPrdId
                                                      .toString(),
                                                  prdTypeId: '1',
                                                ));
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "$imgBaseUrl${list[i].latestprdImgUrl}",
                                            // height: 0.01.sh,
                                            // width: 0.01.sw,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.network(imageNotFound),
                                          ),
                                        );
                                      }),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: customText(
                                        '${snapshot.error}', red, 20.0));
                              } else
                                return Center(
                                  child: CupertinoActivityIndicator(
                                    radius: 25,
                                  ),
                                );
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(banner4),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(banner2),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(banner3),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(banner8),
                    ],
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              if (_catId != null)
                Obx(() {
                  return ListView.separated(
                      separatorBuilder: (_, __) => SizedBox(
                            height: 5,
                          ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _prdList.length,
                      itemBuilder: (_, i) {
                        return InkWell(
                          onTap: () {
                            if (_catId == '14')
                              Get.to(() => ProductDetailsPage(
                                  prdTypeId: '2',
                                  prdId: '${_prdList[i].yjprdId}'));
                            if (_catId == '28')
                              Get.to(() => ProductDetailsPage(
                                  prdTypeId: '3',
                                  prdId: '${_prdList[i].yjprdId}'));
                            // if (_catId == '25')
                            //   Get.to(() => ProductDetailsPage(
                            //       prdTypeId: '4',
                            //       prdId:
                            //           '${_prdList[i].yjprdId}'));
                            else
                              Get.to(() => ProductDetailsPage(
                                  prdTypeId: '1',
                                  prdId: '${_prdList[i].yjprdId}'));
                          },
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "$imgBaseUrl${_prdList[i].prdImg}",
                                    width: 0.3.sw,
                                    height: 0.2.sh,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Image.network(imageNotFound),
                                  ),
                                  SizedBox(
                                    width: 0.15.sw,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${_prdList[i].prdFullName}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: blue),
                                        ),
                                        Text(
                                          'Price - ${_prdList[i].price}',
                                          style: TextStyle(
                                              fontSize: 14, color: green),
                                        ),
                                        _prdList[i].size == null
                                            ? Text(
                                                ' | ${_prdList[i].sellerName}')
                                            : Text(
                                                '${_prdList[i].size} | ${_prdList[i].sellerName} ',
                                                style: TextStyle(
                                                    fontSize: 14, color: grey),
                                              ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            button(() {
                                              if (_catId == '14')
                                                Get.to(() => ProductDetailsPage(
                                                    prdTypeId: '2',
                                                    prdId:
                                                        '${_prdList[i].yjprdId}'));
                                              if (_catId == '28')
                                                Get.to(() => ProductDetailsPage(
                                                    prdTypeId: '3',
                                                    prdId:
                                                        '${_prdList[i].yjprdId}'));
                                              // if (_catId == '25')
                                              //   Get.to(() => ProductDetailsPage(
                                              //       prdTypeId: '4',
                                              //       prdId:
                                              //           '${_prdList[i].yjprdId}'));
                                              else
                                                Get.to(() => ProductDetailsPage(
                                                    prdTypeId: '1',
                                                    prdId:
                                                        '${_prdList[i].yjprdId}'));
                                            }, 'Details', green, white),
                                            sp.isLogin() == true
                                                ? cartButton(() {
                                                    _addToCart(
                                                        '${_prdList[i].yjprdId}',
                                                        '${_prdList[i].clientId}',
                                                        'Products',
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
                                                    () =>
                                                        Get.to(() => SignUp()),
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
                })
            ],
          ),
        ),
      ),
    );
  }

  void _getData() async {
    final categoryResult = await networkcallService.getCategoriesAPICall();
    if (categoryResult != null) {
      setState(() {
        _catList.addAll(categoryResult);
      });
    }
  }

  void _getSubCat() async {
    showProgress(context);

    _subCatList = (await networkcallService.getSubCatAPICall(_catId!))!;
    hideProgress(context);
    // print("${_subCatList.length} oo");
    // setState(() {});
    _getProductData();
  }

  void _getSortData() async {
    final sortResult = await networkcallService.getSortByDataAPICall();

    if (sortResult != null) {
      setState(() {
        _sortingDataList = sortResult;
      });
    }
  }

  Future _getProductData() async {
    showProgress(context);
    _prdList.value = (await networkcallService.getProductsAPICall(
        _catId ?? '0',
        searchController.text,
        _subCatId ?? '0',
        _sortId ?? '0',
        _pageIndex.toString()))!;
    setState(() {});
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
    final data = await networkcallService.addToCartAPICall(
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
