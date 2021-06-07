class GetAddressList {
  GetAddressList({
    required this.message,
    required this.status,
    required this.shippingAddressList,
  });

  final String message;
  final String status;
  final List<ShippingAddressList> shippingAddressList;

  factory GetAddressList.fromJson(Map<String, dynamic> json) => GetAddressList(
        message: json["message"],
        status: json["status"],
        shippingAddressList: List<ShippingAddressList>.from(
            json["ShippingAddressList"]
                .map((x) => ShippingAddressList.fromJson(x))),
      );
}

class ShippingAddressList {
  ShippingAddressList({
    required this.isDefault,
    required this.defaultYesNo,
    required this.userAddressId,
    required this.customerShippingAddress,
  });

  final bool isDefault;
  final String defaultYesNo;
  final int userAddressId;
  final String? customerShippingAddress;

  factory ShippingAddressList.fromJson(Map<String, dynamic> json) =>
      ShippingAddressList(
        isDefault: json["is_Default"],
        defaultYesNo: json["DefaultYesNo"],
        userAddressId: json["User_Address_Id"],
        customerShippingAddress: json["Customer_Shipping_Address"] == null
            ? ''
            : json["Customer_Shipping_Address"],
      );
}
