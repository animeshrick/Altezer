class OrderTrackingModel {
    OrderTrackingModel({
         this.message,
         this.status,
         this.orderTrackingDetails,
    });

    final String? message;
    final String? status;
    final List<OrderTrackingDetail>? orderTrackingDetails;

    factory OrderTrackingModel.fromJson(Map<String, dynamic> json) => OrderTrackingModel(
        message: json["message"],
        status: json["status"],
        orderTrackingDetails: List<OrderTrackingDetail>.from(json["OrderTrackingDetails"].map((x) => OrderTrackingDetail.fromJson(x))),
    );
}

class OrderTrackingDetail {
    OrderTrackingDetail({
        required this.orderDeliveryId,
        required this.orderNumber,
        required this.deliveryTrackingNumber,
        required this.deliveryType,
        required this.trackingUrl,
        required this.notes,
        required this.deliveryStatus,
        required this.deliveryCompany,
        required this.deliveryFlag,
        required this.estimatedDeliveryDate,
        required this.firstName,
        required this.yjUserId,
        required this.deliveryDate,
        required this.deliveryTime,
        required this.deliveryupdatedlist,
    });

    final String orderDeliveryId;
    final String orderNumber;
    final String deliveryTrackingNumber;
    final String deliveryType;
    final String trackingUrl;
    final String notes;
    final String deliveryStatus;
    final String deliveryCompany;
    final String deliveryFlag;
    final String estimatedDeliveryDate;
    final String firstName;
    final String yjUserId;
    final String deliveryDate;
    final String deliveryTime;
    final List<Deliveryupdatedlist> deliveryupdatedlist;

    factory OrderTrackingDetail.fromJson(Map<String, dynamic> json) => OrderTrackingDetail(
        orderDeliveryId: json["Order_Delivery_Id"],
        orderNumber: json["Order_Number"],
        deliveryTrackingNumber: json["Delivery_Tracking_Number"],
        deliveryType: json["Delivery_Type"],
        trackingUrl: json["Tracking_URL"],
        notes: json["notes"],
        deliveryStatus: json["Delivery_Status"],
        deliveryCompany: json["Delivery_Company"],
        deliveryFlag: json["Delivery_Flag"],
        estimatedDeliveryDate: json["Estimated_Delivery_Date"],
        firstName: json["First_Name"],
        yjUserId: json["YJ_user_id"],
        deliveryDate: json["Delivery_Date"],
        deliveryTime: json["Delivery_time"],
        deliveryupdatedlist: List<Deliveryupdatedlist>.from(json["deliveryupdatedlist"].map((x) => Deliveryupdatedlist.fromJson(x))),
    );
}

class Deliveryupdatedlist {
    Deliveryupdatedlist({
        required this.deliveryUpdateId,
        required this.orderDeliveryId,
        required this.actionAndUpdate,
        required this.timeStamp,
        required this.isDelivered,
        required this.deliveryImageUrl,
        required this.orderNumber,
        required this.time,
        required this.deliveryStatus,
    });

    final String deliveryUpdateId;
    final String orderDeliveryId;
    final String actionAndUpdate;
    final String timeStamp;
    final String isDelivered;
    final String deliveryImageUrl;
    final String orderNumber;
    final String time;
    final String deliveryStatus;

    factory Deliveryupdatedlist.fromJson(Map<String, dynamic> json) => Deliveryupdatedlist(
        deliveryUpdateId: json["Delivery_Update_Id"],
        orderDeliveryId: json["Order_Delivery_Id"],
        actionAndUpdate: json["Action_And_Update"],
        timeStamp: json["Time_Stamp"],
        isDelivered: json["Is_Delivered"],
        deliveryImageUrl: json["Delivery_Image_URL"],
        orderNumber: json["Order_Number"],
        time: json["time"],
        deliveryStatus: json["Delivery_Status"],
    );
}
