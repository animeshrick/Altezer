class GetLists {
  final String message;
  final String status;
  final List<CountryList> countryList;
  final List<GenderList> genderList;
  final List<MonthDayList> monthDayList;
  final List<MonthNumberList> monthNumberList;
  final List<YearList> yearList;

  GetLists(
      {required this.message,
      required this.status,
      required this.countryList,
      required this.genderList,
      required this.monthDayList,
      required this.monthNumberList,
      required this.yearList});

  factory GetLists.fromJson(Map<String, dynamic> myjson) {
    return GetLists(
      message: myjson['message'],
      status: myjson['status'],
      countryList: (myjson['CountryList'] as List)
          .map((e) => CountryList.fromJson(e))
          .toList(),
      genderList: (myjson['Gender'] as List)
          .map((e) => GenderList.fromJson(e))
          .toList(),
      monthDayList: (myjson['Month_Day_Code'] as List)
          .map((e) => MonthDayList.fromJson(e))
          .toList(),
      monthNumberList: (myjson['Month_Number_Code'] as List)
          .map((e) => MonthNumberList.fromJson(e))
          .toList(),
      yearList: (myjson['Year_Number_Code'] as List)
          .map((e) => YearList.fromJson(e))
          .toList(),
    );
  }
}

class CountryList {
  int countryId;
  String countryName;

  CountryList({required this.countryId, required this.countryName});
  factory CountryList.fromJson(Map<String, dynamic> myjson) {
    return CountryList(
        countryId: myjson['country_Id'], countryName: myjson['Long_Name']);
  }
}

class GenderList {
  int genderId;
  String gender;

  GenderList({required this.genderId, required this.gender});
  factory GenderList.fromJson(Map<String, dynamic> myjson) {
    return GenderList(genderId: myjson['code_id'], gender: myjson['Long_name']);
  }
}

class MonthDayList {
  int monthDayId;
  String monthDay;

  MonthDayList({required this.monthDayId, required this.monthDay});
  factory MonthDayList.fromJson(Map<String, dynamic> myjson) {
    return MonthDayList(
        monthDayId: myjson['code_id'], monthDay: myjson['Long_name']);
  }
}

class MonthNumberList {
  int monthNumberId;
  String monthNumber;

  MonthNumberList({required this.monthNumberId, required this.monthNumber});
  factory MonthNumberList.fromJson(Map<String, dynamic> myjson) {
    return MonthNumberList(
        monthNumberId: myjson['code_id'], monthNumber: myjson['Long_name']);
  }
}

class YearList {
  int yearId;
  String year;

  YearList({required this.yearId, required this.year});
  factory YearList.fromJson(Map<String, dynamic> myjson) {
    return YearList(yearId: myjson['Code_Id'], year: myjson['Long_Name']);
  }
}
