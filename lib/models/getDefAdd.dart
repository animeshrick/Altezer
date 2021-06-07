class GetDefaultAddress {
    GetDefaultAddress({
        required this.message,
        required this.status,
        required this.deaultAddress,
    });

    final String message;
    final String status;
    final List<DeaultAddress> deaultAddress;

    factory GetDefaultAddress.fromJson(Map<String, dynamic> json) => GetDefaultAddress(
        message: json["message"],
        status: json["status"],
        deaultAddress: List<DeaultAddress>.from(json["DeaultAddress"].map((x) => DeaultAddress.fromJson(x))),
    );
}

class DeaultAddress {
    DeaultAddress({
        required this.isDefault,
        required this.defaultYesNo,
        required this.userAddressId,
        required this.customerShippingAddress,
    });

    final bool isDefault;
    final String defaultYesNo;
    final int userAddressId;
    final String customerShippingAddress;

    factory DeaultAddress.fromJson(Map<String, dynamic> json) => DeaultAddress(
        isDefault: json["is_Default"],
        defaultYesNo: json["DefaultYesNo"],
        userAddressId: json["User_Address_Id"],
        customerShippingAddress: json["Customer_Shipping_Address"],
    );
}
