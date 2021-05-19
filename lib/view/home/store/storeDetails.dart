import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getCartBox.dart';
import 'package:altezar/models/getGategoryForStores.dart';
import 'package:altezar/models/getSortByData.dart';
import 'package:altezar/models/getSubCatList.dart';
import 'package:altezar/models/pageDetailsModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/auths/signUp.dart';
import 'package:altezar/view/home/productDetails.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoreDetailsPage extends StatefulWidget {
  final int storeId;

  const StoreDetailsPage({Key? key, required this.storeId}) : super(key: key);
  @override
  _StoreDetailsPageState createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  TextEditingController searchController = TextEditingController();
  String? _categoriesName, _subCatName, _sortingValue; //value
  String? _catId, _subCatId, _sortId;
  List<StoreCatListElement> _catList = [];
  List<GetSubCateProductsList> _subCatList = [];
  List<GetSortByData> _sortingDataList = [];
  var _prdList = <Productlist>[].obs;
  var _cartData = <CartBoxData>[].obs;

  final _listContr = ScrollController();
  int _pageIndex = 0;

  Future<List<Productlist>>? _storeDetailFuture;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _getSortData();
      _cartBox();
    });

    _listContr.addListener(() {
      if (_listContr.position.atEdge && _catId != null) {
        print('contr- ${_listContr.position.pixels}');
        _pageIndex++;
        _getPrdData();
      }
    });

    _getPrdData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), child: detailsPageAppBar()),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _listContr,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(banner5),
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
                            value: _categoriesName, //'Shoping Category',
                            hint: Text('All Category'),
                            items: _catList.map((value) {
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
                                _categoriesName = value!;
                              });

                              _catId = _catList
                                  .where((element) =>
                                      element.name == _categoriesName)
                                  .toList()
                                  .first
                                  .productCategoryId
                                  .toString();
                              _subCatName = null;
                              _getSubCat();
                              print('productId - $_catId');
                              _getPrdData();
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
                                  .where((element) =>
                                      element.prdName == _subCatName)
                                  .toList()
                                  .first
                                  .prdCatSubId
                                  .toString();
                              print('_subCatId  $_subCatId');
                              // _getProductData();
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
                                  .where((element) =>
                                      element.sortName == _sortingValue)
                                  .toList()
                                  .first
                                  .sortId
                                  .toString();
                              print('_sortId  $_sortId');
                              // _getProductData();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    searchField(
                        searchController, 'Search Product Name, Brand etc ...'),
                    SizedBox(
                        width: double.infinity,
                        child: button(() {
                          _getPrdData();
                        }, 'Search', Color(0xffF0AD4E), white)),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => _prdList.length != 0
                          ? ListView.separated(
                              separatorBuilder: (_, __) => SizedBox(
                                    height: 20,
                                  ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _prdList.length,
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
                                                "$imgBaseUrl${_prdList[i].productImageUrl}",
                                            height: 0.3.sh,
                                            width: 0.3.sw,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.network(imageNotFound),
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    '${_prdList[i].productName}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.blue)),
                                                Text('${_prdList[i].price}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: green)),
                                                Text(
                                                    '${_prdList[i].sellerName}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: greenColor)),
                                                Text(
                                                    '${_prdList[i].productName}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: greenColor)),
                                                Text(
                                                    '${_prdList[i].size} ${_prdList[i].perks}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: grey)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          button(() {
                                            Get.to(() => ProductDetailsPage(
                                                prdTypeId: '1',
                                                prdId:
                                                    '${_prdList[i].yjProductId}'));
                                          }, 'Details', greenColor, white),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          sp.isLogin() == true
                                              ? cartButton(() {
                                                  _addToCart(
                                                      '${_prdList[i].yjProductId}',
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
                                                }, 'Add', priceTextColor, white)
                                              : cartButton(
                                                  () => Get.to(() => SignUp()),
                                                  'Add',
                                                  priceTextColor,
                                                  white),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : CupertinoActivityIndicator(
                              radius: 25,
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            if (_cartData.length > 0) {
              var data = _cartData.first;
              return SizedBox(
                  height: 0.06.sh,
                  child: RaisedButton.icon(
                    color: Color(0xff5BC0DE),
                    onPressed: () {},
                    icon: Icon(Icons.card_travel_rounded),
                    label: Text(
                        'Order Cart *(${data.orderCartCount})* || \$${data.totalCostUSD}'),
                  )
                  // label: Text('Order Cart *(${_cartData.exc})* || \$0.0')),
                  );
            }
            return Container();
          })
        ],
      ),
    );
  }

  void _getData() async {
    final categoryResult = await networkcallService
        .getCategoryForStoreAPICall(widget.storeId.toString());
    if (categoryResult != null) {
      setState(() {
        _catList = categoryResult;
      });
    }
  }

  void _getSubCat() async {
    showProgress(context);
    _subCatList = (await networkcallService.getSubCatAPICall(_catId!))!;
    hideProgress(context);
    setState(() {});
    // _getProductData();
  }

  void _getSortData() async {
    final sortResult = await networkcallService.getSortByDataAPICall();

    if (sortResult != null) {
      setState(() {
        _sortingDataList = sortResult;
      });
    }
  }

  void _getPrdData() async {
    final data = await networkcallService.getprdDetails(
        _catId ?? '0',
        '',
        _subCatId ?? '0',
        _sortId ?? '0',
        _pageIndex.toString(),
        widget.storeId.toString());
    if (data != null) {
      _prdList(data);
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
  }

  void _cartBox() async {
    _cartData.value = (await networkcallService
        .getCartBoxAPICall(sp.getUserId().toString()))!;
    print('l ${_cartData.length}');
  }
}
