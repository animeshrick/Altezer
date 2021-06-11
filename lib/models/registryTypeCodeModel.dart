class ListTypeModel {
    ListTypeModel({
        required this.message,
        required this.status,
        required this.listType,
    });

    final String message;
    final String status;
    final List<ListType> listType;

    factory ListTypeModel.fromJson(Map<String, dynamic> json) => ListTypeModel(
        message: json["message"],
        status: json["status"],
        listType: List<ListType>.from(json["ListType"].map((x) => ListType.fromJson(x))),
    );
}

class ListType {
    ListType({
        this.codeId,
        this.registryTypeName,
    });

    final int? codeId;
    final String? registryTypeName;

    factory ListType.fromJson(Map<String, dynamic> json) => ListType(
        codeId: json["code_id"],
        registryTypeName: json["Long_name"],
    );
}
