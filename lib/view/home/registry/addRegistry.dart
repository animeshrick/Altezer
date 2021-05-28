import 'package:altezar/utils/const.dart';
import 'package:altezar/view/home/autoParts/autoParts.dart';
import 'package:altezar/view/home/cart/cart.dart';
import 'package:altezar/view/home/deal/deals.dart';
import 'package:altezar/view/home/food/food.dart';
import 'package:altezar/view/home/grocery/grocery.dart';
import 'package:altezar/view/home/registry/viewListItems.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddRegistry extends StatefulWidget {
  @override
  _AddRegistryState createState() => _AddRegistryState();
}

class _AddRegistryState extends State<AddRegistry> {
  bool valueFirst = false;
  bool isLogin = true;
  TextEditingController searchController = TextEditingController();
  TextEditingController listNameController = TextEditingController();
  TextEditingController benefitNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: isLogin,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isLogin)
              FlatButton.icon(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    // Get.to(Intro());
                    // await networkcallService.getAllDropdownValue();
                  },
                  color: white,
                  icon: Icon(Icons.person),
                  label: Text('Sign In')),
            if (isLogin)
              SizedBox(
                width: 0.02.sw,
              ),
            Image.asset(
              appbarImg,
              height: 0.1.sh,
            ),
            Flexible(
              child: FlatButton.icon(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.to(() => CartPage());
                  },
                  color: white,
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: Text('0')),
            ),
          ],
        ),
        backgroundColor: appbarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: appbarColor,
                child: Row(
                  children: [
                    tabbarButton(() {
                      // Get.to(OnTapStore());
                    }, 'Quick Links :', white, 15.0),
                    tabbarButton(() {
                      Get.to(Deals());
                    }, 'Deals', Color(0xffDC7633), 15.0),
                    tabbarButton(() {
                      Get.to(Grocery());
                    }, 'Grocery', Color(0xff9457B0), 15.0),
                    tabbarButton(() {
                      Get.to(Food());
                    }, 'Food', Color(0xff2ECC71), 15.0),
                    tabbarButton(() {
                      Get.to(AutoParts());
                    }, 'Auto Parts', Color(0xffEC7063), 15.0),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 0.08.sh,
                      width: 1.sw,
                      child: button(() {
                        _showMyDialog();
                      }, 'Create New List or Registry', buttonColor, white)),
                  SizedBox(
                    height: 15,
                  ),
                  customText('Find List or Registry', black, 25.0),
                  SizedBox(
                    height: 15,
                  ),
                  searchField(
                      searchController, 'Search here your list or registry'),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 0.08.sh,
                      width: 1.sw,
                      child: button(() {}, 'Search', buttonColor, white)),
                  SizedBox(
                    height: 15,
                  ),
                  customText('List Information', black, 20.0),
                  Divider(),
                  SizedBox(
                    height: 15,
                  ),
                  registryListView(
                    5,
                    'Registry id : #578641',
                    'Name : name',
                    'Type : type',
                    'Owner : owner',
                    'Benefit : benefit',
                    'Event Date : Date',
                    'Shipping Address : address',
                    'View List Items',
                    () {
                      Get.to(ViewListItems());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            scrollable: true,
            title: Text('Create New List or Registry'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  customText('List/Registry Type :', black, 15.0),
                  dropDownWidget('List/Registry Type'),
                  SizedBox(
                    height: 15,
                  ),
                  customText('List/Registry Name :', black, 15.0),
                  searchField(listNameController, 'List/Registry Name'),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      customText('Make it private :', black, 15.0),
                      SizedBox(
                        width: 0.23.sw,
                      ),
                      Checkbox(
                        onChanged: (val) {
                          setState(() {
                            valueFirst = val!;
                          });
                        },
                        value: valueFirst,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  customText('Benefit name :', black, 15.0),
                  searchField(benefitNameController, 'List/Registry Name'),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customText('Event Date :', black, 15.0),
                      SizedBox(
                        width: 40,
                      ),
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  customText('Shipping Address :', black, 15.0),
                  searchField(addressController, 'List/Registry Name'),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Save and Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}