class ConfirmedPaymentModel {
    ConfirmedPaymentModel({
         this.message,
         this.status,
         this.conforderInfo,
    });

    final String? message;
    final String? status;
    final List<ConfOrderInfo>? conforderInfo;

    factory ConfirmedPaymentModel.fromJson(Map<String, dynamic> json) => ConfirmedPaymentModel(
        message: json["message"],
        status: json["status"],
        conforderInfo: List<ConfOrderInfo>.from(json["OrderInfo"].map((x) => ConfOrderInfo.fromJson(x))),
    );
}

class ConfOrderInfo {
    ConfOrderInfo({
        required this.productOrderId,
        required this.yjUserId,
        required this.notes,
        required this.ipAddress,
        required this.macAddress,
        required this.orderFinalTotal,
        required this.timeStamp,
        required this.orderStatus,
        required this.estimatedTotal,
        required this.shippingTotal,
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
        required this.shippingStateOrParish,
        required this.shippingCountry,
        required this.deliveyInfo,
        required this.pmtMethod,
        required this.serviceFee,
        required this.totalCouponDiscount,
        required this.orderTaxTotal,
    });

    final int productOrderId;
    final int yjUserId;
    final dynamic notes;
    final String ipAddress;
    final String macAddress;
    final dynamic orderFinalTotal;
    final String timeStamp;
    final String orderStatus;
    final dynamic estimatedTotal;
    final dynamic shippingTotal;
    final dynamic subTotal;
    final String firstName;
    final String lastName;
    final String phoneNumber;
    final String userName;
    final dynamic deliveryOption;
    final dynamic pickUpAddress;
    final dynamic pickupLocationAddress1;
    final dynamic pickupLocationAddress2;
    final dynamic pickupLocationArea;
    final dynamic pickupLocationCity;
    final dynamic pickupLocationZipOrPostalCode;
    final dynamic pickupLocationStateOrParish;
    final dynamic pickupLocationCountry;
    final dynamic customerShippingAddress;
    final dynamic companyOrOrgName;
    final dynamic shippingAddress1;
    final dynamic shippingAddress2;
    final dynamic shippingArea;
    final dynamic shippingCity;
    final dynamic shippingZipPostalCode;
    final dynamic shippingStateOrParish;
    final dynamic shippingCountry;
    final String deliveyInfo;
    final String pmtMethod;
    final double serviceFee;
    final double totalCouponDiscount;
    final double orderTaxTotal;

    factory ConfOrderInfo.fromJson(Map<String, dynamic> json) => ConfOrderInfo(
        productOrderId: json["Product_Order_Id"],
        yjUserId: json["YJ_User_Id"],
        notes: json["Notes"],
        ipAddress: json["IP_Address"],
        macAddress: json["Mac_Address"],
        orderFinalTotal: json["Order_Final_Total"],
        timeStamp: json["Time_Stamp"],
        orderStatus: json["Order_Status"],
        estimatedTotal: json["Estimated_Total"],
        shippingTotal: json["Shipping_Total"],
        subTotal: json["Sub_Total"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        userName: json["user_name"],
        deliveryOption: json["Delivery_Option"],
        pickUpAddress: json["PickUp_Address"],
        pickupLocationAddress1: json["Pickup_Location_Address1"],
        pickupLocationAddress2: json["Pickup_Location_Address2"],
        pickupLocationArea: json["Pickup_Location_Area"],
        pickupLocationCity: json["Pickup_Location_City"],
        pickupLocationZipOrPostalCode: json["Pickup_Location_Zip_Or_Postal_Code"],
        pickupLocationStateOrParish: json["Pickup_Location_State_Or_Parish"],
        pickupLocationCountry: json["Pickup_Location_Country"],
        customerShippingAddress: json["Customer_Shipping_Address"],
        companyOrOrgName: json["Company_Or_Org_Name"],
        shippingAddress1: json["Shipping_Address1"],
        shippingAddress2: json["Shipping_Address2"],
        shippingArea: json["Shipping_Area"],
        shippingCity: json["Shipping_City"],
        shippingZipPostalCode: json["Shipping_Zip_Postal_Code"],
        shippingStateOrParish: json["Shipping_State_Or_Parish"],
        shippingCountry: json["Shipping_Country"],
        deliveyInfo: json["DeliveyInfo"],
        pmtMethod: json["PMT_Method"],
        serviceFee: json["Service_Fee"],
        totalCouponDiscount: json["Total_coupon_Discount"],
        orderTaxTotal: json["Order_Tax_Total"],
    );

   }
