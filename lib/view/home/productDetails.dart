import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/RegistryListDropdownModel.dart';
import 'package:altezar/models/getCartBox.dart';
import 'package:altezar/models/productDetailsModel.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/utils/sharedPref.dart';
import 'package:altezar/view/auths/intro.dart';
import 'package:altezar/view/home/registry/addRegistry.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'cart/cart.dart';

class ProductDetailsPage extends StatefulWidget {
  final String prdTypeId;
  final String prdId;
  final String? action;

  ProductDetailsPage(
      {required this.prdTypeId, required this.prdId, this.action});
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool pressed = false;
  TextEditingController quantityController = TextEditingController();
  String? _regListVal, _regListId;
  List<RegistryListData> _regList = [];

  Future<ProdDetailModel?>? _dealDetailFuture;
  void initState() {
    super.initState();
    _dealDetailFuture =
        networkcallService.getAllPrdDetails(widget.prdTypeId, widget.prdId);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      cartBox();
      registry();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), child: detailsPageAppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// -------------- prd details -----------------
              FutureBuilder<ProdDetailModel?>(
                  future: _dealDetailFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var detail = snapshot.data!.details.first;
                      var rating = snapshot.data!.productReview.first;
                      var sameList = snapshot.data!.relatedProductlist;
                      var x = sameList.length;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${detail.productName}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          CachedNetworkImage(
                            imageUrl: "$imgBaseUrl${detail.productImageUrl}",
                            height: 0.5.sh,
                            width: 1.sw,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.network(imageNotFound),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: customText(
                                'Rating of the Product :', black, 18.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBarIndicator(
                                rating: rating.averageRating.toDouble(),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 25.0,
                                direction: Axis.horizontal,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              customText(
                                '[ ${rating.ratingCount} User rated ]',
                                black,
                                18.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('More Product Information',
                              style: TextStyle(
                                  color: Color(0xff8400FF), fontSize: 19)),
                          SizedBox(
                            height: 10,
                          ),
                          detail.inStock != null
                              ? Text('${detail.inStockOrOutOfStock}',
                                  style: TextStyle(
                                      color: Colors.green[700], fontSize: 19))
                              : Text('${detail.inStockOrOutOfStock}',
                                  style: TextStyle(
                                      color: Colors.green[700], fontSize: 19)),
                          SizedBox(
                            height: 10,
                          ),
                          detail.size != null
                              ? Text('Size - ${detail.size}',
                                  style: TextStyle(fontSize: 19))
                              : Text('Size - All Size(s)',
                                  style: TextStyle(fontSize: 19)),
                          SizedBox(
                            height: 10,
                          ),
                          detail.productColorStyleType != null &&
                                  detail.productColorStyleType != ''
                              ? Text('Color - ${detail.productColorStyleType}',
                                  style: TextStyle(fontSize: 19))
                              : Text('Colors - ',
                                  style: TextStyle(fontSize: 19)),
                          SizedBox(
                            height: 10,
                          ),
                          customText(
                              'Product description : ${detail.description}',
                              black,
                              15),
                          SizedBox(
                            height: 10,
                          ),
                          detail.sellerNameMobile != null
                              ? customText(
                                  '${detail.sellerNameMobile}', black, 16.0)
                              : Text('Seller Info not available for that item',
                                  style: TextStyle(fontSize: 19)),
                          SizedBox(
                            height: 5,
                          ),
                          customText(
                              'Price - ${detail.price}', priceTextColor, 16.0),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              hintText:
                                  'Enter your customized color and size -- ',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          sp.isLogin() == true
                              ? SizedBox(
                                  width: 0.95.sw,
                                  height: 0.08.sh,
                                  child: button(() {
                                    // print('${detail.yjProductId}');
                                    // print('${detail.clientId}');
                                    _addToCart(
                                        '${detail.yjProductId}',
                                        '${detail.clientId}',
                                        widget.action != null
                                            ? 'Autoparts'
                                            : 'Products',
                                        '',
                                        '',
                                        1.toString(),
                                        '',
                                        '',
                                        sp.getUserId().toString());
                                  }, 'Add to cart', Color(0xff5BC0DE), white))
                              : SizedBox(
                                  width: 0.95.sw,
                                  height: 0.08.sh,
                                  child: button(() {
                                    Get.to(() => gotoLoginPage());
                                  }, 'Add to cart', Color(0xff5BC0DE), white)),
                          SizedBox(
                            height: 15,
                          ),
                          sp.isLogin() == true
                              ? Card(
                                  color: Color(0xff337AB7),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.0,
                                        left: 6.0,
                                        right: 6.0,
                                        bottom: 6.0),
                                    child: ExpansionTile(
                                      backgroundColor: Color(0xff337AB7),
                                      //collapsedBackgroundColor: Colors.white,
                                      trailing: SizedBox(),
                                      childrenPadding: EdgeInsets.zero,
                                      textColor: black,
                                      initiallyExpanded: false,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      title: Container(
                                        height: 0.06.sh,
                                        width: double.infinity,
                                        color: Color(0xff337AB7),
                                        child: Center(
                                          child: Text(
                                            '+ Add to List Or Registry',
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      children: <Widget>[
                                        ColoredBox(
                                          color: white,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Select List or Registry and click add item',
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Select List :',
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Card(
                                                color: Colors.grey[300],
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    validator: (value) => value ==
                                                            null
                                                        ? 'Enter your List or Registry'
                                                        : null,
                                                    value: _regListVal,
                                                    isExpanded: true,
                                                    hint: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 15.0,
                                                      ),
                                                      child: Text(
                                                          'Choose your List or Registry'),
                                                    ),
                                                    icon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: CircleAvatar(
                                                          radius: 15,
                                                          backgroundColor: grey,
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color: white,
                                                          )),
                                                    ),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        _regListVal = newValue!;
                                                      });
                                                      _regListId = _regList
                                                          .where((element) =>
                                                              element
                                                                  .registryName ==
                                                              _regListVal)
                                                          .toList()
                                                          .first
                                                          .registryId
                                                          .toString();
                                                      print(
                                                          'stateId $_regListId');
                                                    },
                                                    items: _regList.map<
                                                        DropdownMenuItem<
                                                            String>>((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            value.registryName,
                                                        child: Text(
                                                          value.registryName,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Quantity :',
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              searchField(quantityController,
                                                  'Enter Quantity'),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Don\'t have a list?',
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.to(
                                                          () => AddRegistry());
                                                    },
                                                    child: Text(
                                                      'Click here',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      height: 0.05.sh,
                                                      width: 0.3.sw,
                                                      child: button(() {
                                                        // print(
                                                        //     'dd ${detail.yjProductId.toString()}');
                                                        if (_regListId ==
                                                            null) {
                                                          showToast(
                                                              'Choose your List/Registry',
                                                              red);
                                                        } else {
                                                          addItemToReg(
                                                              pID: detail
                                                                  .yjProductId
                                                                  .toString());
                                                        }
                                                      },
                                                          'Add item',
                                                          Color(0xffE3EDF3),
                                                          black)),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  SizedBox(
                                                      height: 0.05.sh,
                                                      width: 0.3.sw,
                                                      child: button(
                                                          () {},
                                                          'Cancel',
                                                          Color(0xffE3EDF3),
                                                          black)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Get.to(() => Intro(
                                          isChecked: false,
                                        ));
                                  },
                                  child: Container(
                                    height: 0.09.sh,
                                    width: double.infinity,
                                    color: Color(0xff337AB7),
                                    child: Center(
                                      child: Text(
                                        '+ Add to List Or Registry',
                                        style: TextStyle(
                                            color: white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          customText(
                              'Category of card accepted - ', black, 16.0),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                card1,
                                height: 50,
                                width: 50,
                              ),
                              Image.asset(
                                card2,
                                height: 50,
                                width: 50,
                              ),
                              Image.asset(
                                card3,
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(
                            height: 25,
                          ),
                          if (detail.freeShipping.toString() == '1')
                            customText('+Free Shipping', green, 16),
                          customText(
                              'Shipping islandwide, Caribbean, USA, Canada',
                              black,
                              16),
                          SizedBox(
                            height: 15,
                          ),
                          sp.isLogin() == true
                              ? Obx(() {
                                  if (cartData.length > 0 &&
                                      sp.isLogin() == true) {
                                    var data = cartData.first;
                                    return SizedBox(
                                        height: 0.08.sh,
                                        width: 1.sw,
                                        child: RaisedButton.icon(
                                          color: Color(0xff5BC0DE),
                                          onPressed: () {
                                            Get.to(() => CartPage());
                                          },
                                          icon: Icon(
                                              Icons.shopping_cart_outlined),
                                          label: Text(
                                              'Order Cart *(${data.orderCartCount})* || JMD\$${data.subtotal}'),
                                        )
                                        // label: Text('Order Cart *(${_cartData.exc})* || \$0.0')),
                                        );
                                  }
                                  return Container();
                                })
                              : SizedBox(
                                  width: 0.95.sw,
                                  height: 0.08.sh,
                                  child: RaisedButton.icon(
                                      color: Color(0xff5BC0DE),
                                      onPressed: () {
                                        Get.to(() => Intro(
                                              isChecked: false,
                                            ));
                                      },
                                      icon: Icon(Icons.shopping_cart_outlined),
                                      label:
                                          Text('Order Cart *(0)* || \$ 0.0')),
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('Related Items',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          x == 0
                              ? customText('Data not found', red, 18)
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: sameList.length,
                                  separatorBuilder: (_, __) {
                                    return SizedBox(
                                      height: 15,
                                    );
                                  },
                                  itemBuilder: (_, i) {
                                    print(
                                        'length - $imgBaseUrl${sameList[i].productUrl}');
                                    return InkWell(
                                      onTap: () {
                                        // print(
                                        //     '${sameList[i].yjProductId.toString()}');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsPage(
                                                      prdTypeId: '1',
                                                      prdId: sameList[i]
                                                          .yjProductId
                                                          .toString(),
                                                    )));
                                        // Get.to(() => ProductDetailsPage(
                                        //       prdTypeId: '1',
                                        //       prdId: sameList[i]
                                        //           .yjProductId
                                        //           .toString(),
                                        //     ));
                                      },
                                      child: Card(
                                        color: Color(0xffF2F2F2),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "$imgBaseUrl${sameList[i].productImageUrl}",
                                                height: 0.15.sh,
                                                width: 0.2.sw,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.network(
                                                            imageNotFound),
                                              ),
                                              SizedBox(
                                                width: 0.1.sw,
                                              ),
                                              Flexible(
                                                child: SizedBox(
                                                  width: 0.4.sw,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          '${sameList[i].productName}',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .blueAccent)),
                                                      Text(
                                                          '${sameList[i].price}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  priceTextColor)),
                                                      Text(
                                                          '${sameList[i].brandName}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: grey)),
                                                      // Text('Shipping --- ${sameList[i].productName}',
                                                      //     style: TextStyle(fontSize: 16, color: black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        ],
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

  void _addToCart(
      String prdID,
      String clientId,
      String orderType,
      String selectedStyle,
      String mtoInfo,
      String qty,
      String mtoDelivaryDate,
      String mtoImgPath,
      String userId) async {
    showProgress(context);
    // print(
    //     'addtoCart $prdID $clientId $orderType $selectedStyle $mtoInfo $qty $mtoDelivaryDate $mtoImgPath $userId');
    var data = await networkcallService.addToCartAPICall(
        prdID,
        clientId,
        orderType,
        selectedStyle,
        mtoInfo,
        qty,
        mtoDelivaryDate,
        mtoImgPath,
        userId);
    hideProgress(context);
  }

  void registry() async {
    showProgress(context);
    var res = await networkcallService
        .getRegistryListDropdown(sp.getUserId().toString());
    _regList = res;
    setState(() {});
    hideProgress(context);
  }

  void addItemToReg({required String pID}) async {
    showProgress(context);
    var res = await networkcallService.getAddPrdToRegList(
      listId: _regListId.toString(),
      prdId: pID,
      qty: quantityController.text,
    );
    hideProgress(context);
    if (res) {
      quantityController.clear();
      _regListId = null;
      _regListVal = null;
      // _regList = [];
    }
  }
}
