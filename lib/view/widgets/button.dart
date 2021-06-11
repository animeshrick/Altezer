import 'package:altezar/utils/const.dart';
import 'package:flutter/material.dart';

Widget button(
  Function() onPressed,
  String text,
  Color btnColor,
  Color textColor,
) {
  return RaisedButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(fontSize: 15, color: textColor),
    ),
    color: btnColor,
  );
}

Widget cartButton(
  Function() onPressed,
  String text,
  Color btnColor,
  Color textColor,
) {
  return RaisedButton(
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 15, color: textColor),
        ),
        Icon(
          Icons.shopping_cart_outlined,
          color: white,
          size: 15,
        ),
      ],
    ),
    color: btnColor,
  );
}

Widget tabbarButton(
    Function() onPressed, String text, Color textColor, double textSize) {
  return FlatButton(
    onPressed: onPressed,
    color: appbarColor,
    child: customText(text, textColor, textSize),
  );
}
