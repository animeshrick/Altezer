import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';

class FoodDetails extends StatefulWidget {
  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
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
              Image.asset(banner7),
              dropDownWidget('Foods Category'),
              dropDownWidget('Foods sub category'),
              dropDownWidget('Sort by'),
              SizedBox(
                height: 15,
              ),
              searchField(
                  searchController, 'Search Product Name, Brand etc ...'),
              SizedBox(
                  width: double.infinity,
                  child: button(() {}, 'Search', Color(0xffF0AD4E))),
              listView(6, () {}, foodDetails, red, 'Liver or Kidney Large',
                  'JMD\$252.05 | USD\$1.72  | ', 'In stock + Free Delivary'),
            ],
          ),
        ),
      ),
    );
  }
}
