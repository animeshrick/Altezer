import 'package:altezar/utils/const.dart';
import 'package:altezar/view/auths/intro.dart';
import 'package:altezar/view/home/deal/deals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'autoParts/autoParts.dart';
import 'food/food.dart';
import 'grocery/grocery.dart';
import 'store/store.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Color> tabcolors = [
    Color(0xffFFFFFF),
    Color(0xff835A42),
    Color(0xff9457B0),
    Color(0xff2ECC71),
    Color(0xffEC7063),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton.icon(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.to(Intro());
                    },
                    color: white,
                    icon: Icon(Icons.person),
                    label: Text('Sign In')),
                Image.asset(
                  appbarImg,
                  height: 0.1.sh,
                ),
                Flexible(
                  child: FlatButton.icon(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      color: white,
                      icon: Icon(Icons.shopping_cart_outlined),
                      label: Text('0')),
                ),
              ],
            ),
            backgroundColor: appbarColor,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: 'Store',
                ),
                Tab(
                  text: 'Deals',
                ),
                Tab(
                  text: 'Grocery',
                ),
                Tab(
                  text: 'Food',
                ),
                Tab(
                  text: 'Auto Parts',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [Store(), Deals(), Grocery(), Food(), AutoParts()],
        ),
      ),
    );
  }
}
