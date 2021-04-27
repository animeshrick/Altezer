import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*-------------------------text-------------------------*/
TextStyle customizeTextStyle(fontWeight, fontSize, fontColor) => TextStyle(
    fontWeight: fontWeight,
    wordSpacing: 3,
    color: fontColor,
    fontSize: fontSize);

Widget customText(String text, Color color, double size, {fontWeight}) {
  return Text(text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight));
}

/*-------------------------images-------------------------*/
final logoImage = 'assets/logo.png';
final altezerLogoImage = 'assets/AltezerLogo.png';
final appbarImg = 'assets/appbarImg.png';
final slider1 = 'assets/1.jpg';
final slider2 = 'assets/2.jpg';
final banner1 = 'assets/banner1.png';
final banner2 = 'assets/banner2.png';
final banner3 = 'assets/banner3.png';
final banner4 = 'assets/banner4.png';
final banner5 = 'assets/banner5.png';
final banner6 = 'assets/banner6.jpg';
final banner7 = 'assets/banner7.jpg';
final banner8 = 'assets/banner8.png';
final retailSpl = 'assets/retailSpl.png';
final foodDetails = 'assets/foodDetails.png';
final groceryImg = 'assets/grocery.png';
final oilGrocery = 'assets/oilGrocery.jpg';
final autoParts = 'assets/autoParts.png';
final parts = 'assets/parts.jpg';
final foodImg = 'assets/food.jpg';
final card1 = 'assets/card1.png';
final card2 = 'assets/card2.png';
final card3 = 'assets/card3.png';
final strip = 'assets/strip.png';
final checkout = 'assets/checkout.gif';

/*-------------------------Fluttertoast-------------------------*/

showToast(msg, color) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: white,
    fontSize: 16.0);

/*-------------------------colors-------------------------*/

final Color transperent = Colors.transparent;
final Color white = Colors.white;
final Color black = Colors.black;
final Color grey = Colors.grey;
final Color red = Colors.red;
final Color blue = Colors.blue;
final Color buttonColor = Color(0xff337AB7);
final Color searchBtnColor = Color(0xffEC971F);
final Color green = Color.fromRGBO(92, 184, 98, 1);
final Color appbarColor = new Color(0xff2C3E50);
final Color priceTextColor = Color(0xffFF0000);
final Color greenColor = Color(0xff5CB85C);

/*-------------------------apis-------------------------*/

final String getallDropdownlist = 'https://demo20.gowebbi.us/ApiHandler/GetCountryList.ashx'; // get
final String stateList = 'https://demo20.gowebbi.us/ApiHandler/GetStateList.ashx'; //post -- countryId



/* -------------------------------- text --------------------------- */
final String internetError = "Please check your Internet! 😢";

final String success = "success";
final String failed = "failed";

showProgress(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CupertinoActivityIndicator(
            radius: 25,
          ),
        );
      },
      barrierDismissible: false);
}

void hideProgress(BuildContext context) {
  Navigator.pop(context);
}
