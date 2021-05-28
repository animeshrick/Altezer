class GetBankList {
  GetBankList({
    required this.message,
    required this.status,
    required this.banklist,
  });

  final String message;
  final String status;
  final List<Banklist> banklist;

  factory GetBankList.fromJson(Map<String, dynamic> json) => GetBankList(
        message: json["message"],
        status: json["status"],
        banklist: List<Banklist>.from(
            json["banklist"].map((x) => Banklist.fromJson(x))),
      );
}

class Banklist {
  Banklist({
    required this.customerBankId,
    required this.bankname,
  });

  final int customerBankId;
  final String bankname;

  factory Banklist.fromJson(Map<String, dynamic> json) => Banklist(
        customerBankId: json["Customer_bank_Id"],
        bankname: json["Name"],
      );
}
