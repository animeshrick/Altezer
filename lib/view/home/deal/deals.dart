import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getdealsList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'dealsDetails/dealDetails.dart';

class Deals extends StatefulWidget {
  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  @override
  Future<List<DealsListData>?>? _dealsFuture;

  void initState() {
    super.initState();
    _dealsFuture = networkcallService.getDealsAPICall('0', '0');
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
              dropDownWidget('Sort By'),
              FutureBuilder<List<DealsListData>?>(
                  future: _dealsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List? list = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (_, i) {
                            return InkWell(
                              onTap: () {
                                Get.to(DealsDetails());
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('${list[i].productName}',
                                          style: TextStyle(
                                              fontSize: 5,
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
}
