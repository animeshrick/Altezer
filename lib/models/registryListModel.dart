class RegistryListModel {
    RegistryListModel({
        required this.message,
        required this.status,
        required this.registryList,
    });

    final String message;
    final String status;
    final List<RegistryList?> registryList;

    factory RegistryListModel.fromJson(Map<String, dynamic> json) => RegistryListModel(
        message: json["message"],
        status: json["status"],
        registryList: List<RegistryList>.from(json["RegistryList"].map((x) => RegistryList.fromJson(x))),
    );
}

class RegistryList {
    RegistryList({
        required this.registryId,
        required this.registryName,
        required this.registryTypeCode,
        required this.registryType,
        required this.yjUserId,
        required this.eventDate,
        required this.shippingAddress,
        required this.benefitName,
        required this.isPrivate,
        required this.fullname,
    });

    final int registryId;
    final String? registryName;
    final int registryTypeCode;
    final String? registryType;
    final int yjUserId;
    final String? eventDate;
    final String? shippingAddress;
    final String? benefitName;
    final int isPrivate;
    final String? fullname;

    factory RegistryList.fromJson(Map<String, dynamic> json) => RegistryList(
        registryId: json["Registry_Id"],
        registryName: json["Registry_Name"],
        registryTypeCode: json["Registry_Type_Code"],
        registryType: json["Registry_Type"],
        yjUserId: json["YJ_User_Id"],
        eventDate: json["Event_Date"],
        shippingAddress: json["Shipping_Address"],
        benefitName: json["Benefit_Name"],
        isPrivate: json["Is_Private"],
        fullname: json["Fullname"],
    );
}
