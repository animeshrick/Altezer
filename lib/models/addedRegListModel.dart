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
  });

  final int registryId;
  final String registryName;
  final int registryTypeCode;
  final String registryType;
  final int yjUserId;
  final DateTime eventDate;
  final String shippingAddress;
  final String benefitName;
  final int isPrivate;
  final int totalItems;

  factory ListOrRegistry.fromJson(Map<String, dynamic> json) => ListOrRegistry(
        registryId: json["Registry_Id"],
        registryName: json["Registry_Name"],
        registryTypeCode: json["Registry_Type_Code"],
        registryType: json["Registry_Type"],
        yjUserId: json["YJ_User_Id"],
        eventDate: DateTime.parse(json["Event_Date"]),
        shippingAddress: json["Shipping_Address"],
        benefitName: json["Benefit_Name"],
        isPrivate: json["Is_Private"],
        totalItems: json["Total_Items"],
      );
}
