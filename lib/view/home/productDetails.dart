import 'package:altezar/api/apiCall.dart';
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

  ProductDetailsPage({required this.prdTypeId, required this.prdId});
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool pressed = false;
  TextEditingController quantityController = TextEditingController();
  // var _cartData = <CartBoxData>[].obs;

  Future<ProdDetailModel?>? _dealDetailFuture;
  void initState() {
    super.initState();
    _dealDetailFuture =
        networkcallService.getAllPrdDetails(widget.prdTypeId, widget.prdId);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      cartBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('ProductDetailsPage build');
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
                          Text(
                              '${detail.inStockOrOutOfStock} - ${detail.inStock}',
                              style: TextStyle(
                                  color: Colors.green[700], fontSize: 19)),
                          SizedBox(
                            height: 10,
                          ),
                          detail.size != null
                              ? detail.size != ''
                                  ? Text('Size - ${detail.size}',
                                      style: TextStyle(fontSize: 19))
                                  : Text('Size not available for that item',
                                      style: TextStyle(fontSize: 19))
                              : Text('Size not available for that item',
                                  style: TextStyle(fontSize: 19)),
                          SizedBox(
                            height: 10,
                          ),
                          detail.productColorStyleType != ''
                              ? detail.productColorStyleType != null
                                  ? Text(
                                      'Color - ${detail.productColorStyleType}',
                                      style: TextStyle(fontSize: 19))
                                  : Text('Color not available for that item',
                                      style: TextStyle(fontSize: 19))
                              : Text('Color not available for that item',
                                  style: TextStyle(fontSize: 19)),
                          SizedBox(
                            height: 20,
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
                                    _addToCart(
                                        '${detail.yjProductId}',
                                        '${detail.clientId}',
                                        'AutoParts',
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
                                            children: [
                                              Text(
                                                'Select List or Regitry and click add item',
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
                                              dropDownWidget(
                                                  'Select Your List or Regitry'),
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
                                                      child: button(
                                                          () {},
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
                          detail.shippingInfo != ''
                              ? detail.shippingInfo != null
                                  ? customText(
                                      'Shipping info ${detail.shippingInfo}',
                                      black,
                                      18.0)
                                  : Text('Shipping info not available')
                              : Text('Shipping info not available'),
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
                          Text('Suggestion Items',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 15,
                          ),
                          x == 0
                              ? customText('Data not dound', red, 18)
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
                                    // print('length - $x');
                                    return InkWell(
                                      onTap: () {
                                        print(
                                            '${sameList[i].yjProductId.toString()}');
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
                                                    "$imgBaseUrl${sameList[i].productUrl}",
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
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        '${sameList[i].productName}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .blueAccent)),
                                                    Text('${sameList[i].price}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                priceTextColor)),
                                                    Text(
                                                        '${sameList[i].brandName}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: grey)),
                                                    // Text('Shipping --- ${sameList[i].productName}',
                                                    //     style: TextStyle(fontSize: 16, color: black)),
                                                  ],
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
  }

  // void _cartBox() async {
  //   if (sp.getUserId() != null)
  //     _cartData.value = (await networkcallService
  //         .getCartBoxAPICall(sp.getUserId().toString()))!;
  //   print('l ${_cartData.length}');
  // }
}
