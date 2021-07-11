class MyOrderModel {
  MyOrderModel({
    required this.message,
    required this.status,
    required this.myOrderList,
  });

  final String message;
  final String status;
  final List<MyOrderList> myOrderList;

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
        message: json["message"],
        status: json["status"],
        myOrderList: List<MyOrderList>.from(
            json["MyOrderList"].map((x) => MyOrderList.fromJson(x))),
      );
}

class MyOrderList {
  MyOrderList({
    required this.productOrderId,
    required this.yjUserId,
    required this.notes,
    required this.ipAddress,
    required this.macAddress,
    required this.timeStamp,
    required this.orderStatus,
    required this.name,
    required this.orderStatusCode,
    required this.paymentMethodCode,
    required this.totalItems,
    required this.deliveryOption,
    required this.paymentMethod,
    required this.subTotal,
    required this.isOrderShiped,
    required this.orderItemStatusId,
    required this.orderAge,
  });

  final int productOrderId;
  final int yjUserId;
  final String? notes;
  final String ipAddress;
  final String macAddress;
  final String timeStamp;
  final String orderStatus;
  final String name;
  final int orderStatusCode;
  final int paymentMethodCode;
  final int? totalItems;
  final String deliveryOption;
  final String paymentMethod;
  final double? subTotal;
  final int isOrderShiped;
  final int? orderItemStatusId;
  final int orderAge;

  factory MyOrderList.fromJson(Map<String, dynamic> json) => MyOrderList(
        productOrderId: json["Product_Order_Id"],
        yjUserId: json["YJ_User_Id"],
        notes: json["Notes"],
        ipAddress: json["IP_Address"],
        macAddress: json["Mac_Address"],
        timeStamp: json["Time_Stamp"],
        orderStatus: json["Order_Status"],
        name: json["name"],
        orderStatusCode: json["order_status_code"],
        paymentMethodCode: json["Payment_Method_Code"],
        totalItems: json["total_items"] ?? 0,
        deliveryOption: json["Delivery_Option"],
        paymentMethod: json["Payment_Method"],
        subTotal: json["Sub_total"] ?? 0.0,
        isOrderShiped: json["is_Order_Shiped"],
        orderItemStatusId: json["Order_item_Status_Id"] ?? 0,
        orderAge: json["Order_Age"],
      );
}
