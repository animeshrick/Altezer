// To parse this JSON data, do

import 'dart:convert';

GetAutoPartsCat getAutoPartsCatFromJson(String str) =>
    GetAutoPartsCat.fromJson(json.decode(str));

class GetAutoPartsCat {
  GetAutoPartsCat({
    required this.message,
    required this.status,
    required this.autoPartsCategory,
  });

  final String message;
  final String status;
  final List<AutoPartsCategory> autoPartsCategory;

  factory GetAutoPartsCat.fromJson(Map<String, dynamic> json) =>
      GetAutoPartsCat(
        message: json["message"],
        status: json["status"],
        autoPartsCategory: List<AutoPartsCategory>.from(
            json["AutoPartsCategory"]
                .map((x) => AutoPartsCategory.fromJson(x))),
      );
}

class AutoPartsCategory {
  AutoPartsCategory({
    required this.productCategorySub1Id,
    required this.name,
  });

  final int productCategorySub1Id;
  final String name;

  factory AutoPartsCategory.fromJson(Map<String, dynamic> json) =>
      AutoPartsCategory(
        productCategorySub1Id: json["product_category_sub1_Id"],
        name: json["Name"],
      );
}
