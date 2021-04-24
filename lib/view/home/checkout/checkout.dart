import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                          Colors.blue),
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
                      child: button(
                          () {}, 'Pick-up and Pay-in-store', Colors.orange),
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
                      child:
                          button(() {}, 'Pay cash on delivary', Colors.green),
                    ),
                    TextButton(
                      onPressed: () {},
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
                    onPressed: () {},
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
                  'Add note to seller',
                ),
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
}
