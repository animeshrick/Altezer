import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget listView(int itemCount, Function() onTap, String imgName, Color color,
    String text1, String text2, String text3) {
  return ListView.separated(
      separatorBuilder: (_, __) => SizedBox(
            height: 20,
          ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, i) {
        return InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    imgName,
                    width: 0.4.sw,
                    height: 0.2.sh,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(text1,
                          style: TextStyle(fontSize: 20, color: Colors.blue)),
                      Text(text2,
                          style:
                              TextStyle(fontSize: 16, color: priceTextColor)),
                      Text(text3,
                          style: TextStyle(fontSize: 16, color: Colors.green)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(() {
                    // Get.to(Details());
                  }, 'View Details', greenColor, white),
                  SizedBox(
                    width: 20,
                  ),
                  button(() {}, 'Add to Cart', priceTextColor, white),
                ],
              ),
            ],
          ),
        );
      });
}

Widget groceryListView(int itemCount, Function() onTap, String imgName,
    String text1, String text2, String text3, String text4, String text5) {
  return ListView.separated(
      separatorBuilder: (_, __) => SizedBox(
            height: 20,
          ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, i) {
        return InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    imgName,
                    width: 0.4.sw,
                    height: 0.2.sh,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(text1,
                          style: TextStyle(fontSize: 20, color: Colors.blue)),
                      Text(text2, style: TextStyle(fontSize: 16, color: blue)),
                      Text(text3,
                          style: TextStyle(fontSize: 16, color: greenColor)),
                      Text(text4,
                          style: TextStyle(fontSize: 16, color: greenColor)),
                      Text(text5,
                          style: TextStyle(fontSize: 16, color: Colors.green)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(() {}, 'View Details', greenColor, white),
                  SizedBox(
                    width: 20,
                  ),
                  button(() {}, 'Add to Cart', priceTextColor, white),
                ],
              ),
            ],
          ),
        );
      });
}

Widget checkoutListView(
  int itemCount,
  Function() onTap,
  String imgName,
  Color color,
  String text1,
  String text2,
  String text3,
  String text4,
  String text5,
  String text6,
  String text7,
) {
  return ListView.separated(
      separatorBuilder: (_, __) => SizedBox(
            height: 20,
          ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, i) {
        return InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imgName,
                width: 0.4.sw,
                height: 0.2.sh,
              ),
              Text(text1,
                  style: TextStyle(fontSize: 20, color: Colors.blue[900])),
              Text(text2,
                  style: TextStyle(fontSize: 20, color: Colors.green[900])),
              Text(text3,
                  style: TextStyle(fontSize: 20, color: Colors.green[900])),
              Text(text4, style: TextStyle(fontSize: 20, color: grey)),
              Text(text5,
                  style: TextStyle(fontSize: 20, color: Color(0xffFF0000))),
              Text(text6,
                  style: TextStyle(fontSize: 20, color: Color(0xffFF0000))),
              Text(text7,
                  style: TextStyle(fontSize: 20, color: Colors.blue[800])),
              SizedBox(
                height: 15,
              )
            ],
          ),
        );
      });
}

Widget registryListView(
    int itemCount,
    String text1,
    String text2,
    String text3,
    String text4,
    String text5,
    String text6,
    String text7,
    String text8,
    Function() textButtonTap) {
  return ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: itemCount,
    separatorBuilder: (_, __) => SizedBox(
      height: 20,
    ),
    itemBuilder: (_, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(text1, black, 18.0),
          customText(text2, black, 18.0),
          customText(text3, black, 18.0),
          customText(text4, black, 18.0),
          customText(text5, black, 18.0),
          customText(text6, black, 18.0),
          customText(text7, black, 18.0),
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: textButtonTap,
              child: customText(text8, Color(0xff0000FF), 18.0)),
        ],
      );
    },
  );
}

Widget viewListedItemsListView(
    int itemCount,
    String imgName,
    Color color,
    String text1,
    Color color1,
    String text2,
    Color color2,
    String text3,
    Color color3,
    String text4,
    Color color4,
    String text5,
    Color color5,
    String btnText1,
    String btnText2) {
  return ListView.separated(
      separatorBuilder: (_, __) => SizedBox(
            height: 20,
          ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, i) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  imgName,
                  width: 0.4.sw,
                  height: 0.2.sh,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(text1, style: TextStyle(fontSize: 20, color: color1)),
                    Text(text2, style: TextStyle(fontSize: 16, color: color2)),
                    Text(text3, style: TextStyle(fontSize: 16, color: color3)),
                    Text(text4, style: TextStyle(fontSize: 16, color: color4)),
                    Text(text5, style: TextStyle(fontSize: 16, color: color5)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(() {}, btnText1, Color(0xffF0AD4E), white),
                SizedBox(
                  width: 20,
                ),
                button(() {}, btnText2, Color(0xffD9534F), white),
              ],
            ),
          ],
        );
      });
}
