import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/fab.dart';
import 'package:altezar/view/home/store/retailSpl.dart';
import 'package:altezar/view/home/store/shopping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  final List<String> imgList = [slider1, slider2];

  var _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    print('mydispose');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(Fab());
        },
        child: const Icon(Icons.message),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        toolbarHeight: 0.13.sh,
        backgroundColor: white,
        bottom: TabBar(
          // labelPadding: EdgeInsets.only(left: 15, right: 35, bottom: 15),
          labelColor: black,
          controller: _controller,
          indicatorColor: Colors.blue,

          indicator: BoxDecoration(color: Colors.blue),
          tabs: [
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: CircleAvatar(
                  backgroundColor: Color(0xffACACAC),
                  child: Icon(
                    Icons.shopping_bag,
                    color: white,
                  )),
              // text: 'Shopping',
              child: customText('Shopping', black, 18),
            ),
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: CircleAvatar(
                  backgroundColor: Color(0xffACACAC),
                  child: Icon(
                    Icons.edit,
                    color: white,
                  )),
              // text: 'Retail Specials',
              child: customText('Retail Specials', black, 18),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Shopping(),
          RetailSpl(),
        ],
      ),
    );
  }
}
