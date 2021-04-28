import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'groceryDetails/groceryDdetails.dart';

class Grocery extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

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
              Image.asset(banner1),
              SizedBox(
                height: 15,
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
                height: 15,
              ),
              dropDownWidget('Parish'),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 0.07.sh,
                width: 1.sw,
                child: button(() {}, 'Search', Color(0xffEC971F), white),
              ),
              SizedBox(height: 20),
              ListView.separated(
                  separatorBuilder: (_, __) => SizedBox(
                        height: 15,
                      ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (_, i) {
                    return ColoredBox(
                      color: Color(0xffE8E8E8),
                      child: InkWell(
                        onTap: () {
                          Get.to(GroceryDetails());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              groceryImg,
                              width: 0.2.sw,
                              height: 0.2.sh,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Alterz Fresh  ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blueAccent)),
                                Text('Online Ordering  ',
                                    style: TextStyle(fontSize: 16, color: red)),
                                Text('Kingstone,Kingstone  ',
                                    style:
                                        TextStyle(fontSize: 16, color: grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
