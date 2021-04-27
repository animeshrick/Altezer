import 'package:flutter/material.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  TextEditingController searchController = TextEditingController();

  final List<String> imgList = [slider1, slider2];

  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        _scrollController.jumpTo(20);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Color(0xffEDEDED),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: 'Shoping Category',
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
                    'Shoping Category',
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
                  value: 'Sub Category',
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
                    'Sub Category',
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
              height: 20,
            ),
            Image.asset(banner1),
            SizedBox(
              height: 10,
            ),
            Text('Lateest Deals/Cupons',
                style: TextStyle(
                    color: grey, fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              padding: EdgeInsets.only(top: 12),
              width: 1.sw,
              height: 0.19.sh,
              child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (_, i) {
                    return Image.asset(slider2);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset(banner2),
            SizedBox(
              height: 10,
            ),
            Image.asset(banner3),
            SizedBox(
              height: 10,
            ),
            Image.asset(banner4),
            SizedBox(
              height: 10,
            ),
            Image.asset(banner8),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}