import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/groceryStateList.dart';
import 'package:altezar/models/groceryStoreList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'groceryDetails/groceryDdetails.dart';

class Grocery extends StatefulWidget {
  @override
  _GroceryState createState() => _GroceryState();
}

class _GroceryState extends State<Grocery> {
  TextEditingController searchController = TextEditingController();

  String? _groceryStateValue;
  String? _groceryStateId;
  List<GetGroceryStateList> _groceryStateList = [];
  bool _isShow = false;

  Future<List<GetGroceryStoreList>?>? _groceryStoreFuture;

  @override
  void initState() {
    super.initState();
    // _groceryStoreFuture = networkcallService.getGroceryStoreListAPICall(
    //     _groceryStateId.toString(), '');
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
      _isShow = true;
      _getGroceryStoreData();
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
      body: Container(
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
                decoration: InputDecoration(
                  hintText: 'Enter a store name to search',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
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
                      child: customText('Choose an option', black, 18.0),
                    ),
                    value: _groceryStateValue,
                    items: _groceryStateList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value.groceryStateName,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            value.groceryStateName,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _groceryStateValue = value!;
                      });
                      // ------------- id ----------
                      _groceryStateId = _groceryStateList
                          .where((element) =>
                              element.groceryStateName == _groceryStateValue)
                          .toList()
                          .first
                          .groceryStateId
                          .toString();
                      print('id- $_groceryStateId');
                      _getGroceryStoreData();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 0.07.sh,
                width: 1.sw,
                child: button(() {
                  // print('id- $_groceryStateId');
                  setState(() {
                    _isShow = true;
                  });

                  _getGroceryStoreData();
                }, 'Search', Color(0xffEC971F), white),
              ),
              SizedBox(height: 20),
              if (_isShow)
                FutureBuilder<List<GetGroceryStoreList>?>(
                    future: _groceryStoreFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var list = snapshot.data!;
                        return ListView.separated(
                            separatorBuilder: (_, __) => SizedBox(
                                  height: 15,
                                ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (_, i) {
                              return ColoredBox(
                                color: Color(0xffE8E8E8),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => GroceryDetailsPage(
                                          storeId: list[i].cId,
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$imgBaseUrl${list[i].storeLogoUrl}",
                                          width: 0.3.sw,
                                          height: 0.2.sh,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.network(imageNotFound),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text('${list[i].storeName}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color:
                                                          Color(0xff0000FF))),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              customText('Online Ordering',
                                                  Color(0xff8C9093), 15.0),
                                              Text('${list[i].storeLocation}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          Color(0xff8C9093))),
                                              // Text('${list[i].storeName}',
                                              //     style: TextStyle(
                                              //         fontSize: 16, color: grey)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
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

  void _getGroceryStoreData() async {
    _groceryStoreFuture = networkcallService.getGroceryStoreListAPICall(
        _groceryStateId ?? '0', searchController.text);

    setState(() {});
  }
}
