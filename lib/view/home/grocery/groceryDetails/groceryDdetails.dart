import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';

class GroceryDetails extends StatefulWidget {
  @override
  _GroceryDetailsState createState() => _GroceryDetailsState();
}

class _GroceryDetailsState extends State<GroceryDetails> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), child: detailsPageAppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(banner5),
              dropDownWidget('Shopping Category'),
              dropDownWidget('All sub category'),
              dropDownWidget('Sort by'),
              SizedBox(
                height: 15,
              ),
              searchField(
                  searchController, 'Search Product Name, Brand etc ...'),
              SizedBox(
                  width: double.infinity,
                  child: button(() {}, 'Search', Color(0xffF0AD4E))),
              SizedBox(
                height: 20,
              ),
              groceryListView(
                  5,
                  () {},
                  groceryImg,
                  'Envy Tomato',
                  'Ketchup',
                  'JMD \$250 | USD\$25.02',
                  '/bottle in Stock',
                  '+ FREE DELIVARY')
            ],
          ),
        ),
      ),
    );
  }
}
