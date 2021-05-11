import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getCategories.dart';
import 'package:altezar/models/getLatestDeals.dart';
import 'package:altezar/models/getProductsData.dart';
import 'package:altezar/models/getSortByData.dart';
import 'package:altezar/models/getSubCatList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  List<ProductListData> list = [];

  Future<List<ProductListData>?>? _prodFuture;
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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _getSortData();
    });

    _listContr.addListener(() {
      if (_listContr.position.atEdge && _catId != null) {
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
      child: SingleChildScrollView(
        controller: _listContr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Color(0xffEDEDED),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                  hint: Text('Select Category'),
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
                    });

                    _catId = _catList
                        .where((element) => element.prdName == _categoriesName)
                        .toList()
                        .first
                        .prdId
                        .toString();
                    _subCatName = null;
                    _getSubCat();
                    print('productId - $_catId');
                    //_getProductData();
                  },
                ),
              ),
            ),
            Card(
              color: Color(0xffEDEDED),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                  hint: Text('Select Sub Category'),
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
                    print('_subCatId  $_subCatId');
                    _getProductData();
                  },
                ),
              ),
            ),
            Card(
              color: Color(0xffEDEDED),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                        .where((element) => element.sortName == _sortingValue)
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: searchController,
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Search here ......',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 0.07.sh,
                width: 1.sw,
                child: button(() {}, 'Search', Color(0xffEC971F), white)),
            SizedBox(
              height: 20,
            ),
            if (_catId == null)
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
                    FutureBuilder<List<LatestDealsList>?>(
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
                                  viewportFraction: 0.4,
                                  itemBuilder: (_, i) {
                                    return CachedNetworkImage(
                                      
                                      imageUrl:
                                          "$imgBaseUrl${list[i].latestprdImgUrl}",
                                      height: 0.05.sh,
                                      width: 0.05.sw,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Image.network(imageNotFound),
                                    );
                                  }),
                            );
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
                        }),
                    SizedBox(
                      height: 20,
                    ),
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
                    Image.asset(banner4),
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
              FutureBuilder<List<ProductListData>?>(
                  future: _prodFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      list.addAll(snapshot.data!);

                      return ListView.separated(
                          separatorBuilder: (_, __) => SizedBox(
                                height: 20,
                              ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (_, i) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: "$imgBaseUrl${list[i].prdImg}",
                                      width: 0.3.sw,
                                      height: 0.2.sh,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Image.network(imageNotFound),
                                    ),
                                    // Image.network(
                                    //   // 'https://demo20.gowebbi.us//ProductImages/arg-sp-1020_basep_2.jpg',
                                    //   '$imgBaseUrl${list[i].prdImg}',
                                    //   width: 0.4.sw,
                                    //   height: 0.2.sh,
                                    // ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text('${list[i].prdFullName}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: blue)),
                                          Text('Price - ${list[i].price}',
                                              style: TextStyle(
                                                  fontSize: 14, color: green)),
                                          Text(
                                              'Size- ${list[i].size} |Seller- ${list[i].sellerName} ',
                                              style: TextStyle(
                                                  fontSize: 14, color: grey)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    button(() {}, 'View Details', green, white),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    button(() {}, 'Add to cart',
                                        Color(0xffD9534F), white),
                                  ],
                                ),
                              ],
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(
                          child: customText('${snapshot.error}', red, 20.0));
                    } else
                      return Center(
                        child: CupertinoActivityIndicator(
                          radius: 25,
                        ),
                      );
                  })
          ],
        ),
      ),
    );
  }

  void _getData() async {
    final categoryResult = await networkcallService.getCategoriesAPICall();
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

  void _getProductData() {
    _prodFuture = networkcallService.getProductsAPICall(
        _catId!, '', _subCatId ?? '0', _sortId ?? '0', _pageIndex.toString());
    setState(() {});
  }
}
