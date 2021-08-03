import 'dart:convert';

StoreCatList storeCatListFromJson(String str) =>
    StoreCatList.fromJson(json.decode(str));

class StoreCatList {
  StoreCatList({
    required this.message,
    required this.status,
    required this.storeCatList,
  });

  final String message;
  final String status;
  final List<StoreCatListElement> storeCatList;

  factory StoreCatList.fromJson(Map<String, dynamic> json) => StoreCatList(
        message: json["message"],
        status: json["status"],
        storeCatList: List<StoreCatListElement>.from(
            json["storeCatList"].map((x) => StoreCatListElement.fromJson(x))) ,
      );
}

class StoreCatListElement {
  StoreCatListElement({
    required this.clientId,
    required this.productCategoryId,
    required this.name,
  });

  final int clientId;
  final int productCategoryId;
  final String name;

  factory StoreCatListElement.fromJson(Map<String, dynamic> json) =>
      StoreCatListElement(
        clientId: json["Client_Id"],
        productCategoryId: json["Product_category_id"],
        name: json["name"],
      );
}
