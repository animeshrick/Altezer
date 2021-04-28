import 'package:altezar/utils/const.dart';
import 'package:altezar/view/widgets/button.dart';
import 'package:altezar/view/widgets/detailsPageAppBar.dart';
import 'package:altezar/view/widgets/dropDown.dart';
import 'package:altezar/view/widgets/listView.dart';
import 'package:altezar/view/widgets/searchField.dart';
import 'package:flutter/material.dart';

class AutoPartsDetails extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  final String? action;

  AutoPartsDetails({Key? key, this.action}) : super(key: key);
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
              Image.asset(autoParts),
              dropDownWidget('Parts Category'),
              dropDownWidget('Parts sub category'),
              dropDownWidget('Sort by'),
              SizedBox(
                height: 15,
              ),
              searchField(
                  searchController, 'Search Product Name, Brand etc ...'),
              SizedBox(
                  width: double.infinity,
                  child: button(() {}, 'Search', Color(0xffF0AD4E), white)),
              listView(6, () {}, parts, red, 'Vagetable Oil',
                  'JMD\$252.05 | USD\$1.72  | ', 'Limited + Free Delivary'),
            ],
          ),
        ),
      ),
    );
  }
}
