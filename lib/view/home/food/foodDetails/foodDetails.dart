import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getCategories.dart';
import 'package:altezar/models/getSortByData.dart';
import 'package:altezar/models/getSubCatList.dart';
import 'package:altezar/models/pageDetailsModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../productDetails.dart';

class FoodDetails extends StatefulWidget {
  final int storeId;

  const FoodDetails({Key? key, required this.storeId}) : super(key: key);
  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  TextEditingController searchController = TextEditingController();
  String? _categoriesName, _subCatName, _sortingValue; //value
  String? _catId, _subCatId, _sortId;
  List<CategoriesList> _catList = [];
  List<GetSubCateProductsList> _subCatList = [];
  List<GetSortByData> _sortingDataList = [];

  var _prdList = <Productlist>[].obs;
  int _pageIndex = 0;
  final _listContr = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _getSortData();
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
      body: SingleChildScrollView(
        controller: _listContr,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(banner7),
              SizedBox(
                height: 20,
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
                          .where(
                              (element) => element.prdName == _categoriesName)
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
                    },
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
                  child: button(() {}, 'Search', Color(0xffF0AD4E), white)),
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
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Image.network(imageNotFound),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text('${_prdList[i].productName}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue)),
                                          Text('${_prdList[i].price}',
                                              style: TextStyle(
                                                  fontSize: 16, color: green)),
                                          Text('${_prdList[i].sellerName}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: greenColor)),
                                          Text('${_prdList[i].productName}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: greenColor)),
                                          Text(
                                              '${_prdList[i].size} ${_prdList[i].perks}',
                                              style: TextStyle(
                                                  fontSize: 16, color: grey)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    button(() {
                                      Get.to(() => ProductDetailsPage(
                                          prdTypeId: '1',
                                          prdId: '${_prdList[i].yjProductId}'));
                                    }, 'View Details', greenColor, white),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    button(() {}, 'Add to Cart', priceTextColor,
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
}
