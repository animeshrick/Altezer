class GetCategories {
  final String message;
  final String status;
  final List<CategoriesList> catList;

  GetCategories(
      {required this.message, required this.status, required this.catList});

  factory GetCategories.fromJson(Map<String, dynamic> myjson) {
    return GetCategories(
      message: myjson['message'],
      status: myjson['status'],
      catList: (myjson['CategoryList'] as List)
          .map((e) => CategoriesList.fromJson(e))
          .toList(),
    );
  }
}

class CategoriesList {
  final String prdName;
  final int prdId;

  CategoriesList({required this.prdId, required this.prdName});
  factory CategoriesList.fromJson(Map<String, dynamic> myjson) {
    return CategoriesList(
        prdId: myjson['Product_category_id'] as int,
        prdName: myjson['Name'] as String);
  }
}
