class InvoiceModel {
    InvoiceModel({
        required this.message,
        required this.status,
        required this.orderInvoiceInfo,
        required this.orderInvoiceLineItem,
    });

    final String message;
    final String status;
    final List<OrderInvoiceInfo> orderInvoiceInfo;
    final List<OrderInvoiceLineItem> orderInvoiceLineItem;

    factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        message: json["message"],
        status: json["status"],
        orderInvoiceInfo: List<OrderInvoiceInfo>.from(json["OrderInvoiceInfo"].map((x) => OrderInvoiceInfo.fromJson(x))),
        orderInvoiceLineItem: List<OrderInvoiceLineItem>.from(json["OrderInvoiceLineItem"].map((x) => OrderInvoiceLineItem.fromJson(x))),
    );
}

class OrderInvoiceInfo {
    OrderInvoiceInfo({
        required this.paymentMethod,
        required this.invoiceId,
        required this.invoiceDate,
        required this.orderDate,
        required this.total,
        required this.tax,
        required this.invoiceTotal,
        required this.shippingAddress,
        required this.invoiceSubTotal,
        required this.shippingAndHandlingCost,
        required this.invoiceTotal1,
        required this.orderNumber,
        required this.serviceFee,
        required this.couponDiscount,
    });

    final String paymentMethod;
    final int invoiceId;
    final String invoiceDate;
    final String orderDate;
    final double total;
    final double tax;
    final double invoiceTotal;
    final String shippingAddress;
    final double invoiceSubTotal;
    final double shippingAndHandlingCost;
    final double invoiceTotal1;
    final int orderNumber;
    final double serviceFee;
    final double couponDiscount;

    factory OrderInvoiceInfo.fromJson(Map<String, dynamic> json) => OrderInvoiceInfo(
        paymentMethod: json["Payment_Method"],
        invoiceId: json["Invoice_Id"],
        invoiceDate: json["InvoiceDate"],
        orderDate: json["OrderDate"],
        total: json["Total"],
        tax: json["Tax"],
        invoiceTotal: json["Invoice_Total"],
        shippingAddress: json["Shipping_Address"],
        invoiceSubTotal: json["Invoice_SubTotal"],
        shippingAndHandlingCost: json["Shipping_And_Handling_Cost"],
        invoiceTotal1: json["Invoice_Total1"],
        orderNumber: json["Order_Number"],
        serviceFee: json["Service_Fee"],
        couponDiscount: json["Coupon_Discount"],
    );
}

class OrderInvoiceLineItem {
    OrderInvoiceLineItem({
        required this.quantity,
        required this.productName,
        required this.productPurchasePrice,
        required this.clientId,
        required this.individualSellerUserId,
        required this.productOrderId,
        required this.isItemBagged,
        required this.orderedQuantity,
    });

    final int quantity;
    final String productName;
    final double productPurchasePrice;
    final int clientId;
    final int individualSellerUserId;
    final int productOrderId;
    final int isItemBagged;
    final int orderedQuantity;

    factory OrderInvoiceLineItem.fromJson(Map<String, dynamic> json) => OrderInvoiceLineItem(
        quantity: json["Quantity"],
        productName: json["product_name"],
        productPurchasePrice: json["Product_Purchase_Price"],
        clientId: json["Client_Id"],
        individualSellerUserId: json["individual_Seller_User_Id"],
        productOrderId: json["Product_Order_Id"],
        isItemBagged: json["is_Item_bagged"],
        orderedQuantity: json["ordered_quantity"],
    );
}
