import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/auths/intro.dart';
import 'package:altezar/view/home/deal/deals.dart';
import 'package:altezar/view/home/store/onTapStore.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'autoParts/autoParts.dart';
import 'checkout/checkout.dart';
import 'food/food.dart';
import 'grocery/grocery.dart';
import 'store/dashboard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  var _controller;
  bool? isLogin = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    print('first dispose');
  }

  @override
  Widget build(BuildContext context) {
    isLogin = sp.isLogin();
    // print(isLogin);

    return Scaffold(
      drawer: customDrawer(),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: isLogin!,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isLogin!)
              FlatButton.icon(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    Get.to(Intro(
                      isChecked: false,
                    ));
                  },
                  color: white,
                  icon: Icon(Icons.person),
                  label: Text('Sign In')),
            if (isLogin!)
              SizedBox(
                width: 0.02.sw,
              ),
            Image.asset(
              appbarImg,
              height: 0.1.sh,
            ),
            Flexible(
              child: FlatButton.icon(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.to(CheckOut());
                  },
                  color: white,
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: Text('0')),
            ),
          ],
        ),
        backgroundColor: appbarColor,
        // bottom: TabBar(
        //   controller: _controller,
        //   isScrollable: true,
        //   tabs: [
        //     Tab(
        //       child: customText("Store", white, 15),
        //     ),
        //     Tab(
        //       // text: 'Deals',
        //       child: customText("Deals", Color(0xffDC7633), 15),
        //     ),
        //     Tab(
        //       // text: 'Grocery',
        //       child: customText("Grocery", Color(0xff9457B0), 15),
        //     ),
        //     Tab(
        //       // text: 'Food',
        //       child: customText("Food", Color(0xff2ECC71), 15),
        //     ),
        //     Tab(
        //       // text: 'Auto Parts',
        //       child: customText("Auto Parts", Color(0xffEC7063), 15),
        //     ),
        //   ],
        // ),
      ),
      // body: TabBarView(
      //   controller: _controller,
      //   children: [Store(), Deals(), Grocery(), Food(), AutoParts()],
      // ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: appbarColor,
              child: Row(
                children: [
                  tabbarButton(() {
                    Get.to(OnTapStore());
                  }, 'Stores', white, 15.0),
                  tabbarButton(() {
                    Get.to(Deals());
                  }, 'Deals', Color(0xffDC7633), 15.0),
                  tabbarButton(() {
                    Get.to(()=>Grocery());
                  }, 'Grocery', Color(0xff9457B0), 15.0),
                  tabbarButton(() {
                    Get.to(Food());
                  }, 'Food', Color(0xff2ECC71), 15.0),
                  tabbarButton(() {
                    Get.to(AutoParts());
                  }, 'Auto Parts', Color(0xffEC7063), 15.0),
                ],
              ),
            ),
          ),
          Expanded(child: DashBoard()),
        ],
      ),
    );
  }
}
