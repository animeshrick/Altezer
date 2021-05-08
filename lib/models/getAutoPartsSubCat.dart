// To parse this JSON data, do
//
//     final getAutoPartsSubCat = getAutoPartsSubCatFromJson(jsonString);

import 'dart:convert';

GetAutoPartsSubCat getAutoPartsSubCatFromJson(String str) =>
    GetAutoPartsSubCat.fromJson(json.decode(str));

class GetAutoPartsSubCat {
  GetAutoPartsSubCat({
    required this.message,
    required this.status,
    required this.autoPartsSubcategory,
  });

  final String message;
  final String status;
  final List<AutoPartsSubcategory> autoPartsSubcategory;

  factory GetAutoPartsSubCat.fromJson(Map<String, dynamic> json) =>
      GetAutoPartsSubCat(
        message: json["message"],
        status: json["status"],
        autoPartsSubcategory: List<AutoPartsSubcategory>.from(
            json["AutoPartsSubcategory"]
                .map((x) => AutoPartsSubcategory.fromJson(x))),
      );
}

class AutoPartsSubcategory {
  AutoPartsSubcategory({
    required this.productCategorySub2Id,
    required this.subname,
  });

  final int productCategorySub2Id;
  final String subname;

  factory AutoPartsSubcategory.fromJson(Map<String, dynamic> json) =>
      AutoPartsSubcategory(
        productCategorySub2Id: json["product_category_sub2_Id"],
        subname: json["Name"],
      );
}
