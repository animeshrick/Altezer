class GetCartOrderDetails {
  GetCartOrderDetails({
    required this.message,
    required this.status,
    required this.cartProductList,
    required this.orderDetails,
  });

  final String message;
  final String status;
  final List<CartProductList> cartProductList;
  final List<MyOrderDetail> orderDetails;

  factory GetCartOrderDetails.fromJson(Map<String, dynamic> json) =>
      GetCartOrderDetails(
        message: json["message"],
        status: json["status"],
        cartProductList: List<CartProductList>.from(
            json["CartProductList"].map((x) => CartProductList.fromJson(x))),
        orderDetails: List<MyOrderDetail>.from(
            json["OrderDetails"].map((x) => MyOrderDetail.fromJson(x))),
      );
}

class CartProductList {
  CartProductList({
    required this.productCartItemId,
    required this.yjProductId,
    required this.productName,
    required this.productImageUrl,
    required this.price,
    required this.unitPrice,
    required this.productUrl,
    required this.sellerName,
    required this.sellerNameMobile,
    required this.inStockOrOutOfStock,
    required this.clientId,
    required this.quantity,
    required this.forSaleBy,
    required this.brand,
    required this.notes,
    required this.shippingInfo,
    required this.timeStamp,
  });

  final int productCartItemId;
  final int yjProductId;
  final String? productName;
  final String? productImageUrl;
  final String? price;
  final String? unitPrice;
  final String? productUrl;
  final String? sellerName;
  final String? sellerNameMobile;
  final String? inStockOrOutOfStock;
  final int? clientId;
  final int? quantity;
  final String? forSaleBy;
  final String? brand;
  final String? notes;
  final String? shippingInfo;
  final DateTime? timeStamp;

  factory CartProductList.fromJson(Map<String, dynamic> json) =>
      CartProductList(
        productCartItemId: json["Product_Cart_Item_Id"],
        yjProductId: json["YJProduct_ID"],
        productName: json["Product_Name"],
        productImageUrl: json["Product_Image_URL"],
        price: json["Price"],
        unitPrice: json["Unit_Price"],
        productUrl: json["Product_url"],
        sellerName: json["Seller_Name"],
        sellerNameMobile: json["Seller_Name_Mobile"],
        inStockOrOutOfStock: json["InStock_Or_OutOfStock"],
        clientId: json["client_id"],
        quantity: json["Quantity"],
        forSaleBy: json["for_sale_by"],
        brand: json["brand"],
        notes: json["notes"],
        shippingInfo: json["Shipping_Info"],
        timeStamp: DateTime.parse(json["time_stamp"]),
      );
}

class MyOrderDetail {
  MyOrderDetail({
    this.subtotal,
    this.usdSubTotal,
    this.exchangeRate,
    this.orderCartCount,
    this.salesTax,
    this.totalCouponDiscount,
    this.shippingCost,
    this.serviceFee,
    this.isContainsGroceryItems,
    this.totalCost,
    this.totalCostInUsd,
  });

  final String? subtotal;
  final String? usdSubTotal;
  final double? exchangeRate;
  final int? orderCartCount;
  final double? salesTax;
  final double? totalCouponDiscount;
  final double? shippingCost;
  final double? serviceFee;
  final int? isContainsGroceryItems;
  final String? totalCost;
  final double? totalCostInUsd;

  factory MyOrderDetail.fromJson(Map<String, dynamic> json) => MyOrderDetail(
        subtotal: json["subtotal"],
        usdSubTotal: json["USD_Sub_Total"],
        exchangeRate: json["Exchange_Rate"],
        orderCartCount: json["order_Cart_Count"],
        salesTax: json["sales_tax"],
        totalCouponDiscount: json["total_coupon_Discount"],
        shippingCost: json["Shipping_Cost"],
        serviceFee: json["service_fee"],
        isContainsGroceryItems: json["Is_Contains_Grocery_Items"],
        totalCost: json["Total_Cost"],
        totalCostInUsd: json["Total_Cost_In_USD"],
      );
}
