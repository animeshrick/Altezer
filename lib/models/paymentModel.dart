class PaymentModel {
    PaymentModel({
         this.message,
         this.status,
         this.orderId,
    });

    final String? message;
    final String? status;
    final int? orderId;

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        message: json["message"],
        status: json["status"],
        orderId: json["orderId"],
    );
}
