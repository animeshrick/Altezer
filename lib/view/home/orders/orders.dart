import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/checkout/checkout.dart';
import 'package:altezar/view/home/orders/accountSettings.dart';
import 'package:altezar/view/home/orders/onlineOrder.dart';
import 'package:altezar/view/home/orders/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  var _controller;
  bool isLogin = true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isLogin)
              FlatButton.icon(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    // Get.to(Intro());
                    // await networkcallService.getAllDropdownValue();
                  },
                  color: white,
                  icon: Icon(Icons.person),
                  label: Text('Sign In')),
            if (isLogin)
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
        toolbarHeight: 0.2.sh,
        backgroundColor: appbarColor,
        bottom: TabBar(
          labelPadding: EdgeInsets.zero,
          labelStyle: TextStyle(fontSize: 13),
          labelColor: black,
          controller: _controller,
          indicatorColor: Colors.blue,
          unselectedLabelColor: Colors.white,
          indicator: BoxDecoration(color: Colors.blue),
          tabs: [
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xffACACAC),
                  child: Icon(
                    Icons.arrow_forward_sharp,
                    color: white,
                    size: 15,
                  )),
              text: 'Account Settings',
              // child: customText('Account Settings', black, 14),
            ),
            Tab(
              icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xffACACAC),
                  child: Icon(
                    Icons.arrow_forward_sharp,
                    color: white,
                    size: 15,
                  )),
              text: 'Online Order',
              // child: customText('Online Order', black, 14),
            ),
            Tab(
              icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xffACACAC),
                  child: Icon(
                    Icons.arrow_forward_sharp,
                    color: white,
                    size: 15,
                  )),
              text: 'Receipt',
              // child: customText('Receipt', black, 14),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          AccountSettings(),
          OnlineOrder(),
          Receipt(),
        ],
      ),
    );
  }
}
