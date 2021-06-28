class GetSubCatList {
  final String message, status;
  List<GetSubCateProductsList> dataList;

  GetSubCatList(
      {required this.message, required this.status, required this.dataList});

  factory GetSubCatList.fromJson(Map<String, dynamic> myjson) {
    return GetSubCatList(
      message: myjson['message'],
      status: myjson['status'],
      dataList: myjson['SubCategoryList']==null?[]: (myjson['SubCategoryList'] as List)
          .map((e) => GetSubCateProductsList.fromJson(e))
          .toList(),
    );
  }
}

class GetSubCateProductsList {
  final String prdName;
  final int prdCatSubId;

  GetSubCateProductsList({required this.prdCatSubId, required this.prdName});

  factory GetSubCateProductsList.fromJson(Map<String, dynamic> myjson) {
    return GetSubCateProductsList(
        prdCatSubId: myjson['product_category_sub1_Id'] as int,
        prdName: myjson['Name'] as String);
  }
}
