import 'package:flutter/material.dart';

Widget searchField(TextEditingController controller, String hintText) {
  return TextFormField(
    controller: controller,
    autofocus: false,
    obscureText: true,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(),
    ),
  );
}
