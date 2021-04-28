import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/checkout/checkout.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/button.dart';
import '../../addRegistry.dart';

class DealsDetails extends StatefulWidget {
  @override
  _DealsDetailsState createState() => _DealsDetailsState();
}

class _DealsDetailsState extends State<DealsDetails> {
  bool sizeCheckedValue = false;
  bool colorCheckedValue = false;
  bool pressed = false;
  TextEditingController quantityController = TextEditingController();

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
              Text('Yea T-Shirt', style: TextStyle(fontSize: 24)),
              Image.asset(
                slider2,
                width: 0.5.sw,
                height: 0.2.sh,
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
                        rating: 2.5,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 30.0,
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
                  style: TextStyle(color: Color(0xff8400FF), fontSize: 19)),
              Text('In Stock',
                  style: TextStyle(color: Colors.green[700], fontSize: 19)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Size :', style: TextStyle(fontSize: 19)),
                  Checkbox(
                    onChanged: (val) {
                      setState(() {
                        sizeCheckedValue = val!;
                      });
                    },
                    value: sizeCheckedValue,
                  ),
                  Text('S'),
                  Checkbox(
                    onChanged: (val) {
                      setState(() {
                        sizeCheckedValue = val!;
                      });
                    },
                    value: sizeCheckedValue,
                  ),
                  Text('M'),
                  Checkbox(
                    onChanged: (val) {
                      setState(() {
                        sizeCheckedValue = val!;
                      });
                    },
                    value: sizeCheckedValue,
                  ),
                  Text('L'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Color :', style: TextStyle(fontSize: 19)),
                  Checkbox(
                    activeColor: Colors.red,
                    onChanged: (val) {
                      setState(() {
                        colorCheckedValue = val!;
                      });
                    },
                    value: colorCheckedValue,
                  ),
                  Text('Red'),
                  Checkbox(
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      setState(() {
                        colorCheckedValue = val!;
                      });
                    },
                    value: colorCheckedValue,
                  ),
                  Text('Blue'),
                  Checkbox(
                    activeColor: Colors.black,
                    onChanged: (val) {
                      setState(() {
                        colorCheckedValue = val!;
                      });
                    },
                    value: colorCheckedValue,
                  ),
                  Text('Black'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              customText('Durgapur, West Bangal, India', black, 16.0),
              SizedBox(
                height: 5,
              ),
              customText('Call - 5845841584 / 89657458963', black, 16.0),
              SizedBox(
                height: 5,
              ),
              customText(
                  'Price - JMD\$2,700.00 | USD\$18.47', priceTextColor, 16.0),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'Enter your customized color and size -- ',
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
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
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
                            dropDownWidget('Select Your List or Regitry'),
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
                            searchField(quantityController, 'Enter Quantity'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
              // SizedBox(
              //     width: 1.sw,
              //     height: 0.06.sh,
              //     child: button(
              //         () {}, '+ Add to List Or Registry', Color(0xff337AB7))),
              SizedBox(
                height: 15,
              ),
              customText('Category of card accepted - ', black, 16.0),
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
                          fontSize: 20, fontWeight: FontWeight.w400))),
              SizedBox(
                height: 15,
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
                    return ColoredBox(
                      color: Color(0xffF2F2F2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            slider2,
                            width: 0.4.sw,
                            height: 0.2.sh,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Yea T-Shirt',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blueAccent)),
                              Text('JMD \$2700.00',
                                  style: TextStyle(
                                      fontSize: 16, color: priceTextColor)),
                              Text('Artquie',
                                  style: TextStyle(fontSize: 16, color: grey)),
                              Text('Shipping --- FREE',
                                  style: TextStyle(fontSize: 16, color: black)),
                            ],
                          ),
                        ],
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
