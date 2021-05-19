import 'dart:convert';

CartBox cartBoxFromJson(String str) => CartBox.fromJson(json.decode(str));

class CartBox {
  CartBox({
    required this.message,
    required this.status,
    required this.cartBoxData,
  });

  final String message;
  final String status;
  final List<CartBoxData> cartBoxData;

  factory CartBox.fromJson(Map<String, dynamic> json) => CartBox(
      message: json["message"],
      status: json["status"],
      cartBoxData: List<CartBoxData>.from(
          json["storeCatList"].map((x) => CartBoxData.fromJson(x))));
}

class CartBoxData {
  final String subtotal, usdSubTotal, totalCost;

  final double exchangeRate,
      salesTax,
      totalDisscount,
      shippingCost,
      serviceFee,
      totalCostUSD;

  final int orderCartCount, isContaintsGrocery;

  CartBoxData(
      {required this.subtotal,
      required this.usdSubTotal,
      required this.exchangeRate,
      required this.orderCartCount,
      required this.salesTax,
      required this.totalDisscount,
      required this.shippingCost,
      required this.serviceFee,
      required this.isContaintsGrocery,
      required this.totalCost,
      required this.totalCostUSD});

  factory CartBoxData.fromJson(Map<String, dynamic> json) {
    return CartBoxData(
        subtotal: json['subtotal'] ?? '0.0',
        usdSubTotal: json['USD_Sub_Total'] ?? '0.0',
        exchangeRate: json['Exchange_Rate'],
        orderCartCount: json['order_Cart_Count'],
        salesTax: json['sales_tax'],
        totalDisscount: json['total_coupon_Discount'],
        shippingCost: json['Shipping_Cost'],
        serviceFee: json['service_fee'] ?? 0.0,
        isContaintsGrocery: json['Is_Contains_Grocery_Items'],
        totalCost: json['Total_Cost'] ?? '0.0',
        totalCostUSD: json['Total_Cost_In_USD'] ?? 0.0);
  }
}
