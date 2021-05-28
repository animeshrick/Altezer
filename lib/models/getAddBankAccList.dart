class GetAddBankAccList {
    GetAddBankAccList({
        required this.message,
        required this.status,
        required this.banklist,
    });

    final String message;
    final String status;
    final List<AddBanklist> banklist;

    factory GetAddBankAccList.fromJson(Map<String, dynamic> json) => GetAddBankAccList(
        message: json["message"],
        status: json["status"],
        banklist: List<AddBanklist>.from(json["Banklist"].map((x) => AddBanklist.fromJson(x))),
    );
}

class AddBanklist {
    AddBanklist({
        required this.accountInfo,
        required this.customerBankAccountId,
        required this.nameOnAccount,
        required this.checkingAccountNumber,
        required this.driverLicensenOrIdNumber,
        required this.stateOrParishCode,
        required this.countryId,
        required this.timeStamp,
        required this.customerBankId,
        required this.customerBankBranchId,
        required this.nickName,
        required this.yjUserId,
        required this.bankName,
        required this.bankBranchName,
        required this.customerParish,
        required this.customerName,
        required this.accountNumber,
    });

    final String? accountInfo;
    final int customerBankAccountId;
    final String nameOnAccount;
    final String checkingAccountNumber;
    final String driverLicensenOrIdNumber;
    final int stateOrParishCode;
    final int countryId;
    final DateTime timeStamp;
    final int customerBankId;
    final int customerBankBranchId;
    final String nickName;
    final int yjUserId;
    final String? bankName;
    final String? bankBranchName;
    final String customerParish;
    final String customerName;
    final String accountNumber;

    factory AddBanklist.fromJson(Map<String, dynamic> json) => AddBanklist(
        accountInfo: json["Account_Info"] == null ? null : json["Account_Info"],
        customerBankAccountId: json["Customer_Bank_Account_Id"],
        nameOnAccount: json["Name_On_Account"],
        checkingAccountNumber: json["Checking_Account_Number"],
        driverLicensenOrIdNumber: json["Driver_Licensen_Or_ID_Number"],
        stateOrParishCode: json["State_Or_Parish_Code"],
        countryId: json["Country_Id"],
        timeStamp: DateTime.parse(json["Time_Stamp"]),
        customerBankId: json["Customer_bank_Id"],
        customerBankBranchId: json["Customer_bank_branch_Id"],
        nickName: json["Nick_Name"],
        yjUserId: json["YJ_User_Id"],
        bankName: json["Bank_Name"] == null ? null : json["Bank_Name"],
        bankBranchName: json["Bank_Branch_Name"] == null ? null : json["Bank_Branch_Name"],
        customerParish: json["Customer_Parish"],
        customerName: json["Customer_Name"],
        accountNumber: json['Account_Number'],
    );
}
