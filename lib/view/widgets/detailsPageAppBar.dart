import 'package:altezar/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget detailsPageAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: AppBar(
      centerTitle: true,
      backgroundColor: appbarColor,
      title: Image.asset(
        appbarImg,
        height: 0.1.sh,
      ),
    ),
  );
}
