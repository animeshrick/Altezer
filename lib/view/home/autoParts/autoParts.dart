import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getAutoPartsCat.dart';
import 'package:altezar/models/getAutoPartsSubCat.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AutoParts extends StatefulWidget {
  @override
  _AutoPartsState createState() => _AutoPartsState();
}

class _AutoPartsState extends State<AutoParts> {
  TextEditingController searchController = TextEditingController();

  String? _autoCatVal, _autoSubCatVal;
  String? _autoCatId, _autoSubCatId;

  List<AutoPartsCategory>? _autoPartsCategoryList;
  List<AutoPartsSubcategory>? _autoPartsSubCategoryList;

  @override
  void initState() {
    super.initState();
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
                  Card(
                    color: Color(0xffEDEDED),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        value: _autoCatVal,
                        hint: Text('Parts Category'),
                        items: _autoPartsCategoryList?.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(
                              value.name,
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _autoCatVal = value!;
                          });
                          _autoCatId = _autoPartsCategoryList!
                              .where((element) => element.name == _autoCatVal)
                              .toList()
                              .first
                              .productCategorySub1Id
                              .toString();
                          print('_autoCatId  $_autoCatId');
                          _getSubAutoCat(_autoCatId!);
                        },
                      ),
                    ),
                  ),
                  Card(
                    color: Color(0xffEDEDED),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        value: _autoSubCatVal,
                        hint: Text('Parts Sub-Category'),
                        items: _autoPartsSubCategoryList?.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.subname,
                            child: Text(
                              value.subname,
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _autoSubCatVal = value!;
                          });
                          _autoSubCatId = _autoPartsSubCategoryList!
                              .where((element) =>
                                  element.subname == _autoSubCatVal)
                              .toList()
                              .first
                              .productCategorySub2Id
                              .toString();
                          print('_autoSubCatId  $_autoSubCatId');
                          // _getSubAutoCat(_autoCatId!);
                        },
                      ),
                    ),
                  ),
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
                      child: button(() {}, 'Search', Color(0xffEC971F), white)),
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
                    label: Text('Order Cart *(0)* || \$0.0')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getData() async {
    final autoCatResult = await networkcallService.getPartsCatAPICall();
    if (autoCatResult != null) {
      setState(() {
        _autoPartsCategoryList = autoCatResult;
      });
    }
  }

  void _getSubAutoCat(String autoCatId) async {
    showProgress(context);
    _autoPartsSubCategoryList =
        (await networkcallService.getPartsSubCatAPICall(autoCatId))!;
    hideProgress(context);
    setState(() {});
  }
}
