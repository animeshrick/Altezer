class GetBankBranchList {
  GetBankBranchList({
    required this.message,
    required this.status,
    required this.branchlist,
  });

  final String message;
  final String status;
  final List<Branchlist> branchlist;

  factory GetBankBranchList.fromJson(Map<String, dynamic> json) =>
      GetBankBranchList(
        message: json["message"],
        status: json["status"],
        branchlist: List<Branchlist>.from(
            json["Branchlist"].map((x) => Branchlist.fromJson(x))),
      );
}

class Branchlist {
  Branchlist({
    required this.customerBankBranchId,
    required this.branchName,
  });

  final int customerBankBranchId;
  final String branchName;

  factory Branchlist.fromJson(Map<String, dynamic> json) => Branchlist(
        customerBankBranchId: json["Customer_bank_branch_Id"],
        branchName: json["Name"],
      );
}
