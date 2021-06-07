class DeliverToHome {
    DeliverToHome({
        required this.message,
        required this.status,
        required this.shippingOptionsHome,
        required this.infoHome,
    });

    final String message;
    final String status;
    final List<ShippingOptionDeliverToHome> shippingOptionsHome;
    final String infoHome;

    factory DeliverToHome.fromJson(Map<String, dynamic> json) => DeliverToHome(
        message: json["message"],
        status: json["status"],
        shippingOptionsHome: List<ShippingOptionDeliverToHome>.from(json["ShippingOptions"].map((x) => ShippingOptionDeliverToHome.fromJson(x))),
        infoHome: json["Info"],
    );
}

class ShippingOptionDeliverToHome {
    ShippingOptionDeliverToHome({
        required this.deliveryCompanyServiceId,
        required this.baseRate,
        required this.rateOverBasePerPound,
        required this.serviceName,
        required this.totalWeight,
        required this.shippingCost,
        required this.leadTime,
    });

    final int deliveryCompanyServiceId;
    final double baseRate;
    final double rateOverBasePerPound;
    final String serviceName;
    final double totalWeight;
    final double shippingCost;
    final String leadTime;

    factory ShippingOptionDeliverToHome.fromJson(Map<String, dynamic> json) => ShippingOptionDeliverToHome(
        deliveryCompanyServiceId: json["Delivery_Company_Service_ID"],
        baseRate: json["base_rate"],
        rateOverBasePerPound: json["Rate_Over_Base_Per_Pound"],
        serviceName: json["service_name"],
        totalWeight: json["Total_Weight"],
        shippingCost: json["Shipping_Cost"],
        leadTime: json["Lead_Time"],
    );
}
