class OrderDetailsModel {
    OrderDetailsModel({
        required this.message,
        required this.status,
        required this.orderDetails,
    });

    final String message;
    final String status;
    final List<PlacedOrderDetail> orderDetails;

    factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
        message: json["message"],
        status: json["status"],
        orderDetails: List<PlacedOrderDetail>.from(json["OrderDetails"].map((x) => PlacedOrderDetail.fromJson(x))),
    );
}

class PlacedOrderDetail {
    PlacedOrderDetail({
        required this.productOrderLineItemId,
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
        required this.productTypeId,
        required this.orderStatusCode,
        required this.paymentMethodCode,
        required this.itemStatusCode,
        required this.itemOrderStatus,
        required this.orderStatusCodeForLineItem,
        required this.daysAfterDelivered,
        required this.isMadeToOrder,
    });

    final int productOrderLineItemId;
    final int yjProductId;
    final String productName;
    final String productImageUrl;
    final String price;
    final String unitPrice;
    final String productUrl;
    final String sellerName;
    final String sellerNameMobile;
    final String inStockOrOutOfStock;
    final int clientId;
    final int quantity;
    final String forSaleBy;
    final String brand;
    final String? notes;
    final int productTypeId;
    final int orderStatusCode;
    final int paymentMethodCode;
    final int itemStatusCode;
    final String itemOrderStatus;
    final int orderStatusCodeForLineItem;
    final int daysAfterDelivered;
    final int isMadeToOrder;

    factory PlacedOrderDetail.fromJson(Map<String, dynamic> json) => PlacedOrderDetail(
        productOrderLineItemId: json["Product_Order_Line_Item_Id"],
        yjProductId: json["YJProduct_ID"],
        productName: json["Product_Name"] ?? '',
        productImageUrl: json["Product_Image_URL"]??'',
        price: json["Price"],
        unitPrice: json["Unit_Price"] ?? '',
        productUrl: json["Product_url"]??'',
        sellerName: json["Seller_Name"]??'',
        sellerNameMobile: json["Seller_Name_Mobile"]??'',
        inStockOrOutOfStock: json["InStock_Or_OutOfStock"]??'',
        clientId: json["client_id"]?? 0,
        quantity: json["Quantity"]?? 0,
        forSaleBy: json["for_sale_by"]??'',
        brand: json["brand"]??'',
        notes: json["Notes"] == null ? null : json["Notes"],
        productTypeId: json["product_Type_Id"],
        orderStatusCode: json["Order_Status_Code"],
        paymentMethodCode: json["Payment_Method_Code"],
        itemStatusCode: json["Item_Status_Code"] ??0,
        itemOrderStatus: json["Item_Order_Status"] ==null ?'':json["Item_Order_Status"],
        orderStatusCodeForLineItem: json["Order_Status_Code_For_Line_Item"]??0,
        daysAfterDelivered: json["Days_After_Delivered"]??0,
        isMadeToOrder: json["is_Made_To_Order"]??0,
    );

}
