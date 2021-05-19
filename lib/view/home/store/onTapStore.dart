import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getStoreList.dart';
import 'package:altezar/models/groceryStateList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/store/storeDetails.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  Future<List<StoreList>?>? _storefuture;

  String? _groceryStateValue;

  List<StoreList>? list;

  List<GetGroceryStateList> _groceryStateList = [];

  @override
  void initState() {
    super.initState();
    _storefuture = networkcallService.getStoreListAPICall('0', '');
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appbarColor,
        title: Row(
          children: [
            IconButton(
                onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
            // FlatButton.icon(
            //     padding: EdgeInsets.zero,
            //     onPressed: () {
            //       Get.back();
            //     },
            //     color: white,
            //     icon: CircleAvatar(
            //         radius: 15,
            //         backgroundColor: grey,
            //         child: Icon(
            //           Icons.home,
            //           color: white,
            //         )),
            //     label: customText("Home", black, 15.0)),
            SizedBox(
              width: 0.2.sw,
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
              Image.asset(banner1),
              SizedBox(
                height: 10,
              ),
              searchField(searchController, 'Enter a store name to search'),
              SizedBox(
                height: 10,
              ),
              Card(
                color: Color(0xffEDEDED),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: customText('Parish', black, 18.0),
                    ),
                    value: _groceryStateValue,
                    items: _groceryStateList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value.groceryStateName,
                        child: Text(
                          value.groceryStateName,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _groceryStateValue = value!;
                      });
                    },
                  ),
                ),
              ),
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
              FutureBuilder<List<StoreList>?>(
                  future: _storefuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      list = snapshot.data;
                      return SizedBox(
                        height: 1.0.sh,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
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
                                child: InkWell(
                                  onTap: () => Get.to(() => StoreDetailsPage(
                                        storeId: list![i].clientId,
                                      )),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "$imgBaseUrl${list![i].clientLogoURL}",
                                        height: 0.2.sh,
                                        width: 0.3.sw,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Image.network(imageNotFound),
                                      ),
                                      customText(
                                          '${list![i].clientName}', black, 18),
                                    ],
                                  ),
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

  void _getData() async {
    final groceryStateResult =
        await networkcallService.getGroceryStateListAPICall();
    if (groceryStateResult != null) {
      setState(() {
        _groceryStateList = groceryStateResult;
      });
    }
  }
}
