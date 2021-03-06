import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/bannerImage.dart';
import 'package:altezar/models/getCartBox.dart';
import 'package:altezar/models/getGategoryForStores.dart';
import 'package:altezar/models/getSortByData.dart';
import 'package:altezar/models/getSubCatList.dart';
import 'package:altezar/models/pageDetailsModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/home/productDetails.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

  final _listContr = ScrollController();
  int _pageIndex = 0;

  var result =
      BannerImage(message: '', imgCover: '', imgLogo: '', status: '').obs;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getBannerImage();
      _getData();
      _getSortData();
      cartBox();
      _getPrdData();
    });

    _listContr.addListener(() {
      if (_listContr.position.pixels == _listContr.position.maxScrollExtent &&
          _catId != null) {
        print('contr- ${_listContr.position.pixels}');
        _pageIndex++;
        _getPrdData();
      }
    });
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
                    Obx(
                      () => CachedNetworkImage(
                        imageUrl: "$imgBaseUrl${result.value.imgCover}",
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Image.network(imageNotFound),
                      ),
                    ),
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
                              _subCatId = null;
                              _prdList.clear();
                              _getSubCat();
                              _pageIndex = 0;
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
                              _prdList.clear();
                              _pageIndex = 0;
                              print('_subCatId  $_subCatId');
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
                              _prdList.clear();
                              print('_sortId  $_sortId');
                              _pageIndex = 0;
                              _getPrdData();
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
                          _pageIndex = 0;
                          _getPrdData();
                        }, 'Search', Color(0xffF0AD4E), white)),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => _prdList.length != 0
                          ? ListView.separated(

                              // primary: true,
                              separatorBuilder: (_, __) => SizedBox(
                                    height: 10,
                                  ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _prdList.length,
                              itemBuilder: (_, i) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => ProductDetailsPage(
                                            prdTypeId: '1',
                                            prdId:
                                                '${_prdList[i].yjProductId}'));
                                      },
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                "$imgBaseUrl${_prdList[i].productImageUrl}",
                                            // height: 0.3.sh,
                                            width: 0.3.sw,
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${_prdList[i].productName}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                customRichText(
                                                    '${_prdList[i].size}',
                                                    '${_prdList[i].perks}',
                                                    grey,
                                                    greenColor),

                                                // Text(
                                                //   '${_prdList[i].size} ${_prdList[i].perks}',
                                                //   style: TextStyle(
                                                //       fontSize: 16, color: grey),
                                                // ),
                                                RatingBarIndicator(
                                                  rating: _prdList[i]
                                                      .ratingCount
                                                      .toDouble(),
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 25.0,
                                                  direction: Axis.horizontal,
                                                ),
                                                Text('${_prdList[i].price}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: green)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    button(() {
                                                      Get.to(() =>
                                                          ProductDetailsPage(
                                                              prdTypeId: '1',
                                                              prdId:
                                                                  '${_prdList[i].yjProductId}'));
                                                    }, 'Details', greenColor,
                                                        white),
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
                                                          },
                                                            'Add',
                                                            priceTextColor,
                                                            white)
                                                        : cartButton(
                                                            () => Get.to(() =>
                                                                gotoLoginPage()),
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
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                );
                              })
                          : Text('No data found'),
                    )
                  ],
                ),
              ),
            ),
          ),
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
    // _getSortData();
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
    showProgress(context);
    final data = await networkcallService.getprdDetails(
        _catId ?? '0',
        searchController.text == '' ? '' : searchController.text,
        _subCatId ?? '0',
        _sortId ?? '0',
        _pageIndex.toString(),
        widget.storeId.toString());
    _prdList.addAll(data!);
    hideProgress(context);
    // if (data != null) {
    //   _prdList(data);
    // }
  }

  void _getBannerImage() async {
    result.value = (await networkcallService
        .getBannerImageAPICall(widget.storeId.toString()))!;
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
