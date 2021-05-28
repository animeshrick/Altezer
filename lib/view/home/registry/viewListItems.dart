import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/autoParts/autoParts.dart';
import 'package:altezar/view/home/cart/cart.dart';
import 'package:altezar/view/home/deal/deals.dart';
import 'package:altezar/view/home/food/food.dart';
import 'package:altezar/view/home/grocery/grocery.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewListItems extends StatelessWidget {
  bool isLogin = true;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: isLogin,
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
                    Get.to(() => CartPage());
                  },
                  color: white,
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: Text('0')),
            ),
          ],
        ),
        backgroundColor: appbarColor,
      ),
      drawer: Drawer(
        child: Text('hello'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: appbarColor,
                child: Row(
                  children: [
                    tabbarButton(() {
                      // Get.to(OnTapStore());
                    }, 'Quick Links :', white, 15.0),
                    tabbarButton(() {
                      Get.to(Deals());
                    }, 'Deals', Color(0xffDC7633), 15.0),
                    tabbarButton(() {
                      Get.to(Grocery());
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                      'Product Name || Total itemss : 5 || \nList/Registry Type : Type',
                      black,
                      22.0),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: customUnderlineText(
                          'Add List Item(s) to cart', priceTextColor, 18.0)),
                  viewListedItemsListView(
                      5,
                      oilGrocery,
                      Colors.red,
                      'Harbal Oil',
                      Color(0xff0051FC),
                      'Homeo',
                      Color(0xff0051FC),
                      '\$500.25',
                      greenColor,
                      'By : Altezer Fresh',
                      grey,
                      'Qty : 1',
                      black,
                      'Remove',
                      'Add to cart'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
