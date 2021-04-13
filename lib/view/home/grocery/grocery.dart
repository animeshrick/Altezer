import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:altezar/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'groceryDetails/groceryDdetails.dart';

class Grocery extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(banner1),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: searchController,
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Search here ......',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              color: Color(0xffEDEDED),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: 'Parish',
                  elevation: 16,
                  icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: grey,
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: white,
                        size: 30,
                      )),
                  isExpanded: true,
                  items: <String>[
                    'Parish',
                    'Dept2',
                    'Dept2',
                    'Dept2',
                    'Dept2',
                  ].map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 0.07.sh,
                width: 1.sw,
                child: button(() {}, 'Search', Color(0xffEC971F))),
            Container(
              padding: EdgeInsets.only(right: 15, top: 15),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (_, i) {
                    return InkWell(
                      onTap: () {
                        Get.to(GroceryDetails());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            groceryImg,
                            width: 0.2.sw,
                            height: 0.2.sh,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Alterz Fresh',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blueAccent)),
                              Text('Online Ordering',
                                  style: TextStyle(fontSize: 16, color: red)),
                              Text('Kingstone,Kingstone',
                                  style: TextStyle(fontSize: 16, color: grey)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
