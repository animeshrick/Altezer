import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getCategories.dart';
import 'package:altezar/models/getdealsList.dart';
import 'package:altezar/utils/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../productDetails.dart';

class Deals extends StatefulWidget {
  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  @override
  Future<List<DealsListData>?>? _dealsFuture;

  String? _categoriesName; //value
  String? _catId;
  List<CategoriesList> _catList = [];
  List<CategoriesList> _dealList = [];

  void initState() {
    super.initState();
    _dealsFuture = networkcallService.getDealsAPICall('0', '0');
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
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
            FlatButton.icon(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Get.back();
                },
                color: white,
                icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: grey,
                    child: Icon(
                      Icons.home,
                      color: white,
                    )),
                label: customText("Home", black, 15.0)),
            SizedBox(
              width: 0.15.sw,
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
        child: SingleChildScrollView(
          child: Column(
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
                          .where(
                              (element) => element.prdName == _categoriesName)
                          .toList()
                          .first
                          .prdId
                          .toString();
                      print('_catId $_catId');
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<List<DealsListData>?>(
                  future: _dealsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DealsListData>? list = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (_, i) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => ProductDetailsPage(
                                    prdTypeId: '1',
                                    prdId: '${list[i].yJProductID}'));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "$imgBaseUrl${list[i].productImageURL}",
                                    height: 0.2.sh,
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
                                        Text('${list[i].productName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.blueAccent)),
                                        Text('${list[i].price}',
                                            style: TextStyle(
                                                fontSize: 15, color: red)),
                                        Text('${list[i].sellerName}',
                                            style: TextStyle(
                                                fontSize: 15, color: grey)),
                                        Text('Shipping --- ${list[i].perks}',
                                            style: TextStyle(
                                                fontSize: 16, color: black)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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

  // void _getDealList(String catId, String pageIndex) async {
  //   final dealRes = await networkcallService.getDealsAPICall(_catId.toString(),pageIndex);
  //   if (_catId != null) {
  //     setState(() {
  //       _dealList = dealRes;
  //     });
  //   }
  // }
}
