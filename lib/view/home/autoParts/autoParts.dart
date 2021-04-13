import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/autoParts/autoPartsDetails/autoPartsDetails.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AutoParts extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Color(0xffEDEDED),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: 'Parts Category',
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
                        'Parts Category',
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
                Card(
                  color: Color(0xffEDEDED),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: 'Parts Sub Category',
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
                        'Parts Sub Category',
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
                SizedBox(
                  height: 10,
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
                  height: 10,
                ),
                SizedBox(
                    height: 0.07.sh,
                    width: 1.sw,
                    child: button(() {}, 'Search', Color(0xffEC971F))),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    separatorBuilder: (_, __) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (_, i) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(AutoPartsDetails());
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
                                            fontSize: 20,
                                            color: Colors.blueAccent)),
                                    Text('JMD \$2700.00',
                                        style: TextStyle(
                                            fontSize: 16, color: red)),
                                    Text('Artquie',
                                        style: TextStyle(
                                            fontSize: 16, color: grey)),
                                    Text('Shipping --- FREE',
                                        style: TextStyle(
                                            fontSize: 16, color: black)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              button(() {}, 'View Details', Color(0xff5CB85C)),
                              button(() {}, 'Add to cart', Color(0xffD9534F)),
                            ],
                          )
                        ],
                      );
                    }),
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
    );
  }
}
