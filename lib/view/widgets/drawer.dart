import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/auths/intro.dart';
import 'package:altezar/view/home/cart/cart.dart';
import 'package:altezar/view/home/orders/orders.dart';
import 'package:altezar/view/home/registry/addRegistry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customDrawer() {
  return Drawer(
    child: Padding(
      padding: EdgeInsets.fromLTRB(15, 70, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customInkWellText(() {
            Get.back();
          }, 'Home', green, 22.0),
          SizedBox(
            height: 20,
          ),
          customInkWellText(() {
            Get.to(() => CartPage());
          }, 'View Cart', buttonColor, 22.0),
          SizedBox(
            height: 20,
          ),
          customInkWellText(() {
            Get.to(() => Orders());
          }, 'My Orders', buttonColor, 22.0),
          SizedBox(
            height: 20,
          ),
          customInkWellText(() {
            Get.to(() => AddRegistry());
          }, 'My List and Registry', buttonColor, 22.0),
          SizedBox(
            height: 20,
          ),
          customInkWellText(() {
            Get.to(() => AddRegistry());
          }, 'Create List or Registry', buttonColor, 22.0),
          SizedBox(
            height: 20,
          ),
          Flexible(
              child: customInkWellText(() {
            sp.clear();
            Get.offAll(Intro(isChecked: false));
          }, 'Welcome ${sp.getFirstName()} ${sp.getLastName()} \n Sign-out',
                  green, 22.0)),
        ],
      ),
    ),
  );
}
