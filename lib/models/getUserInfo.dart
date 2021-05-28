class GetUserInfo {
  GetUserInfo({
    required this.message,
    required this.status,
    required this.userInfo,
  });

  final String message;
  final String status;
  final List<UserInfo> userInfo;

  factory GetUserInfo.fromJson(Map<String, dynamic> json) => GetUserInfo(
        message: json["message"],
        status: json["status"],
        userInfo: List<UserInfo>.from(
            json["userInfo"].map((x) => UserInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "userInfo": List<dynamic>.from(userInfo.map((x) => x.toJson())),
      };
}

class UserInfo {
  UserInfo({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
    required this.countryId,
    required this.countryName,
    required this.postalCode,
    required this.dobMonth,
    required this.monthName,
    required this.dobDay,
    required this.dayName,
    required this.dob,
    required this.sexCode,
    required this.genderName,
    required this.stateParishCode,
    required this.stateName,
    required this.phoneNumber,
    required this.dateAdded,
    required this.deleteFlag,
    required this.isCurrentlyLogon,
    required this.dobYear,
    required this.yearName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.requiredResetFlag,
    required this.firstQuestionId,
    required this.firstQuestion,
    required this.secondQuestionId,
    required this.secondQuestion,
    required this.thirdQuestionId,
    required this.thirdQuestion,
    required this.firstQuestionAnswer,
    required this.secondQuestionAnswer,
    required this.thirdQuestionAnswer,
    required this.userIdentificationType,
    required this.userIdentificationTypeNumber,
  });

  final int userId;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String countryId;
  final String countryName;
  final dynamic postalCode;
  final int dobMonth;
  final dynamic monthName;
  final int dobDay;
  final dynamic dayName;
  final dynamic dob;
  final int sexCode;
  final String genderName;
  final int stateParishCode;
  final String stateName;
  final String phoneNumber;
  final DateTime dateAdded;
  final bool deleteFlag;
  final bool isCurrentlyLogon;
  final int dobYear;
  final String yearName;
  final dynamic address1;
  final dynamic address2;
  final dynamic city;
  final bool requiredResetFlag;
  final int firstQuestionId;
  final dynamic firstQuestion;
  final int secondQuestionId;
  final dynamic secondQuestion;
  final int thirdQuestionId;
  final dynamic thirdQuestion;
  final String firstQuestionAnswer;
  final String secondQuestionAnswer;
  final String thirdQuestionAnswer;
  final dynamic userIdentificationType;
  final dynamic userIdentificationTypeNumber;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userId: json["User_Id"],
        firstName: json["First_Name"],
        lastName: json["Last_Name"],
        userName: json["User_Name"],
        password: json["Password"],
        countryId: json["Country_ID"],
        countryName: json["country_name"],
        postalCode: json["Postal_Code"],
        dobMonth: json["DOB_Month"],
        monthName: json["Month_name"],
        dobDay: json["DOB_Day"],
        dayName: json["Day_name"],
        dob: json["DOB"],
        sexCode: json["Sex_Code"],
        genderName: json["gender_name"],
        stateParishCode: json["State_Parish_Code"],
        stateName: json["state_name"],
        phoneNumber: json["Phone_Number"],
        dateAdded: DateTime.parse(json["Date_Added"]),
        deleteFlag: json["Delete_Flag"],
        isCurrentlyLogon: json["Is_Currently_Logon"],
        dobYear: json["DOB_Year"],
        yearName: json["Year_name"],
        address1: json["Address1"],
        address2: json["Address2"],
        city: json["City"],
        requiredResetFlag: json["Required_Reset_Flag"],
        firstQuestionId: json["First_Question_Id"],
        firstQuestion: json["first_question"],
        secondQuestionId: json["Second_Question_Id"],
        secondQuestion: json["second_question"],
        thirdQuestionId: json["Third_Question_Id"],
        thirdQuestion: json["third_question"],
        firstQuestionAnswer: json["First_Question_Answer"],
        secondQuestionAnswer: json["Second_Question_Answer"],
        thirdQuestionAnswer: json["Third_Question_Answer"],
        userIdentificationType: json["User_Identification_Type"],
        userIdentificationTypeNumber: json["User_Identification_Type_Number"],
      );

  Map<String, dynamic> toJson() => {
        "User_Id": userId,
        "First_Name": firstName,
        "Last_Name": lastName,
        "User_Name": userName,
        "Password": password,
        "Country_ID": countryId,
        "country_name": countryName,
        "Postal_Code": postalCode,
        "DOB_Month": dobMonth,
        "Month_name": monthName,
        "DOB_Day": dobDay,
        "Day_name": dayName,
        "DOB": dob,
        "Sex_Code": sexCode,
        "gender_name": genderName,
        "State_Parish_Code": stateParishCode,
        "state_name": stateName,
        "Phone_Number": phoneNumber,
        "Date_Added": dateAdded.toIso8601String(),
        "Delete_Flag": deleteFlag,
        "Is_Currently_Logon": isCurrentlyLogon,
        "DOB_Year": dobYear,
        "Year_name": yearName,
        "Address1": address1,
        "Address2": address2,
        "City": city,
        "Required_Reset_Flag": requiredResetFlag,
        "First_Question_Id": firstQuestionId,
        "first_question": firstQuestion,
        "Second_Question_Id": secondQuestionId,
        "second_question": secondQuestion,
        "Third_Question_Id": thirdQuestionId,
        "third_question": thirdQuestion,
        "First_Question_Answer": firstQuestionAnswer,
        "Second_Question_Answer": secondQuestionAnswer,
        "Third_Question_Answer": thirdQuestionAnswer,
        "User_Identification_Type": userIdentificationType,
        "User_Identification_Type_Number": userIdentificationTypeNumber,
      };
}
