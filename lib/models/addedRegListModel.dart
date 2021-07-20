class AddRegListModel {
  AddRegListModel({
    required this.message,
    required this.status,
    required this.listOrRegistry,
  });

  final String message;
  final String status;
  final List<ListOrRegistry> listOrRegistry;

  factory AddRegListModel.fromJson(Map<String, dynamic> json) =>
      AddRegListModel(
        message: json["message"],
        status: json["status"],
        listOrRegistry: List<ListOrRegistry>.from(
            json["ListOrRegistry"].map((x) => ListOrRegistry.fromJson(x))),
      );
}

class ListOrRegistry {
  ListOrRegistry({
    required this.registryId,
    required this.registryName,
    required this.registryTypeCode,
    required this.registryType,
    required this.yjUserId,
    required this.eventDate,
    required this.shippingAddress,
    required this.benefitName,
    required this.isPrivate,
    required this.totalItems,
    required this.listitemdata,
  });

  final String registryId;
  final String registryName;
  final String registryTypeCode;
  final String registryType;
  final String yjUserId;
  final String eventDate;
  final String shippingAddress;
  final String benefitName;
  final String isPrivate;
  final String totalItems;
  final List<Listitemdata>? listitemdata;

  factory ListOrRegistry.fromJson(Map<String, dynamic> json) => ListOrRegistry(
        registryId: json["Registry_Id"] ?? '',
        registryName: json["Registry_Name"] ?? '',
        registryTypeCode: json["Registry_Type_Code"] ?? '',
        registryType: json["Registry_Type"] ?? '',
        yjUserId: json["YJ_User_Id"] ?? '',
        eventDate: json["Event_Date"] ?? '',
        shippingAddress: json["Shipping_Address"] ?? '',
        benefitName: json["Benefit_Name"] ?? '',
        isPrivate: json["Is_Private"] ?? '',
        totalItems: json["Total_Items"] ?? '',
        listitemdata: json["listitemdata"] == null
            ? null
            : List<Listitemdata>.from(
                json["listitemdata"].map((x) => Listitemdata.fromJson(x))),
      );
}

class Listitemdata {
  Listitemdata({
    required this.registryItemId,
    required this.registryId,
    required this.price,
    required this.productName,
    required this.productId,
    required this.productImageUrl,
    required this.qty,
    required this.isMadeToOrder,
  });

  final String registryItemId;
  final String registryId;
  final String price;
  final String productName;
  final String productId;
  final String productImageUrl;
  final String qty;
  final String isMadeToOrder;

  factory Listitemdata.fromJson(Map<String, dynamic> json) => Listitemdata(
        registryItemId: json["Registry_Item_ID"] ?? '',
        registryId: json["Registry_ID"] ?? '',
        price: json["price"] ?? '',
        productName: json["Product_Name"] ?? '',
        productId: json["Product_ID"] ?? '',
        productImageUrl: json["Product_Image_URL"] ?? '',
        qty: json["Qty"] ?? '',
        isMadeToOrder: json["is_Made_To_Order"] ?? '',
      );
}
