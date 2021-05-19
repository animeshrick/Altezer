import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getResList.dart';
import 'package:altezar/models/getResTypeList.dart';
import 'package:altezar/models/groceryStateList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'foodDetails/foodDetails.dart';

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  TextEditingController searchController = TextEditingController();

  var controller = ScrollController();

  String? _resTypeValue, _stateValue;
  String? _resTypeId, _groceryStateId;
  List<ResTypelist> _resTypeList = [];

  List<GetGroceryStateList> _groceryStateList = [];

  List<RestShopList> _shopList = [];
  Future<List<RestShopList>>? _shopFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _resType();
    });
    _getShopData();
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Image.asset(banner4),
              SizedBox(
                height: 15,
              ),
              searchField(
                  searchController, 'Search Product Name, Brand etc ...'),
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
                      value: _resTypeValue,
                      hint: Text('Resturant Type'),
                      items: _resTypeList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.restTypeName,
                          child: Text(
                            value.restTypeName,
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _resTypeValue = value!;
                        });
                        _resTypeId = _resTypeList
                            .where((element) =>
                                element.restTypeName == _resTypeValue)
                            .toList()
                            .first
                            .codeId
                            .toString();
                        print('_resTypeId  $_resTypeId');
                        _getShopData();
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
                      hint: Text('Choose Parish/Providence/State'),
                      value: _stateValue,
                      items: _groceryStateList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.groceryStateName,
                          child: Text(
                            value.groceryStateName,
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _stateValue = value!;
                        });
                        _groceryStateId = _groceryStateList
                            .where((element) =>
                                element.groceryStateName == _stateValue)
                            .toList()
                            .first
                            .groceryStateId
                            .toString();
                        print('_stateId- $_groceryStateId');
                        _getShopData();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  height: 0.07.sh,
                  width: 1.sw,
                  child: button(() {
                    _getShopData();
                  }, 'Search', Color(0xffEC971F), white)),
              Container(
                padding: EdgeInsets.only(right: 15, top: 15),
                child: FutureBuilder<List<RestShopList>>(
                    future: _shopFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var list = snapshot.data;
                        return list!.length != 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 2, //list.length,
                                itemBuilder: (_, i) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => FoodDetails(
                                              storeId: list[i].clientId));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  "$imgBaseUrl${list[i].logoImageFile}",
                                              height: 0.2.sh,
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
                                                      '${list[i].restaurantName}',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors
                                                              .blueAccent)),
                                                  Text(
                                                      '${list[i].restaurantEthnic}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: red)),
                                                  Text(
                                                      '${list[i].deliveryInfo}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: grey)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                })
                            : Text('Data not available now');
                      } else if (snapshot.hasError) {
                        return Center(
                            child: customText('${snapshot.error}', red, 20.0));
                      } else
                        return Center(
                          child: CupertinoActivityIndicator(
                            radius: 25,
                          ),
                        );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getData() async {
    final groceryStateResult =
        await networkcallService.getGroceryStateListAPICall();
    if (groceryStateResult != null) {
      setState(() {
        _groceryStateList = groceryStateResult;
      });
    }
  }

  void _resType() async {
    final resType = await networkcallService.getResTypeListAPICall();
    setState(() {
      _resTypeList = resType;
    });
  }

  void _getShopData() async {
    _shopFuture = networkcallService.getResListAPICall(
        _resTypeId ?? '0', searchController.text, _groceryStateId ?? '0');
    setState(() {});
  }
}
