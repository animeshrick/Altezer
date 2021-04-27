import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'dealsDetails/dealDetails.dart';

class Deals extends StatelessWidget {
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
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (_, i) {
                    return InkWell(
                      onTap: () {
                        Get.to(DealsDetails());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            slider2,
                            width: 0.3.sw,
                            height: 0.2.sh,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Yea T-Shirt',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blueAccent)),
                              Text('JMD \$2700.00',
                                  style: TextStyle(fontSize: 16, color: red)),
                              Text('Artquie',
                                  style: TextStyle(fontSize: 16, color: grey)),
                              Text('Shipping --- FREE',
                                  style: TextStyle(fontSize: 16, color: black)),
                            ],
                          ),
                        ],
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
