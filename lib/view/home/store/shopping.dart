import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/getCategories.dart';
import 'package:altezar/models/getSubCatList.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  TextEditingController searchController = TextEditingController();

  String? _categoriesName, _subCatName; //value
  String? productId;
  List<CategoriesList> _catList = [];
  List<GetSubCateProductsList> _subCatList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  value: _categoriesName, //'Shoping Category',
                  hint: Text('Select Category'),
                  items: _catList.map((value) {
                    return DropdownMenuItem<String>(
                      value: value.prdName,
                      child: Text(
                        value.prdName,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    print('value $value');
                    setState(() {
                      _categoriesName = value!;
                    });

                    productId = _catList
                        .where((element) => element.prdName == _categoriesName)
                        .toList()
                        .first
                        .prdId
                        .toString();
                    _subCatName = null;
                    _getSubCat(productId!);
                    print('productId - $productId');
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
                  value: _subCatName, //'Sub Category',
                  hint: Text('Select Sub Category'),
                  items: _subCatList.map((value) {
                    return DropdownMenuItem<String>(
                      value: value.prdName,
                      child: Text(
                        value.prdName,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _subCatName = value!;
                    });
                  },
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
                child: button(() {}, 'Search', Color(0xffEC971F), white)),
            SizedBox(
              height: 20,
            ),
            if (productId == null)
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(banner1),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Lateest Deals/Cupons',
                        style: TextStyle(
                            color: grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      // width: 1.sw,
                      height: 0.19.sh,
                      child: Swiper(
                          // controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          duration: 2000,
                          itemCount: 10,
                          autoplay: true,
                          viewportFraction: 0.4,
                          itemBuilder: (_, i) {
                            return Container(child: Image.asset(slider2));
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
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            if (productId != null)
              viewListedItemsListView2(
                  3,
                  oilGrocery,
                  blue,
                  'Harbal oil',
                  blue,
                  '500 ml',
                  green,
                  'JMD \$33.65',
                  green,
                  'USD \$45.03',
                  red,
                  'Out of stock',
                  Colors.red,
                  'View Details',
                  'Add to cart'),
          ],
        ),
      ),
    );
  }

  void _getData() async {
    final result = await networkcallService.getCategoriesAPICall();
    if (result != null) {
      setState(() {
        _catList = result;
      });
    }
  }

  void _getSubCat(String catId) async {
    showProgress(context);
    _subCatList = (await networkcallService.getSubCatAPICall(catId))!;
    hideProgress(context);
    setState(() {});
  }
}
