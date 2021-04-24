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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(() {}, 'View Details', greenColor),
                  SizedBox(
                    width: 20,
                  ),
                  button(() {}, 'Add to Cart', priceTextColor),
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