import 'package:altezar/utils/const.dart';
import 'package:flutter/material.dart';

Widget dropDownWidget(String text) {
  return Card(
    color: Color(0xffEDEDED),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        value: text,
        elevation: 16,
        icon: CircleAvatar(
            radius: 15,
            backgroundColor: grey,
            child: Icon(
              Icons.arrow_drop_down,
              color: white,
              size: 30,
            )),
        isExpanded: true,
        items: <String>[
          text,
          'Dept2',
          'Dept2',
          'Dept2',
          'Dept2',
        ].map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
        onChanged: (value) {},
      ),
    ),
  );
}
