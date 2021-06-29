class CancelOrderModel {
    CancelOrderModel({
        required this.message,
        required this.status,
        required this.cancelorder,
    });

    final String message;
    final String status;
    final List<CancelOrders> cancelorder;

    factory CancelOrderModel.fromJson(Map<String, dynamic> json) => CancelOrderModel(
        message: json["message"],
        status: json["status"],
        cancelorder: List<CancelOrders>.from(json["OrderTrackingDetails"].map((x) => CancelOrders.fromJson(x))),
    );
}

class CancelOrders {
    CancelOrders({
        required this.productOrderId,
        required this.userId,
        required this.firstName,
        required this.userName,
        required this.phoneNumber,
    });

    final int productOrderId;
    final int userId;
    final String firstName;
    final String userName;
    final String phoneNumber;

    factory CancelOrders.fromJson(Map<String, dynamic> json) => CancelOrders(
        productOrderId: json["Product_Order_Id"]??0,
        userId: json["User_Id"]??0,
        firstName: json["First_name"]??'',
        userName: json["User_name"]??'',
        phoneNumber: json["Phone_Number"]??'',
    );
}
