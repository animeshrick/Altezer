import 'package:altezar/models/getCartOrderDetailsModel.dart';

class CartUpdateModel {
  CartUpdateModel({
    required this.message,
    required this.status,
    required this.updatedcartData,
  });

  final String message;
  final String status;
  final List<MyOrderDetail> updatedcartData;

  factory CartUpdateModel.fromJson(Map<String, dynamic> json) =>
      CartUpdateModel(
        message: json["message"],
        status: json["status"],
        updatedcartData: List<MyOrderDetail>.from(
            json["CartData"].map((x) => MyOrderDetail.fromJson(x))),
      );
}

// class UpdatedCartData {
//   UpdatedCartData({
//     required this.subtotal,
//     required this.usdSubTotal,
//     required this.exchangeRate,
//     required this.orderCartCount,
//     required this.salesTax,
//     required this.totalCouponDiscount,
//     required this.shippingCost,
//     required this.serviceFee,
//     required this.isContainsGroceryItems,
//     required this.totalCost,
//     required this.totalCostInUsd,
//   });

//   final String subtotal;
//   final String usdSubTotal;
//   final double exchangeRate;
//   final int orderCartCount;
//   final double salesTax;
//   final double totalCouponDiscount;
//   final double shippingCost;
//   final double serviceFee;
//   final int isContainsGroceryItems;
//   final String totalCost;
//   final double totalCostInUsd;

//   factory UpdatedCartData.fromJson(Map<String, dynamic> json) =>
//       UpdatedCartData(
//         subtotal: json["subtotal"] ?? '',
//         usdSubTotal: json["USD_Sub_Total"] ?? '',
//         exchangeRate: json["Exchange_Rate"] ?? 0.0,
//         orderCartCount: json["order_Cart_Count"] ?? 0,
//         salesTax: json["sales_tax"] ?? 0.0,
//         totalCouponDiscount: json["total_coupon_Discount"] ?? 0.0,
//         shippingCost: json["Shipping_Cost"] ?? 0.0,
//         serviceFee: json["service_fee"] ?? 0.0,
//         isContainsGroceryItems: json["Is_Contains_Grocery_Items"] ?? 0,
//         totalCost: json["Total_Cost"] ?? "",
//         totalCostInUsd: json["Total_Cost_In_USD"] ?? 0.0,
//       );
// }
