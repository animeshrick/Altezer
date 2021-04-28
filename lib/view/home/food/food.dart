import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'foodDetails/foodDetails.dart';

class Food extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  var controller = ScrollController();

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
              dropDownWidget('Resturant type'),
              dropDownWidget('Parish'),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  height: 0.07.sh,
                  width: 1.sw,
                  child: button(() {}, 'Search', Color(0xffEC971F), white)),
              Container(
                padding: EdgeInsets.only(right: 15, top: 15),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (_, i) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(FoodDetails());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  foodImg,
                                  width: 0.4.sw,
                                  height: 0.2.sh,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Alterz Fresh',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueAccent)),
                                    Text('Online Ordering',
                                        style: TextStyle(
                                            fontSize: 16, color: red)),
                                    Text('Kingstone,Kingstone',
                                        style: TextStyle(
                                            fontSize: 16, color: grey)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
