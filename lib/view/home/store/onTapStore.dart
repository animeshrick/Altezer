import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getStoreList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnTapStore extends StatefulWidget {
  @override
  _OnTapStoreState createState() => _OnTapStoreState();
}

class _OnTapStoreState extends State<OnTapStore> {
  TextEditingController searchController = TextEditingController();

  Future<StoreList>? _storefuture;
  @override
  void initState() {
    super.initState();
    _storefuture =
        networkcallService.getStoreListAPICall('0', '') as Future<StoreList>?;
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 15, top: 15),
          child: Column(
            children: [
              Image.asset(banner6),
              SizedBox(
                height: 10,
              ),
              searchField(searchController, 'Enter a store name to search'),
              SizedBox(
                height: 10,
              ),
              dropDownWidget('Parish'),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 0.07.sh,
                width: 1.sw,
                child: button(() {}, 'Search', searchBtnColor, white),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<Object>(
                  future: null,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // List list = snapshot.hasData;
                      return SizedBox(
                        height: 1.0.sh,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: 10,
                            itemBuilder: (context, i) {
                              return Card(
                                color: grey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(strip),
                                    customText('Altezer Fresh', black, 18),
                                  ],
                                ),
                              );
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: customText('${snapshot.error}', red, 20.0));
                    } else
                      return Center(
                        child: CupertinoActivityIndicator(
                          radius: 25,
                        ),
                      );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
