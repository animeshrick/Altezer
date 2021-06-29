class OrdDetailsModel {
  OrdDetailsModel({
    required this.message,
    required this.status,
    required this.orderDetails,
    required this.orderInfo,
  });

  final String message;
  final String status;
  final List<OrderDetail> orderDetails;
  final List<OrderInfo> orderInfo;

  factory OrdDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrdDetailsModel(
        message: json["message"],
        status: json["status"],
        orderDetails: List<OrderDetail>.from(
            json["OrderDetails"].map((x) => OrderDetail.fromJson(x))),
        orderInfo: List<OrderInfo>.from(
            json["OrderInfo"].map((x) => OrderInfo.fromJson(x))),
      );
}

class OrderDetail {
  OrderDetail({
    required this.productOrderId,
    required this.orderStatusCode,
    required this.yjUserId,
    required this.notes,
    required this.ipAddress,
    required this.macAddress,
    required this.orderTaxTotal,
    required this.timeStamp,
    required this.orderStatus,
    required this.estimatedTotal,
    required this.shippingTotal,
    required this.serviceFee,
    required this.orderFinalTotal,
    required this.subTotal,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userName,
    required this.deliveryOption,
    required this.pickUpAddress,
    required this.pickupLocationAddress1,
    required this.pickupLocationAddress2,
    required this.pickupLocationArea,
    required this.pickupLocationCity,
    required this.pickupLocationZipOrPostalCode,
    required this.pickupLocationStateOrParish,
    required this.pickupLocationCountry,
    required this.customerShippingAddress,
    required this.companyOrOrgName,
    required this.shippingAddress1,
    required this.shippingAddress2,
    required this.shippingArea,
    required this.shippingCity,
    required this.shippingZipPostalCode,
    required this.userAddressId,
    required this.deliveryOptionCode,
    required this.paymentMethodCode,
    required this.orderStatusCode1,
    required this.shippingStateOrParish,
    required this.shippingCountry,
    required this.deliveyInfo,
    required this.pmtMethod,
    required this.isOrderShiped,
    required this.totalCouponDiscount,
  });

  final int productOrderId;
  final int orderStatusCode;
  final int yjUserId;
  final String notes;
  final String ipAddress;
  final String macAddress;
  final double orderTaxTotal;
  final String timeStamp;
  final String orderStatus;
  final double estimatedTotal;
  final double shippingTotal;
  final double serviceFee;
  final double orderFinalTotal;
  final double subTotal;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userName;
  final String deliveryOption;
  final String pickUpAddress;
  final String pickupLocationAddress1;
  final String pickupLocationAddress2;
  final String pickupLocationArea;
  final String pickupLocationCity;
  final String pickupLocationZipOrPostalCode;
  final String pickupLocationStateOrParish;
  final String pickupLocationCountry;
  final String customerShippingAddress;
  final String companyOrOrgName;
  final String shippingAddress1;
  final String shippingAddress2;
  final String shippingArea;
  final String shippingCity;
  final String shippingZipPostalCode;
  final int userAddressId;
  final int deliveryOptionCode;
  final int paymentMethodCode;
  final int orderStatusCode1;
  final String shippingStateOrParish;
  final String shippingCountry;
  final String deliveyInfo;
  final String pmtMethod;
  final int isOrderShiped;
  final double totalCouponDiscount;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        productOrderId: json["Product_Order_Id"],
        orderStatusCode: json["order_status_code"],
        yjUserId: json["YJ_User_Id"],
        notes: json["Notes"] ?? '',
        ipAddress: json["IP_Address"],
        macAddress: json["Mac_Address"],
        orderTaxTotal: json["Order_Tax_Total"],
        timeStamp: json["Time_Stamp"],
        orderStatus: json["Order_Status"],
        estimatedTotal: json["Estimated_Total"],
        shippingTotal: json["Shipping_Total"],
        serviceFee: json["Service_Fee"].toDouble(),
        orderFinalTotal: json["Order_Final_Total"].toDouble(),
        subTotal: json["Sub_Total"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        userName: json["user_name"],
        deliveryOption: json["Delivery_Option"],
        pickUpAddress: json["PickUp_Address"] ?? '',
        pickupLocationAddress1: json["Pickup_Location_Address1"] ?? '',
        pickupLocationAddress2: json["Pickup_Location_Address2"] ?? '',
        pickupLocationArea: json["Pickup_Location_Area"] ?? '',
        pickupLocationCity: json["Pickup_Location_City"] ?? '',
        pickupLocationZipOrPostalCode:
            json["Pickup_Location_Zip_Or_Postal_Code"] ?? '',
        pickupLocationStateOrParish:
            json["Pickup_Location_State_Or_Parish"] ?? '',
        pickupLocationCountry: json["Pickup_Location_Country"] ?? '',
        customerShippingAddress: json["Customer_Shipping_Address"] ?? '',
        companyOrOrgName: json["Company_Or_Org_Name"] ?? '',
        shippingAddress1: json["Shipping_Address1"] ?? '',
        shippingAddress2: json["Shipping_Address2"] ?? '',
        shippingArea: json["Shipping_Area"] ?? '',
        shippingCity: json["Shipping_City"] ?? '',
        shippingZipPostalCode: json["Shipping_Zip_Postal_Code"] ?? '',
        userAddressId: json["user_address_id"],
        deliveryOptionCode: json["Delivery_Option_Code"],
        paymentMethodCode: json["Payment_Method_Code"],
        orderStatusCode1: json["order_status_code1"],
        shippingStateOrParish: json["Shipping_State_Or_Parish"] ?? '',
        shippingCountry: json["Shipping_Country"] ?? '',
        deliveyInfo: json["DeliveyInfo"],
        pmtMethod: json["PMT_Method"],
        isOrderShiped: json["is_Order_Shiped"],
        totalCouponDiscount: json["Total_Coupon_Discount"],
      );
}

class OrderInfo {
  OrderInfo({
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
  final String notes;
  final int productTypeId;
  final int orderStatusCode;
  final int paymentMethodCode;
  final int itemStatusCode;
  final String itemOrderStatus;
  final int orderStatusCodeForLineItem;
  final int daysAfterDelivered;
  final int isMadeToOrder;

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        productOrderLineItemId: json["Product_Order_Line_Item_Id"],
        yjProductId: json["YJProduct_ID"],
        productName: json["Product_Name"],
        productImageUrl: json["Product_Image_URL"],
        price: json["Price"] == null ? '' : json["Price"],
        unitPrice: json["Unit_Price"],
        productUrl: json["Product_url"],
        sellerName: json["Seller_Name"],
        sellerNameMobile: json["Seller_Name_Mobile"],
        inStockOrOutOfStock: json["InStock_Or_OutOfStock"],
        clientId: json["client_id"],
        quantity: json["Quantity"] == null ? 0 : json["Quantity"],
        forSaleBy: json["for_sale_by"],
        brand: json["brand"],
        notes: json["Notes"]??'',
        productTypeId: json["product_Type_Id"],
        orderStatusCode: json["Order_Status_Code"],
        paymentMethodCode: json["Payment_Method_Code"],
        itemStatusCode: json["Item_Status_Code"],
        itemOrderStatus: json["Item_Order_Status"],
        orderStatusCodeForLineItem: json["Order_Status_Code_For_Line_Item"],
        daysAfterDelivered: json["Days_After_Delivered"],
        isMadeToOrder: json["is_Made_To_Order"],
      );
}
