import 'package:altezar/utils/const.dart';
import 'package:flutter/material.dart';

Widget searchField(
  TextEditingController controller,
  String hintText, {
  TextInputType? keyboardType,
}) {
  return TextFormField(
    keyboardType: keyboardType,
    controller: controller,
    autofocus: false,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(),
    ),
  );
}

Widget readonlysearchField(
  TextEditingController controller,
  String hintText,
  bool readOnly, {
  TextInputType? keyboardType,
}) {
  return TextFormField(
    readOnly: readOnly,
    keyboardType: keyboardType,
    controller: controller,
    autofocus: false,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(),
    ),
  );
}

Widget textField(TextEditingController controller, String hintText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customText(hintText, black, 15),
      SizedBox(
        height: 5,
      ),
      TextFormField(
        controller: controller,
        autofocus: false,
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
      SizedBox(
        height: 5,
      ),
    ],
  );
}
