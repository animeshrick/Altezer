class GetUserInfo {
    GetUserInfo({
        required this.message,
        required this.status,
        required this.userInfo,
    });

    final String message;
    final String status;
    final UserInfo userInfo;

    factory GetUserInfo.fromJson(Map<String, dynamic> json) => GetUserInfo(
        message: json["message"],
        status: json["status"],
        userInfo: UserInfo.fromJson(json["userInfo"]),
    );
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
        required this.dobYear,
        required this.yearName,
        required this.dob,
        required this.sexCode,
        required this.genderName,
        required this.stateParishCode,
        required this.stateName,
        required this.address1,
        required this.address2,
        required this.city,
        required this.requiredResetFlag,
        required this.phoneNumber,
        required this.firstQuestionId,
        required this.firstQuestion,
        required this.secondQuestionId,
        required this.secondQuestion,
        required this.thirdQuestionId,
        required this.thirdQuestion,
        required this.firstQuestionAnswer,
        required this.secondQuestionAnswer,
        required this.thirdQuestionAnswer,
    });

    final String userId;
    final String firstName;
    final String lastName;
    final String userName;
    final String password;
    final String countryId;
    final String countryName;
    final String postalCode;
    final String dobMonth;
    final String monthName;
    final String dobDay;
    final String dayName;
    final String dobYear;
    final String yearName;
    final String dob;
    final String sexCode;
    final String genderName;
    final String stateParishCode;
    final String stateName;
    final String address1;
    final String address2;
    final String city;
    final String requiredResetFlag;
    final String phoneNumber;
    final String firstQuestionId;
    final String firstQuestion;
    final String secondQuestionId;
    final String secondQuestion;
    final String thirdQuestionId;
    final String thirdQuestion;
    final String firstQuestionAnswer;
    final String secondQuestionAnswer;
    final String thirdQuestionAnswer;

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
        dobYear: json["DOB_Year"],
        yearName: json["Year_name"],
        dob: json["DOB"],
        sexCode: json["Sex_Code"],
        genderName: json["gender_name"],
        stateParishCode: json["State_Parish_Code"],
        stateName: json["state_name"],
        address1: json["Address1"],
        address2: json["Address2"],
        city: json["City"],
        requiredResetFlag: json["Required_Reset_Flag"],
        phoneNumber: json["Phone_Number"],
        firstQuestionId: json["First_Question_Id"],
        firstQuestion: json["first_question"],
        secondQuestionId: json["Second_Question_Id"],
        secondQuestion: json["second_question"],
        thirdQuestionId: json["Third_Question_Id"],
        thirdQuestion: json["third_question"],
        firstQuestionAnswer: json["First_Question_Answer"],
        secondQuestionAnswer: json["Second_Question_Answer"],
        thirdQuestionAnswer: json["Third_Question_Answer"],
    );

  }
