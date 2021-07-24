import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/fab.dart';
import 'package:altezar/view/home/store/retailSpl.dart';
import 'package:altezar/view/home/store/shopping.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.to(() => Fab());
      //   },
      //   child: const Icon(Icons.message_outlined),
      //   backgroundColor: Colors.green,
      // ),
      appBar: AppBar(
        // primary: false,
        //automaticallyImplyLeading: true,
        // toolbarHeight: 0.12.sh,

        backgroundColor: white,

        flexibleSpace: TabBar(
          // labelPadding: EdgeInsets.zero,
          labelColor: black,
          controller: _controller,
          indicatorColor: Colors.blue,
          indicator: BoxDecoration(color: Colors.blue),
          tabs: [
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xffACACAC),
                  child: Icon(
                    Icons.shopping_bag,
                    color: white,
                    size: 15,
                  )),
              // text: 'Shopping',
              child: customText('Shopping', black, 15),
            ),
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xffACACAC),
                  child: Icon(
                    Icons.edit,
                    color: white,
                    size: 15,
                  )),
              // text: 'Retail Specials',
              child: customText('Retail Specials', black, 15),
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
