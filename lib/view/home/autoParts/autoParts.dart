import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/autoParts/autoPartsDetails/autoPartsDetails.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AutoParts extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appbarColor,
        title: Row(
          children: [
            FlatButton.icon(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Get.back();
                },
                color: white,
                icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: grey,
                    child: Icon(
                      Icons.home,
                      color: white,
                    )),
                label: customText("Home", black, 15.0)),
            SizedBox(
              width: 0.15.sw,
            ),
            Image.asset(
              appbarImg,
              height: 0.1.sh,
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(autoParts),
                  dropDownWidget('Parts Category'),
                  dropDownWidget('Parts sub category'),
                  dropDownWidget('Sort by'),
                  SizedBox(
                    height: 10,
                  ),
                  searchField(
                      searchController, 'Search Product Name, Brand etc ...'),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 0.07.sh,
                      width: 1.sw,
                      child: button(() {}, 'Search', Color(0xffEC971F))),
                  SizedBox(
                    height: 10,
                  ),
                  listView(5, () {}, parts, red, 'Auto Parts', 'JMD\$25.54',
                      'By: Altexar'),
                ],
              ),
            )),
            Material(
              child: SizedBox(
                height: 0.06.sh,
                child: RaisedButton.icon(
                    color: Color(0xff5BC0DE),
                    onPressed: () {},
                    icon: Icon(Icons.card_travel_rounded),
                    label: Text('Order Cart *(0)* || \$ 0.0')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
