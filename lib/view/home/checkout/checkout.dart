import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController cuponCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), child: detailsPageAppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText('Delivary Options :', red, 20.0),
              SizedBox(
                height: 15,
              ),
              dropDownWidget('Delivary Options'),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(border: Border.all(color: black)),
                child: Column(
                  children: [
                    customText('Debit & Credit card Accepted', black, 18.0,
                        fontWeight: FontWeight.w400),
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
                    SizedBox(
                      height: 5,
                    ),
                    customText('Subtotal for n items: JMD\$250.40', black, 18.0,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 5,
                    ),
                    customText('Service fees: JMD\$250.40', black, 14.0,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),
                    customText(
                        'Shipping and handling: JMD\$250.40', black, 18.0,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 5,
                    ),
                    customText('All taxes: JMD\$250.40', black, 18.0,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 15,
                    ),
                    customText(
                        'Total Order: JMD\$250.40', Color(0xffFF0000), 20.0,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),
                    customText('Total in USD: \$250.40', black, 18.0,
                        fontWeight: FontWeight.w400),
                    // SizedBox(
                    //   width: 0.1.sw,
                    //   child: Row(
                    //     children: [
                    //       searchField(cuponCode, 'Enter Code'),
                    //       button(() {}, 'Apply', grey)
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    // customText('Please select a delivary option before paying',
                    //     Color(0xffFF0000), 18.0,
                    //     fontWeight: FontWeight.w400),
                    customText(
                        'Choose payment options', Color(0xffFF0000), 18.0,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 0.8.sw,
                      height: 0.09.sh,
                      child: button(() {}, 'Logon to xyz.com to pay with card',
                          Colors.blue, white),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Why ?',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.blue,
                          )),
                    ),
                    customText('OR', black, 20.0, fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 0.8.sw,
                      height: 0.09.sh,
                      child: button(() {}, 'Pick-up and Pay-in-store',
                          Colors.orange, white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customText('OR', black, 20.0, fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 0.8.sw,
                      height: 0.09.sh,
                      child: button(
                          () {}, 'Pay cash on delivary', Colors.green, white),
                    ),
                    TextButton(
                      onPressed: () {
                        learnMore();
                      },
                      child: Text('Learn More',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.blue,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Image.asset(checkout), Image.asset(strip)],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Center(
                child: customText('Review ordered List', black, 30.0,
                    fontWeight: FontWeight.w400),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText('Add note to seller', black, 20.0,
                      fontWeight: FontWeight.w400),
                  TextButton(
                    onPressed: () {
                      learnMore();
                    },
                    child: Text('Learn More',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        )),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(border: Border.all(color: black)),
                child: checkoutListView(
                    1,
                    () {},
                    oilGrocery,
                    red,
                    'Oil 0.5 L',
                    'JMD\$25.65',
                    'Delivary Included services fee',
                    'By: Altazar Fresh',
                    'Quantity: 1  Price: JMD\$24.26',
                    'Delete',
                    'Add note to seller', () {
                  addNotes();
                }),
              ),
              customText(
                  '© 2021 - YeahJamaica.com a Product of CITS Jamaica Limited',
                  black,
                  18.0,
                  fontWeight: FontWeight.w400),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addNotes() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Add a note to sellers  '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                customText('Enter A Quick Note To The Seller About Your Order:',
                    black, 20),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: grey),
                    ),
                    hintText: 'Add a note here ',
                  ),
                  // expands: true,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(
                  height: 15,
                ),
                button(() {}, 'Save and Close', white, black),
                SizedBox(
                  height: 5,
                ),
                button(() {
                  Get.back();
                }, 'Close', white, black),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> learnMore() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Learn More About the \'Add Note To Seller\' feature'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                /* --------- Service Fee ---------*/
                Center(child: customText("Service Fee", blue, 25)),
                customText(
                    "This is a fee that is charged on Grocery Items only and includes delivery. If the customer decided to pick-up their grocery in then the delivery fee will be waved from the service fee. ",
                    black,
                    15),
                SizedBox(
                  height: 15,
                ),
                /* --------- Shipping and Handling ---------*/
                Center(child: customText("Shipping and Handling", blue, 25)),
                customText(
                    'This is the delivery fee for none grocery items. This fee is based on the weignt of the items and the amount of sellers you are buying from.',
                    black,
                    15),
                SizedBox(
                  height: 15,
                ),
                /* --------- Service Fee ---------*/
                Center(
                    child: customText(
                        "How \"Pick-Up and Pay In-Store Or Cash On Delivery(C.O.D)\" Works",
                        blue,
                        25)),
                customText(
                    'The “Order and Pick-Up and Pay In-Store” is a feature of YeahJamaicaShop.com which allows you to order products or services form your favorite stores and pick-up and pay at the store. This allows you to save time, eliminate longline, save on delivery and reserve high demand products. The following are some example of how you can use the “Order and Pick-Up and Pay In-Store” feature:',
                    black,
                    15),
                SizedBox(
                  height: 5,
                ),
                customText(
                    '❂	Save time walking around in-store and waiting in line to check out. Example: order grocery online, auto parts, home improvement and building material, food and restaurant to-go',
                    black,
                    15),
                SizedBox(
                  height: 5,
                ),
                customText(
                    '❂	C.O.D means Cash On Delivery. This feature allows customers to order online and pay with cash an have their purchase delivered. NB: customers will have to pay for delivery as well',
                    black,
                    15),
                SizedBox(
                  height: 5,
                ),
                customText(
                    '❂	Save on delivery cost by simply pick-up and pay for your purchase ',
                    black,
                    15),
                SizedBox(
                  height: 5,
                ),
                customText(
                    '❂	Beat the holiday rush by ordering online ', black, 15),
                SizedBox(
                  height: 5,
                ),
                customText('❂	Reserve high demand items to avoid sold-out!',
                    black, 15),
                SizedBox(
                  height: 5,
                ),
                customText('❂	Reserve that Hot Deals & Specials', black, 15),
                SizedBox(
                  height: 5,
                ),
                customText('❂	Add more', black, 15),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
