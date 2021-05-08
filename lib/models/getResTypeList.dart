import 'dart:convert';

GetResType getResTypeFromJson(String str) =>
    GetResType.fromJson(json.decode(str));

class GetResType {
  final String message;
  final String status;
  final List<ResTypelist> resTypelist;

  GetResType({
    required this.message,
    required this.status,
    required this.resTypelist,
  });

  factory GetResType.fromJson(Map<String, dynamic> json) => GetResType(
        message: json["message"],
        status: json["status"],
        resTypelist: List<ResTypelist>.from(
            json["ResTypelist"].map((x) => ResTypelist.fromJson(x))),
      );
}

class ResTypelist {
  final int codeId;
  final String restTypeName;

  ResTypelist({
    required this.codeId,
    required this.restTypeName,
  });

  factory ResTypelist.fromJson(Map<String, dynamic> json) => ResTypelist(
        codeId: json["code_id"],
        restTypeName: json["Long_name"],
      );
}
