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
      style: TextStyle(fontSize: 18, color: textColor),
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
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.shopping_cart_outlined,
          color: white,
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
