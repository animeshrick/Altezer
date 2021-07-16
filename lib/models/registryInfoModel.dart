class RegistryInfoModel {
  RegistryInfoModel({
    required this.message,
    required this.status,
    required this.registryInfo,
  });

  final String message;
  final String status;
  final List<RegistryInfo> registryInfo;

  factory RegistryInfoModel.fromJson(Map<String, dynamic> json) =>
      RegistryInfoModel(
        message: json["message"],
        status: json["status"],
        registryInfo: List<RegistryInfo>.from(
            json["RegistryInfo"].map((x) => RegistryInfo.fromJson(x))),
      );
}

class RegistryInfo {
  RegistryInfo({
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
  final String eventDate;
  final String shippingAddress;
  final String benefitName;
  final int isPrivate;
  final int totalItems;

  factory RegistryInfo.fromJson(Map<String, dynamic> json) => RegistryInfo(
        registryId: json["Registry_Id"] ?? 0,
        registryName: json["Registry_Name"] ?? '',
        registryTypeCode: json["Registry_Type_Code"] ?? 0,
        registryType: json["Registry_Type"] ?? '',
        yjUserId: json["YJ_User_Id"] ?? 0,
        eventDate: json["Event_Date"],
        shippingAddress: json["Shipping_Address"] ?? '',
        benefitName: json["Benefit_Name"] ?? '',
        isPrivate: json["Is_Private"] ?? 0,
        totalItems: json["Total_Items"] ?? 0,
      );
}
