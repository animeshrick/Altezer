class ReciptModel {
  ReciptModel({
    required this.message,
    required this.status,
    required this.transactionslist,
  });

  final String message;
  final String status;
  final List<Transactionslist> transactionslist;

  factory ReciptModel.fromJson(Map<String, dynamic> json) => ReciptModel(
        message: json["message"],
        status: json["status"],
        transactionslist: json["Transactionslist"] == null
            ? []
            : List<Transactionslist>.from(json["Transactionslist"]
                .map((x) => Transactionslist.fromJson(x))),
      );
}

class Transactionslist {
  Transactionslist({
    required this.transactionId,
    required this.stripePaymentId,
    required this.amountPaid,
    required this.orderNumber,
    required this.serviceDescription,
    required this.stripePaymentDate,
  });

  final int transactionId;
  final String stripePaymentId;
  final double amountPaid;
  final int orderNumber;
  final String serviceDescription;
  final String stripePaymentDate;

  factory Transactionslist.fromJson(Map<String, dynamic> json) =>
      Transactionslist(
        transactionId: json["Transaction_Id"],
        stripePaymentId: json["Stripe_Payment_Id"],
        amountPaid: json["Amount_Paid"].toDouble(),
        orderNumber: json["Order_Number"],
        serviceDescription: json['Service_Description'],
        stripePaymentDate: json["Stripe_Payment_Date"],
      );
}
