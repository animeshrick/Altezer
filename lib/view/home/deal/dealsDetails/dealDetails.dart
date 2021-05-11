import 'package:altezar/api/apiCall.dart';
import 'package:altezar/models/productDetails.dart';
import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/checkout/checkout.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/button.dart';
import '../../addRegistry.dart';

class DealsDetails extends StatefulWidget {
  final String prdTypeId;
  final String prdId;

  const DealsDetails({required this.prdTypeId, required this.prdId});
  @override
  _DealsDetailsState createState() => _DealsDetailsState();
}

class _DealsDetailsState extends State<DealsDetails> {
  bool sizeCheckedValue = false;
  bool colorCheckedValue = false;
  bool pressed = false;
  TextEditingController quantityController = TextEditingController();

  Future<GetRestList>? _dealDetailFuture;
  void initState() {
    super.initState();
    _dealDetailFuture = networkcallService.getAllPrdDetails(
        widget.prdTypeId, widget.prdId) as Future<GetRestList>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), child: detailsPageAppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// -------------- prd details -----------------
              FutureBuilder<GetRestList>(
                  future: _dealDetailFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var detail = snapshot.data!.details.first;
                      var rating = snapshot.data!.productReview.first;
                      var sameList = snapshot.data!.relatedProductlist;
                      return Column(
                        children: [
                          Text('${detail.productName}',
                              style: TextStyle(fontSize: 24)),
                          CachedNetworkImage(
                            imageUrl: "$imgBaseUrl${detail.productImageUrl}",
                            height: 0.2.sh,
                            width: 0.3.sw,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.network(imageNotFound),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rating of the Product :',
                                style: TextStyle(fontSize: 19),
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: rating.ratingCount.toDouble(),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 25.0,
                                    direction: Axis.horizontal,
                                  ),
                                  SizedBox(
                                    width: 0.1.sw,
                                  ),
                                ],
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
                          Text('Size - ${detail.size}  ',
                              style: TextStyle(fontSize: 19)),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Color :', style: TextStyle(fontSize: 19)),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: customText(
                                  '${detail.sellerNameMobile}', black, 16.0)),
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
                          SizedBox(
                              width: 0.95.sw,
                              height: 0.08.sh,
                              child: button(() {
                                // Get.to(CheckOut());
                                setState(() {
                                  pressed = !pressed;
                                });
                              }, pressed ? 'Order Placed' : 'Add to cart',
                                  Color(0xff5BC0DE), white)),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            color: Color(0xff337AB7),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0, left: 6.0, right: 6.0, bottom: 6.0),
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
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.to(AddRegistry());
                                              },
                                              child: Text(
                                                'Click here',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
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
                                                child: button(() {}, 'Add item',
                                                    Color(0xffE3EDF3), black)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                                height: 0.05.sh,
                                                width: 0.3.sw,
                                                child: button(() {}, 'Cancel',
                                                    Color(0xffE3EDF3), black)),
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
                          customText(
                              'Shipping Kolkata, Durgapur, Asasnsol, Burdwan, Hawrah, Siliguri, Nadia',
                              black,
                              18.0),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 0.95.sw,
                            height: 0.08.sh,
                            child: RaisedButton.icon(
                                color: Color(0xff5BC0DE),
                                onPressed: () {
                                  Get.to(CheckOut());
                                },
                                icon: Icon(Icons.shopping_cart_outlined),
                                label: Text('Order Cart *(0)* || \$ 0.0')),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('Suggestion Items',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400))),
                          SizedBox(
                            height: 15,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: sameList.length,
                              separatorBuilder: (_, __) {
                                return SizedBox(
                                  height: 15,
                                );
                              },
                              itemBuilder: (_, i) {
                                return ColoredBox(
                                  color: Color(0xffF2F2F2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "$imgBaseUrl${sameList[i].productUrl}",
                                        height: 0.25.sh,
                                        width: 0.2.sw,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Image.network(imageNotFound),
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text('${sameList[i].productName}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.blueAccent)),
                                            Text('${sameList[i].price}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: priceTextColor)),
                                            Text('${sameList[i].brandName}',
                                                style: TextStyle(
                                                    fontSize: 16, color: grey)),
                                            // Text('Shipping --- ${sameList[i].productName}',
                                            //     style: TextStyle(fontSize: 16, color: black)),
                                          ],
                                        ),
                                      ),
                                    ],
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
}
