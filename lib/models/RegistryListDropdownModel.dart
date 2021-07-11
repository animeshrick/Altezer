class RegistryListDropdownModel {
    RegistryListDropdownModel({
        required this.message,
        required this.status,
        required this.registryListdata,
    });

    final String message;
    final String status;
    final List<RegistryListData> registryListdata;

    factory RegistryListDropdownModel.fromJson(Map<String, dynamic> json) => RegistryListDropdownModel(
        message: json["message"],
        status: json["status"],
        registryListdata: List<RegistryListData>.from(json["RegistryList"].map((x) => RegistryListData.fromJson(x))),
    );
}

class RegistryListData {
    RegistryListData({
        required this.registryId,
        required this.registryName,
    });

    final int registryId;
    final String registryName;

    factory RegistryListData.fromJson(Map<String, dynamic> json) => RegistryListData(
        registryId: json["Registry_Id"],
        registryName: json["Registry_Name"],
    );
}
