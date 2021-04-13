import 'package:altezar/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'dealsDetails/dealDetails.dart';

class Deals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Color(0xffEDEDED),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: 'Sort By',
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
                    'Sort By',
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
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (_, i) {
                  return InkWell(
                    onTap: () {
                      Get.to(DealsDetails());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          slider2,
                          width: 0.3.sw,
                          height: 0.2.sh,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Yea T-Shirt',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blueAccent)),
                            Text('JMD \$2700.00',
                                style: TextStyle(fontSize: 16, color: red)),
                            Text('Artquie',
                                style: TextStyle(fontSize: 16, color: grey)),
                            Text('Shipping --- FREE',
                                style: TextStyle(fontSize: 16, color: black)),
                          ],
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
