import 'package:altezar/view/auths/intro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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

Widget customInkWellText(
    Function() onTap, String text, Color color, double size,
    {fontWeight}) {
  return InkWell(
    onTap: onTap,
    child: Text(text,
        style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight)),
  );
}

Widget customUnderlineText(String text, Color color, double size,
    {fontWeight}) {
  return Text(text,
      style: TextStyle(
        decoration: TextDecoration.underline,
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ));
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

final imageNotFound =
    'https://demo20.gowebbi.us//CompanyLogos/altezer_grocery_logo.png';
/*-------------------------Fluttertoast-------------------------*/

showToast(msg, color) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
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
final String _baseUrl = 'https://demo20.gowebbi.us/ApiHandler';
final String imgBaseUrl = 'https://demo20.gowebbi.us/';
//
final String getallDropdownlist = '$_baseUrl/GetCountryList.ashx';
final String stateList = '$_baseUrl/GetStateList.ashx';
final String register = '$_baseUrl/createUser.ashx';
final String login = '$_baseUrl/login.ashx';
final String forgotEmail = '$_baseUrl/ForgotEmail.ashx';
final String forgotPassword = '$_baseUrl/ForgotPassword.ashx';
final String getCategories = '$_baseUrl/getCategory.ashx';
final String getSubCategories = '$_baseUrl/getSubCategory.ashx';
final String getSortByData = '$_baseUrl/GetSortByData.ashx';
final String getProducts = '$_baseUrl/GetProduct.ashx';
final String getGroceryStoreList = '$_baseUrl/GetGroceryStoreList.ashx';
final String getGroceryStateList = '$_baseUrl/GetGroceryStateList.ashx';
final String getLatestDeals = '$_baseUrl/GetLatestDeals.ashx';
final String getStoreList = '$_baseUrl/GetStoresList.ashx';
final String getDeals = '$_baseUrl/GetDeals.ashx';
final String getResType = '$_baseUrl/GetRestaurantTypeList.ashx';
final String getResList = '$_baseUrl/GetRestaurantsList.ashx';
final String getAutoCat = '$_baseUrl/GetAutoPartsCategory.ashx';
final String getAutoSubCat = '$_baseUrl/GetAutoPartsSubcategory.ashx';
final String getAutoPartListApi = '$_baseUrl/GetAutoPartsList.ashx';
final String getProductDetails = '$_baseUrl/GetProductDetails.ashx';
final String getDetailsOfPages = '$_baseUrl/GetProduct.ashx';
final String addtoCart = '$_baseUrl/AddToCart.ashx';
final String getCategoryForStore = '$_baseUrl/GetCategoryForStore.ashx';
final String getCartBox = '$_baseUrl/GetCartBoxa.ashx';
final String getDeliveryOption = '$_baseUrl/GetDeliveryOption.ashx';
final String getCartOrderDetails = '$_baseUrl/GetcartOrderDetails.ashx';
final String getUserInfo = '$_baseUrl/GetUserInfo.ashx';
final String getQuestion = '$_baseUrl/GetQuestion.ashx';
final String updateUserInfo = '$_baseUrl/UpdateUserInfo.ashx';
final String updateUserPassword = '$_baseUrl/UpdateUserPassword.ashx';
final String getBanks = '$_baseUrl/GetBankList.ashx';
final String getBankBranch = '$_baseUrl/GetBankbyBranch.ashx';
final String addBankDetails = '$_baseUrl/AddUserBankAccount.ashx';
final String editBankDetails = '$_baseUrl/GetAccountbankById.ashx';
final String getbankList = '$_baseUrl/GetUserBankAccountlist.ashx';
final String shippingCountryState =
    '$_baseUrl/GetShippingCountryandstatelist.ashx';
final String addShippingAddress = '$_baseUrl/SaveUserShippingAddress.ashx';
final String bannerImageAPI = '$_baseUrl/GetStoreBannerById.ashx';
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

gotoLoginPage() {
  return Get.to(() => Intro(
        isChecked: false,
      ));
}
