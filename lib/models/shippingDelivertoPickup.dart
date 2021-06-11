class DeliverToPickup {
  DeliverToPickup({
    required this.message,
    required this.status,
    required this.shippingOptionsPickup,
    required this.infoPickup,
  });

  final String message;
  final String status;
  final List<ShippingOptionDeliverToPickup>? shippingOptionsPickup;
  final String infoPickup;

  factory DeliverToPickup.fromJson(Map<String, dynamic> json) =>
      DeliverToPickup(
        message: json["message"],
        status: json["status"],
        shippingOptionsPickup: json["ShippingOptions"] != ''?(json["ShippingOptions"] as List)
                .map((x) => ShippingOptionDeliverToPickup.fromJson(x)).toList():null,
        infoPickup: json["Info"] == null ? '' :json["Info"],
      );
}

class ShippingOptionDeliverToPickup {
  ShippingOptionDeliverToPickup({
    required this.customerPickupLocationId,
    required this.serviceName,
    required this.customerPickUpLocation,
    required this.totalWeight,
    required this.deliveryCompanyId,
    required this.shippingCost,
  });

  final int customerPickupLocationId;
  final String serviceName;
  final String customerPickUpLocation;
  final double totalWeight;
  final int deliveryCompanyId;
  final double shippingCost;
  

  factory ShippingOptionDeliverToPickup.fromJson(Map<String, dynamic> json) =>
      ShippingOptionDeliverToPickup(
        customerPickupLocationId: json["Customer_Pickup_Location_Id"],
        serviceName: json["Service_Name"],
        customerPickUpLocation: json["CustomerPickUpLocation"],
        totalWeight: json["Total_Weight"],
        deliveryCompanyId: json["delivery_company_Id"],
        shippingCost: json["Shipping_Cost"],
      );
}
